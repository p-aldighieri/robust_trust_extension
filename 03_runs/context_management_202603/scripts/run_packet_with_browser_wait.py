#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import shlex
import subprocess
import time
from datetime import UTC, datetime
from pathlib import Path
from typing import Any


DEFAULT_MATHPIPE_ROOT = Path("/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver")
DEFAULT_PROJECT_URL = "https://chatgpt.com/g/g-p-6992190183fc8191aec8b0c2fad5c017-robust-trust-proof/project"
DEFAULT_CDP_URL = "http://127.0.0.1:9222"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Submit a packet through the browser runner and wait for completion.")
    parser.add_argument("--packet-json", help="Path to the packet JSON file built by build_prompt_packet.py")
    parser.add_argument("--response-file", required=True, help="Path to the markdown response file to write")
    parser.add_argument("--mathpipe-root", default=str(DEFAULT_MATHPIPE_ROOT))
    parser.add_argument("--project-url", default=DEFAULT_PROJECT_URL)
    parser.add_argument("--cdp-url", default=DEFAULT_CDP_URL)
    parser.add_argument("--max-wait-seconds", type=int, default=5400)
    parser.add_argument("--poll-seconds", type=float, default=5.0)
    parser.add_argument("--stale-after-seconds", type=float, default=120.0)
    parser.add_argument("--heartbeat-file", default="", help="Optional heartbeat JSON path. Defaults to the response-file sibling.")
    parser.add_argument("--wait-only", action="store_true", help="Do not submit. Just wait on an existing heartbeat/response pair.")
    parser.add_argument("--min-response-chars", type=int, default=200)
    parser.add_argument("--followup-command", default="", help="Optional shell command to run after a successful completion")
    return parser.parse_args()


def parse_iso8601(value: str) -> datetime | None:
    cleaned = value.strip()
    if not cleaned:
        return None
    if cleaned.endswith("Z"):
        cleaned = f"{cleaned[:-1]}+00:00"
    try:
        parsed = datetime.fromisoformat(cleaned)
    except ValueError:
        return None
    if parsed.tzinfo is None:
        return parsed.replace(tzinfo=UTC)
    return parsed.astimezone(UTC)


def load_heartbeat(path: Path) -> dict[str, Any] | None:
    if not path.exists():
        return None
    payload = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(payload, dict):
        raise ValueError(f"Heartbeat file must contain a JSON object: {path}")
    return payload


def response_ready(path: Path) -> bool:
    return path.exists() and bool(path.read_text(encoding="utf-8", errors="replace").strip())


def response_looks_suspicious(path: Path, min_response_chars: int) -> bool:
    if not path.exists():
        return True
    text = path.read_text(encoding="utf-8", errors="replace").strip()
    if not text:
        return True
    if text.startswith("http") and "\n" not in text:
        return True
    if min_response_chars > 0 and len(text) < min_response_chars:
        return True
    return False


def run_prepare_for_sources(
    *,
    mathpipe_root: Path,
    cdp_url: str,
    project_url: str,
    source_files: list[str],
) -> None:
    if not source_files:
        return

    browser_script = mathpipe_root / "scripts" / "chatgpt_browser_agent.sh"
    if not browser_script.exists():
        raise FileNotFoundError(f"Browser runner not found: {browser_script}")

    command = [
        str(browser_script),
        "prepare",
        "--cdp-url", cdp_url,
        "--project-url", project_url,
    ]
    for file_path in source_files:
        base_name = Path(file_path).name
        command.extend(["--remove-source", base_name])
    for file_path in source_files:
        command.extend(["--add-source", file_path])

    subprocess.run(command, check=True)


def recover_response_via_browser(
    *,
    mathpipe_root: Path,
    cdp_url: str,
    chat_url: str,
    response_file: Path,
    session_json: Path,
) -> None:
    if not chat_url:
        raise ValueError("Cannot recover response without a chat URL.")

    browser_script = mathpipe_root / "scripts" / "chatgpt_browser_agent.sh"
    if not browser_script.exists():
        raise FileNotFoundError(f"Browser runner not found: {browser_script}")

    command = [
        str(browser_script),
        "recover",
        "--cdp-url", cdp_url,
        "--chat-url", chat_url,
        "--response-file", str(response_file),
        "--log-json", str(session_json),
    ]
    subprocess.run(command, check=True)


def wait_for_completion(
    *,
    heartbeat_file: Path,
    response_file: Path,
    poll_seconds: float,
    stale_after_seconds: float,
    max_wait_seconds: float,
    submit_process: subprocess.Popen[str] | None,
) -> dict[str, Any]:
    deadline = time.monotonic() + max_wait_seconds

    while time.monotonic() < deadline:
        payload = load_heartbeat(heartbeat_file)
        if payload:
            status = str(payload.get("status", "")).strip() or "unknown"
            if status == "completed" and response_ready(response_file):
                return payload
            if status == "error":
                raise RuntimeError(str(payload.get("error", "Heartbeat reported an error.")))
            if status in {"starting", "submitted", "waiting_reply", "completed"} and stale_after_seconds > 0:
                heartbeat_at = parse_iso8601(str(payload.get("heartbeat_at", "")))
                if heartbeat_at is not None:
                    age_seconds = (datetime.now(tz=UTC) - heartbeat_at).total_seconds()
                    if age_seconds > stale_after_seconds:
                        raise TimeoutError(f"Heartbeat went stale at status={status} after {age_seconds:.1f}s.")

        if submit_process is not None and submit_process.poll() is not None:
            if submit_process.returncode == 0 and response_ready(response_file):
                return load_heartbeat(heartbeat_file) or {"status": "completed"}
            raise RuntimeError(f"Browser submit process exited early with code {submit_process.returncode}.")

        time.sleep(poll_seconds)

    raise TimeoutError(f"Timed out after {max_wait_seconds:.1f}s waiting for completion.")


def run_followup(
    *,
    followup_command: str,
    packet_json: Path | None,
    packet_md: Path | None,
    response_file: Path,
    session_json: Path,
    heartbeat_json: Path,
) -> None:
    if not followup_command:
        return

    env = os.environ.copy()
    env["RT_PACKET_JSON"] = str(packet_json) if packet_json else ""
    env["RT_PACKET_MD"] = str(packet_md) if packet_md else ""
    env["RT_RESPONSE_FILE"] = str(response_file)
    env["RT_SESSION_JSON"] = str(session_json)
    env["RT_HEARTBEAT_JSON"] = str(heartbeat_json)
    subprocess.run(followup_command, shell=True, check=True, env=env)


def main() -> int:
    args = parse_args()
    packet_json: Path | None = None
    packet_md: Path | None = None
    attachments: list[str] = []

    response_file = Path(args.response_file).resolve()
    response_file.parent.mkdir(parents=True, exist_ok=True)
    session_json = response_file.with_name(response_file.stem + "_session.json")
    heartbeat_json = Path(args.heartbeat_file).resolve() if args.heartbeat_file else response_file.with_name(response_file.stem + "_heartbeat.json")

    submit_process: subprocess.Popen[str] | None = None
    if not args.wait_only:
        if not args.packet_json:
            raise ValueError("--packet-json is required unless --wait-only is used.")
        packet_json = Path(args.packet_json).resolve()
        if not packet_json.exists():
            raise FileNotFoundError(f"Packet JSON not found: {packet_json}")
        packet_md = packet_json.with_suffix(".md")
        if not packet_md.exists():
            raise FileNotFoundError(f"Packet markdown not found: {packet_md}")

        packet = json.loads(packet_json.read_text(encoding="utf-8"))
        durable_source_files = [str(Path(item).resolve()) for item in packet.get("durable_source_refresh_files", [])]
        attachments = [str(Path(item).resolve()) for item in packet.get("temporary_attachments", [])]
        run_prepare_for_sources(
            mathpipe_root=Path(args.mathpipe_root).resolve(),
            cdp_url=args.cdp_url,
            project_url=args.project_url,
            source_files=durable_source_files,
        )

        browser_script = Path(args.mathpipe_root).resolve() / "scripts" / "chatgpt_browser_agent.sh"
        if not browser_script.exists():
            raise FileNotFoundError(f"Browser runner not found: {browser_script}")

        command = [
            str(browser_script),
            "submit",
            "--cdp-url", args.cdp_url,
            "--project-url", args.project_url,
            "--request-file", str(packet_md),
            "--response-file", str(response_file),
            "--log-json", str(session_json),
            "--heartbeat-json", str(heartbeat_json),
            "--poll-seconds", str(int(max(args.poll_seconds, 1))),
            "--max-wait-seconds", str(args.max_wait_seconds),
        ]
        for attachment in attachments:
            command.extend(["--attach-file", attachment])

        submit_process = subprocess.Popen(command)

    wait_for_completion(
        heartbeat_file=heartbeat_json,
        response_file=response_file,
        poll_seconds=args.poll_seconds,
        stale_after_seconds=args.stale_after_seconds,
        max_wait_seconds=args.max_wait_seconds,
        submit_process=submit_process,
    )

    if submit_process is not None:
        submit_process.wait(timeout=30)
        if submit_process.returncode != 0:
            raise RuntimeError(f"Browser submit process exited with code {submit_process.returncode}.")

    if not response_ready(response_file):
        raise FileNotFoundError(f"Expected response file was not written: {response_file}")

    if response_looks_suspicious(response_file, args.min_response_chars):
        heartbeat_payload = load_heartbeat(heartbeat_json) or {}
        chat_url = str(heartbeat_payload.get("chat_url", "")).strip()
        recover_response_via_browser(
            mathpipe_root=Path(args.mathpipe_root).resolve(),
            cdp_url=args.cdp_url,
            chat_url=chat_url,
            response_file=response_file,
            session_json=session_json,
        )

    if response_looks_suspicious(response_file, args.min_response_chars):
        raise RuntimeError(f"Recovered response still looks suspicious: {response_file}")

    run_followup(
        followup_command=args.followup_command,
        packet_json=packet_json,
        packet_md=packet_md,
        response_file=response_file,
        session_json=session_json,
        heartbeat_json=heartbeat_json,
    )

    first_line = response_file.read_text(encoding="utf-8").splitlines()
    preview = first_line[0] if first_line else "(empty response)"
    print(f"COMPLETED {response_file}")
    print(f"PREVIEW {preview}")
    if args.followup_command:
        print(f"FOLLOWUP {shlex.quote(args.followup_command)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
