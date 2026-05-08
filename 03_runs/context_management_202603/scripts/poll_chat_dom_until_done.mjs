#!/usr/bin/env node

import fs from "node:fs/promises";
import path from "node:path";
import crypto from "node:crypto";
import { execFileSync } from "node:child_process";
import { chromium } from "/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver/scripts/chatgpt_browser_agent/node_modules/playwright/index.mjs";

function usage() {
  return `Usage: poll_chat_dom_until_done.mjs --chat-url URL --response-file PATH [options]

Options:
  --chat-url URL
  --response-file PATH
  --cdp-url URL                Default: http://127.0.0.1:9222
  --poll-seconds N             Default: 30
  --max-wait-seconds N         Default: 3600
  --stable-polls N             Default: 2
  --min-response-chars N       Default: 400
`;
}

function parseArgs(argv) {
  const args = {
    chatUrl: "",
    responseFile: "",
    cdpUrl: "http://127.0.0.1:9222",
    pollSeconds: 30,
    maxWaitSeconds: 3600,
    stablePolls: 2,
    minResponseChars: 400,
  };

  const rest = [...argv];
  if (rest.length === 0 || rest.includes("--help")) {
    console.log(usage());
    process.exit(0);
  }

  while (rest.length > 0) {
    const token = rest.shift();
    if (token === "--chat-url") {
      args.chatUrl = rest.shift() || "";
    } else if (token === "--response-file") {
      args.responseFile = rest.shift() || "";
    } else if (token === "--cdp-url") {
      args.cdpUrl = rest.shift() || "";
    } else if (token === "--poll-seconds") {
      args.pollSeconds = Number(rest.shift() || "30");
    } else if (token === "--max-wait-seconds") {
      args.maxWaitSeconds = Number(rest.shift() || "3600");
    } else if (token === "--stable-polls") {
      args.stablePolls = Number(rest.shift() || "2");
    } else if (token === "--min-response-chars") {
      args.minResponseChars = Number(rest.shift() || "400");
    } else {
      throw new Error(`Unknown argument: ${token}`);
    }
  }

  if (!args.chatUrl || !args.responseFile) {
    throw new Error("Missing --chat-url or --response-file.");
  }

  return args;
}

function nowUtc() {
  return new Date().toISOString();
}

async function latestAssistantText(page) {
  return await page.evaluate(() => {
    const articles = [...document.querySelectorAll('article[data-testid^="conversation-turn-"]')];
    const assistantTexts = [];

    for (const article of articles) {
      const clone = article.cloneNode(true);
      clone.querySelectorAll("button").forEach((button) => button.remove());
      const raw = (clone.innerText || "").trim();
      if (!raw) {
        continue;
      }

      const hasAssistantPrefix = /^ChatGPT said:/i.test(raw);
      if (!hasAssistantPrefix) {
        continue;
      }

      const cleaned = raw.replace(/^ChatGPT said:\s*/i, "").trim();
      if (!cleaned || /^Thought for\b/i.test(cleaned)) {
        continue;
      }
      assistantTexts.push(cleaned);
    }

    return assistantTexts.length > 0 ? assistantTexts[assistantTexts.length - 1] : "";
  });
}

async function isGenerating(page) {
  return await page.evaluate(() => {
    return [...document.querySelectorAll("button")].some((button) => {
      const label = `${button.getAttribute("aria-label") || ""} ${(button.innerText || "").trim()}`.toLowerCase();
      return label.includes("stop") || label.includes("pause");
    });
  });
}

async function writeJson(pathname, payload) {
  await fs.mkdir(path.dirname(pathname), { recursive: true });
  await fs.writeFile(pathname, `${JSON.stringify(payload, null, 2)}\n`, "utf8");
}

function notify(title, message) {
  try {
    execFileSync("osascript", ["-e", `display notification "${message.replaceAll('"', '\\"')}" with title "${title.replaceAll('"', '\\"')}"`]);
  } catch {
    // Best effort only.
  }
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  const responseFile = path.resolve(args.responseFile);
  const pollFile = responseFile.replace(/\.md$/i, "_poll.json");
  const readyFile = responseFile.replace(/\.md$/i, "_ready.json");
  const sessionFile = responseFile.replace(/\.md$/i, "_session.json");

  const browser = await chromium.connectOverCDP(args.cdpUrl);
  const context = browser.contexts()[0];
  if (!context) {
    throw new Error(`No browser context available at ${args.cdpUrl}.`);
  }

  const page = await context.newPage();
  await page.goto(args.chatUrl, { waitUntil: "domcontentloaded" });
  await page.waitForTimeout(3000);

  const started = Date.now();
  let lastText = "";
  let stable = 0;

  while (Date.now() - started < args.maxWaitSeconds * 1000) {
    let currentText = "";
    let generating = false;
    try {
      if (!page.url().includes("/c/")) {
        await page.goto(args.chatUrl, { waitUntil: "domcontentloaded" }).catch(() => {});
        await page.waitForTimeout(1500);
      }
      currentText = await latestAssistantText(page);
      generating = await isGenerating(page);
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      await writeJson(pollFile, {
        status: "polling",
        chat_url: page.url(),
        poll_at: nowUtc(),
        generating: true,
        response_chars: lastText.length,
        response_hash: crypto.createHash("sha256").update(lastText).digest("hex"),
        stable_polls: stable,
        stable_required: args.stablePolls,
        response_preview: lastText.slice(0, 240),
        response_file: responseFile,
        note: `transient poll error: ${message}`,
      });
      await page.waitForTimeout(2000);
      continue;
    }
    const sameAsLast = Boolean(currentText) && currentText === lastText;

    if (sameAsLast && !generating && currentText.length >= args.minResponseChars) {
      stable += 1;
    } else {
      stable = 0;
    }

    if (currentText.length >= lastText.length) {
      lastText = currentText;
    }

    const payload = {
      status: "polling",
      chat_url: page.url(),
      poll_at: nowUtc(),
      generating,
      response_chars: lastText.length,
      response_hash: crypto.createHash("sha256").update(lastText).digest("hex"),
      stable_polls: stable,
      stable_required: args.stablePolls,
      response_preview: lastText.slice(0, 240),
      response_file: responseFile,
    };
    await writeJson(pollFile, payload);

    if (stable >= args.stablePolls && lastText.length >= args.minResponseChars) {
      await fs.mkdir(path.dirname(responseFile), { recursive: true });
      await fs.writeFile(responseFile, `${lastText.trim()}\n`, "utf8");
      const readyPayload = {
        status: "completed",
        chat_url: page.url(),
        completed_at: nowUtc(),
        response_file: responseFile,
        response_sha256: crypto.createHash("sha256").update(lastText).digest("hex"),
      };
      await writeJson(readyFile, readyPayload);
      await writeJson(sessionFile, {
        command: "poll_chat_dom_until_done",
        chat_url: page.url(),
        response_file: responseFile,
        completed_at: readyPayload.completed_at,
        response_chars: lastText.length,
        response_text: lastText,
      });
      notify("Robust Trust chat complete", path.basename(responseFile));
      console.log(JSON.stringify(readyPayload, null, 2));
      await browser.close();
      return;
    }

    await page.waitForTimeout(args.pollSeconds * 1000);
  }

  const timeoutPayload = {
    status: "timeout",
    chat_url: page.url(),
    timed_out_at: nowUtc(),
    response_file: responseFile,
  };
  await writeJson(pollFile, timeoutPayload);
  console.log(JSON.stringify(timeoutPayload, null, 2));
  await browser.close();
  process.exit(1);
}

main().catch((error) => {
  console.error(error instanceof Error ? error.stack || error.message : String(error));
  process.exit(1);
});
