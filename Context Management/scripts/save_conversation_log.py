#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


def now_stamp() -> str:
    return datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def load_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Save a proof conversation log as JSON.")
    parser.add_argument("--role", required=True)
    parser.add_argument("--chat-url", required=True)
    parser.add_argument("--packet-json", required=True)
    parser.add_argument("--packet-markdown", required=True)
    parser.add_argument("--response-file", required=True)
    parser.add_argument("--output-dir", required=True)
    parser.add_argument("--summary", default="")
    parser.add_argument("--status", default="captured")
    parser.add_argument("--next-step", required=True)
    parser.add_argument("--next-role", default="")
    parser.add_argument("--notes", default="")
    parser.add_argument("--branch", default="")
    parser.add_argument("--promote", action="append", default=[])
    parser.add_argument("--keep-temporary", action="append", default=[])
    parser.add_argument("--remove-durable", action="append", default=[])
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    packet_json_path = Path(args.packet_json)
    packet_md_path = Path(args.packet_markdown)
    response_path = Path(args.response_file)

    packet = load_json(packet_json_path)
    response_text = load_text(response_path)

    log = {
        "timestamp": now_stamp(),
        "role": args.role,
        "branch": args.branch,
        "chat_url": args.chat_url,
        "packet": {
            "packet_json": str(packet_json_path),
            "packet_markdown": str(packet_md_path),
        },
        "inputs": {
            "durable_project_sources": packet.get("durable_project_sources", []),
            "temporary_attachments": packet.get("temporary_attachments", []),
            "local_context_files": [item["path"] for item in packet.get("embedded_context", [])],
        },
        "response": {
            "raw_text": response_text,
            "summary": args.summary,
            "status": args.status,
        },
        "decision": {
            "next_step": args.next_step,
            "next_role": args.next_role,
            "notes": args.notes,
        },
        "context_updates": {
            "promote_to_durable_sources": args.promote,
            "keep_temporary": args.keep_temporary,
            "remove_from_durable_sources": args.remove_durable,
        },
    }

    branch_suffix = f"_{args.branch}" if args.branch else ""
    output_path = output_dir / f"{log['timestamp']}_{args.role}{branch_suffix}.json"
    output_path.write_text(json.dumps(log, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(output_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
