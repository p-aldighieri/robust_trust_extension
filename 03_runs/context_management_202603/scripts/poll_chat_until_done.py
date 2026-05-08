#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import os
import subprocess
import time
from datetime import UTC, datetime
from pathlib import Path


DEFAULT_MATHPIPE_ROOT = Path("/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver")
DEFAULT_CDP_URL = "http://127.0.0.1:9222"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Poll a live ChatGPT chat until the reply is stable, then recover it locally.")
    parser.add_argument("--chat-url", required=True)
    parser.add_argument("--response-file", required=True)
    parser.add_argument("--mathpipe-root", default=str(DEFAULT_MATHPIPE_ROOT))
    parser.add_argument("--cdp-url", default=DEFAULT_CDP_URL)
    parser.add_argument("--poll-seconds", type=float, default=30.0)
    parser.add_argument("--max-wait-seconds", type=float, default=3600.0)
    parser.add_argument("--stable-polls", type=int, default=2)
    parser.add_argument("--min-response-chars", type=int, default=200)
    parser.add_argument("--followup-command", default="")
    return parser.parse_args()


def now_utc() -> str:
    return datetime.now(tz=UTC).isoformat().replace("+00:00", "Z")


def run_browser_command(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(args, check=True, text=True, capture_output=True)


def browser_script(mathpipe_root: Path) -> Path:
    path = mathpipe_root / "scripts" / "chatgpt_browser_agent.sh"
    if not path.exists():
        raise FileNotFoundError(f"Browser runner not found: {path}")
    return path


def inspect_chat(mathpipe_root: Path, cdp_url: str, chat_url: str) -> dict[str, object]:
    result = run_browser_command(
        str(browser_script(mathpipe_root)),
        "inspect",
        "--cdp-url", cdp_url,
        "--chat-url", chat_url,
    )
    return json.loads(result.stdout)


def recover_chat(mathpipe_root: Path, cdp_url: str, chat_url: str, response_file: Path, session_json: Path) -> None:
    run_browser_command(
        str(browser_script(mathpipe_root)),
        "recover",
        "--cdp-url", cdp_url,
        "--chat-url", chat_url,
        "--response-file", str(response_file),
        "--log-json", str(session_json),
    )


def response_ready(path: Path, min_chars: int) -> bool:
    if not path.exists():
        return False
    text = path.read_text(encoding="utf-8", errors="replace").strip()
    return len(text) >= min_chars and not (text.startswith("http") and "\n" not in text)


def notify(title: str, message: str) -> None:
    if os.uname().sysname != "Darwin":
        return
    escaped_title = title.replace('"', '\\"')
    escaped_message = message.replace('"', '\\"')
    subprocess.run(["osascript", "-e", f'display notification "{escaped_message}" with title "{escaped_title}"'], check=False)


def write_status(path: Path, payload: dict[str, object]) -> None:
    path.write_text(json.dumps(payload, indent=2) + "\n", encoding="utf-8")


def main() -> int:
    args = parse_args()
    mathpipe_root = Path(args.mathpipe_root).resolve()
    response_file = Path(args.response_file).resolve()
    response_file.parent.mkdir(parents=True, exist_ok=True)
    session_json = response_file.with_name(response_file.stem + "_session.json")
    poll_json = response_file.with_name(response_file.stem + "_poll.json")
    ready_json = response_file.with_name(response_file.stem + "_ready.json")

    started = time.monotonic()
    last_hash = ""
    stable_polls = 0

    while time.monotonic() - started < args.max_wait_seconds:
        info = inspect_chat(mathpipe_root, args.cdp_url, args.chat_url)
        current_hash = str(info.get("response_hash", ""))
        response_chars = int(info.get("response_chars", 0))
        generating = bool(info.get("generating", False))

        if current_hash and current_hash == last_hash and not generating and response_chars >= args.min_response_chars:
            stable_polls += 1
        else:
            stable_polls = 0

        last_hash = current_hash

        payload = {
            "status": "polling",
            "chat_url": info.get("chat_url", args.chat_url),
            "poll_at": now_utc(),
            "generating": generating,
            "response_chars": response_chars,
            "response_hash": current_hash,
            "stable_polls": stable_polls,
            "stable_required": args.stable_polls,
            "response_file": str(response_file),
        }
        write_status(poll_json, payload)

        if stable_polls >= args.stable_polls:
            recover_chat(mathpipe_root, args.cdp_url, args.chat_url, response_file, session_json)
            if response_ready(response_file, args.min_response_chars):
                done = {
                    "status": "completed",
                    "chat_url": args.chat_url,
                    "response_file": str(response_file),
                    "completed_at": now_utc(),
                    "response_sha256": hashlib.sha256(response_file.read_bytes()).hexdigest(),
                }
                write_status(ready_json, done)
                notify("Robust Trust chat complete", response_file.name)
                if args.followup_command:
                    env = os.environ.copy()
                    env["RT_RESPONSE_FILE"] = str(response_file)
                    env["RT_SESSION_JSON"] = str(session_json)
                    env["RT_CHAT_URL"] = args.chat_url
                    subprocess.run(args.followup_command, shell=True, check=True, env=env)
                print(json.dumps(done, indent=2))
                return 0

        time.sleep(args.poll_seconds)

    timeout_payload = {
        "status": "timeout",
        "chat_url": args.chat_url,
        "response_file": str(response_file),
        "timed_out_at": now_utc(),
    }
    write_status(poll_json, timeout_payload)
    notify("Robust Trust chat timeout", response_file.name)
    print(json.dumps(timeout_payload, indent=2))
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
