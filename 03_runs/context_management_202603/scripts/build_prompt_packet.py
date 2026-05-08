#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


def now_stamp() -> str:
    return datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")


def read_file(path: Path, max_chars: int) -> dict[str, Any]:
    del max_chars  # Compatibility only. Prompt packets are never truncated.
    text = path.read_text(encoding="utf-8")
    return {
        "path": str(path),
        "content": text,
        "truncated": False,
    }


def build_markdown(packet: dict[str, Any]) -> str:
    lines: list[str] = []
    lines.append(f"# Prompt Packet: {packet['role']}")
    lines.append("")
    if packet.get("branch"):
        lines.append(f"Branch: `{packet['branch']}`")
        lines.append("")
    if packet.get("scope"):
        lines.append("## Scope Of This Move")
        lines.append("")
        lines.append(packet["scope"])
        lines.append("")
    lines.append("## Goal")
    lines.append("")
    lines.append(packet["goal"])
    lines.append("")
    lines.append("## Hard Constraints")
    lines.append("")
    for item in packet["hard_constraints"]:
        lines.append(f"- {item}")
    lines.append("")
    lines.append("## Durable Project Sources Already In ChatGPT")
    lines.append("")
    for item in packet["durable_project_sources"]:
        lines.append(f"- `{item}`")
    lines.append("")
    if packet.get("durable_source_refresh_files"):
        lines.append("## Project Sources To Refresh Before This Chat")
        lines.append("")
        for item in packet["durable_source_refresh_files"]:
            lines.append(f"- `{item}`")
        lines.append("")
    lines.append("## Temporary Files To Attach In This Chat")
    lines.append("")
    for item in packet["temporary_attachments"]:
        lines.append(f"- `{item}`")
    lines.append("")
    lines.append("## Deliberately Excluded Context")
    lines.append("")
    for item in packet["excluded_context"]:
        lines.append(f"- `{item}`")
    lines.append("")
    lines.append("## Required Output")
    lines.append("")
    lines.append(packet["required_output"])
    lines.append("")
    if packet.get("proof_state_update_target"):
        lines.append("## Proof-State Update Target")
        lines.append("")
        lines.append(packet["proof_state_update_target"])
        lines.append("")
    lines.append("## Expected Next-Step Signal")
    lines.append("")
    lines.append(packet["expected_next_step_signal"])
    lines.append("")
    if packet["embedded_context"]:
        lines.append("## Embedded Local Context")
        lines.append("")
        for item in packet["embedded_context"]:
            lines.append(f"### FILE: {item['path']}")
            lines.append("")
            lines.append(item["content"])
            lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Build a JSON + Markdown prompt packet.")
    parser.add_argument("--role", required=True)
    parser.add_argument("--scope", default="")
    parser.add_argument("--goal", required=True)
    parser.add_argument("--required-output", required=True)
    parser.add_argument("--proof-state-update-target", default="")
    parser.add_argument("--expected-next-step-signal", required=True)
    parser.add_argument("--branch", default="")
    parser.add_argument("--output-dir", required=True)
    parser.add_argument("--name", default="")
    parser.add_argument("--max-chars-per-file", type=int, default=12000, help="Deprecated and ignored. Files are embedded in full.")
    parser.add_argument("--hard-constraint", action="append", default=[])
    parser.add_argument("--durable-source", action="append", default=[])
    parser.add_argument("--durable-source-file", action="append", default=[])
    parser.add_argument("--temporary-attachment", action="append", default=[])
    parser.add_argument("--excluded-context", action="append", default=[])
    parser.add_argument("--embed-file", action="append", default=[])
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    stamp = now_stamp()
    name = args.name or args.role
    stem = f"{stamp}_{name}"

    packet = {
        "timestamp": stamp,
        "role": args.role,
        "branch": args.branch,
        "scope": args.scope,
        "goal": args.goal,
        "hard_constraints": args.hard_constraint
        or [
            "No assumption smuggling.",
            "Any extra condition must be labeled Needed assumption.",
            "If the route fails, prefer a concrete obstruction or counterexample.",
            "Never truncate attached proof artifacts. If the move is too large, narrow the scope instead.",
        ],
        "durable_project_sources": args.durable_source,
        "durable_source_refresh_files": [str(Path(path).resolve()) for path in args.durable_source_file],
        "temporary_attachments": args.temporary_attachment,
        "excluded_context": args.excluded_context,
        "required_output": args.required_output,
        "proof_state_update_target": args.proof_state_update_target,
        "expected_next_step_signal": args.expected_next_step_signal,
        "embedded_context": [
            read_file(Path(path), args.max_chars_per_file) for path in args.embed_file
        ],
    }

    packet_json = output_dir / f"{stem}.json"
    packet_md = output_dir / f"{stem}.md"
    packet_json.write_text(json.dumps(packet, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    packet_md.write_text(build_markdown(packet), encoding="utf-8")

    print(packet_json)
    print(packet_md)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
