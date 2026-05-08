#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path


PROOF_ROOT = Path(
    "/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Economia/RA Piotr/robust_trust_extension"
)
CM_ROOT = PROOF_ROOT / "Context Management"
DEFAULT_MATHPIPE_ROOT = Path(
    "/Users/p-aldighieri/Library/CloudStorage/OneDrive-Personal/Codebook/MathPipeProver"
)
DEFAULT_PROJECT_URL = (
    "https://chatgpt.com/g/g-p-6992190183fc8191aec8b0c2fad5c017-robust-trust-proof/project"
)
DEFAULT_CDP_URL = "http://127.0.0.1:9222"


def utc_now() -> str:
    return datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")


def append_event(path: Path, payload: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("a", encoding="utf-8") as handle:
        handle.write(json.dumps(payload, ensure_ascii=True) + "\n")


def write_checkpoint(path: Path, lines: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def wait_for_response(
    response_file: Path,
    max_wait_seconds: int,
    poll_seconds: int,
    min_response_chars: int,
    events_file: Path,
    stage_name: str,
) -> str:
    deadline = time.time() + max_wait_seconds
    while True:
        if response_file.exists():
            text = response_file.read_text(encoding="utf-8")
            if len(text.strip()) >= min_response_chars:
                append_event(
                    events_file,
                    {
                        "timestamp": utc_now(),
                        "event": "response_ready",
                        "stage": stage_name,
                        "response_file": str(response_file),
                        "chars": len(text),
                    },
                )
                return text

        now = time.time()
        if now >= deadline:
            raise TimeoutError(
                f"Timed out waiting for {response_file} after {max_wait_seconds} seconds"
            )

        append_event(
            events_file,
            {
                "timestamp": utc_now(),
                "event": "poll_sleep",
                "stage": stage_name,
                "response_file": str(response_file),
                "sleep_seconds": poll_seconds,
                "seconds_remaining": int(deadline - now),
            },
        )
        time.sleep(poll_seconds)


def detect_next_role(response_text: str) -> tuple[str, str]:
    match = re.search(
        r"Suggested next local action:\s*(.+)",
        response_text,
        flags=re.IGNORECASE,
    )
    if not match:
        return "breakdown", "breakdown"

    action_text = match.group(1).strip()
    lowered = action_text.lower()
    if "review" in lowered:
        return "reviewer", action_text
    if "search" in lowered or "literature" in lowered:
        return "searcher", action_text
    if "consolid" in lowered:
        return "consolidator", action_text
    if "prove" in lowered or "prover" in lowered:
        return "prover", action_text
    if "breakdown" in lowered or "planner" in lowered:
        return "breakdown", action_text
    return "breakdown", action_text


def role_scope(role: str, action_text: str) -> str:
    if role == "prover":
        return "Execute only the first local lemma or decision named in the attached prior step."
    if role == "reviewer":
        return "Review only the newly attached proof draft and report local trust status plus narrow repair needs."
    if role == "searcher":
        return "Collect only the external or internal facts needed for the attached next local action."
    if role == "consolidator":
        return "Consolidate only the attached local result into a stable route note without broadening scope."
    return "Repair the route locally based on the attached prior step."


def role_goal(role: str, action_text: str) -> str:
    return (
        "Use the attached previous response as the controlling route memo and execute only its "
        f"suggested next local action: {action_text}"
    )


def role_required_output(role: str) -> str:
    if role == "prover":
        return (
            "Return only substantive markdown for the single local lemma or decision named in the attached prior step. "
            "If it fails, return an explicit obstruction or counterexample."
        )
    if role == "reviewer":
        return (
            "Return only substantive markdown reviewing the attached new draft: trust status, exact local gap if any, "
            "and a narrow repair recommendation."
        )
    if role == "searcher":
        return (
            "Return only substantive markdown listing the specific facts or references needed for the attached next local action."
        )
    if role == "consolidator":
        return (
            "Return only substantive markdown consolidating the attached local result into a stable route note."
        )
    return (
        "Return only a narrow markdown breakdown with at most 3 viable repaired routes, ranked best to worst, "
        "and a first local lemma or decision for the top route."
    )


def build_packet(
    role: str,
    action_text: str,
    previous_response_file: Path,
    working_route_note: Path,
    output_dir: Path,
    events_file: Path,
) -> Path:
    timestamp = utc_now()
    packet_name = f"autochain_{role}_{timestamp}"

    build_script = CM_ROOT / "scripts" / "build_prompt_packet.py"
    proof_state = CM_ROOT / "source_notes" / "proof_state.md"

    cmd = [
        sys.executable,
        str(build_script),
        "--role",
        role,
        "--branch",
        "autonomous_followup",
        "--scope",
        role_scope(role, action_text),
        "--goal",
        role_goal(role, action_text),
        "--required-output",
        role_required_output(role),
        "--proof-state-update-target",
        "Context Management/source_notes/proof_state.md",
        "--expected-next-step-signal",
        "Suggested next local action:",
        "--output-dir",
        str(output_dir),
        "--name",
        packet_name,
        "--hard-constraint",
        "Use the attached previous response as the controlling route memo.",
        "--hard-constraint",
        "Do not restart from settled finite-M work.",
        "--hard-constraint",
        "Do not broaden to a global proof attempt.",
        "--durable-source",
        "objective_statement.md",
        "--durable-source",
        "Robust_trust_Dworczak_Smolin.pdf",
        "--durable-source-file",
        str(proof_state),
        "--durable-source-file",
        str(working_route_note),
        "--temporary-attachment",
        str(previous_response_file),
    ]

    result = subprocess.run(
        cmd,
        check=True,
        capture_output=True,
        text=True,
    )
    lines = [line.strip() for line in result.stdout.splitlines() if line.strip()]
    if not lines:
        raise RuntimeError("build_prompt_packet.py did not return packet paths")
    packet_json = Path(lines[0])

    append_event(
        events_file,
        {
            "timestamp": utc_now(),
            "event": "packet_built",
            "role": role,
            "packet_json": str(packet_json),
            "previous_response_file": str(previous_response_file),
        },
    )
    return packet_json


def submit_and_wait(
    packet_json: Path,
    response_file: Path,
    mathpipe_root: Path,
    project_url: str,
    cdp_url: str,
    max_wait_seconds: int,
    poll_seconds: int,
    min_response_chars: int,
    events_file: Path,
    role: str,
) -> None:
    wrapper = CM_ROOT / "scripts" / "run_packet_with_browser_wait.py"
    cmd = [
        sys.executable,
        str(wrapper),
        "--packet-json",
        str(packet_json),
        "--response-file",
        str(response_file),
        "--mathpipe-root",
        str(mathpipe_root),
        "--project-url",
        project_url,
        "--cdp-url",
        cdp_url,
        "--max-wait-seconds",
        str(max_wait_seconds),
        "--poll-seconds",
        str(poll_seconds),
        "--stale-after-seconds",
        str(max(poll_seconds * 2, 1200)),
        "--min-response-chars",
        str(min_response_chars),
    ]

    append_event(
        events_file,
        {
            "timestamp": utc_now(),
            "event": "submit_start",
            "role": role,
            "packet_json": str(packet_json),
            "response_file": str(response_file),
        },
    )
    subprocess.run(cmd, check=True)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Autonomously continue the browser proof pipeline for a few chained steps."
    )
    parser.add_argument("--current-response-file", required=True)
    parser.add_argument("--current-stage-name", required=True)
    parser.add_argument("--project-url", default=DEFAULT_PROJECT_URL)
    parser.add_argument("--cdp-url", default=DEFAULT_CDP_URL)
    parser.add_argument("--mathpipe-root", default=str(DEFAULT_MATHPIPE_ROOT))
    parser.add_argument("--poll-seconds", type=int, default=600)
    parser.add_argument("--max-wait-seconds", type=int, default=5400)
    parser.add_argument("--min-response-chars", type=int, default=400)
    parser.add_argument("--max-followups", type=int, default=2)
    args = parser.parse_args()

    current_response_file = Path(args.current_response_file)
    mathpipe_root = Path(args.mathpipe_root)
    packets_dir = CM_ROOT / "packets"
    logs_dir = CM_ROOT / "logs"
    events_file = logs_dir / "autonomous_chain_events.jsonl"
    working_route_note = CM_ROOT / "source_notes" / "working_route_note.md"
    checkpoint_file = CM_ROOT / "source_notes" / "autonomous_chain_checkpoint.md"

    append_event(
        events_file,
        {
            "timestamp": utc_now(),
            "event": "autonomy_started",
            "current_stage_name": args.current_stage_name,
            "current_response_file": str(current_response_file),
            "max_followups": args.max_followups,
        },
    )

    current_text = wait_for_response(
        current_response_file,
        args.max_wait_seconds,
        args.poll_seconds,
        args.min_response_chars,
        events_file,
        args.current_stage_name,
    )

    shutil.copyfile(current_response_file, working_route_note)
    current_role, action_text = detect_next_role(current_text)
    write_checkpoint(
        checkpoint_file,
        [
            "# Autonomous Chain Checkpoint",
            "",
            f"- latest completed stage: `{args.current_stage_name}`",
            f"- latest completed response: `{current_response_file}`",
            f"- suggested next local action: `{action_text}`",
            f"- normalized next role: `{current_role}`",
        ],
    )

    previous_response = current_response_file
    previous_stage = args.current_stage_name
    next_role = current_role
    next_action_text = action_text

    for step_index in range(args.max_followups):
        packet_json = build_packet(
            next_role,
            next_action_text,
            previous_response,
            working_route_note,
            packets_dir,
            events_file,
        )

        timestamp = utc_now()
        response_file = logs_dir / f"{timestamp}_{next_role}_autochain_response.md"

        submit_and_wait(
            packet_json,
            response_file,
            mathpipe_root,
            args.project_url,
            args.cdp_url,
            args.max_wait_seconds,
            args.poll_seconds,
            args.min_response_chars,
            events_file,
            next_role,
        )

        response_text = wait_for_response(
            response_file,
            args.max_wait_seconds,
            args.poll_seconds,
            args.min_response_chars,
            events_file,
            f"{next_role}_{step_index}",
        )

        shutil.copyfile(response_file, working_route_note)
        previous_response = response_file
        previous_stage = f"{next_role}_{step_index}"
        next_role, next_action_text = detect_next_role(response_text)

        write_checkpoint(
            checkpoint_file,
            [
                "# Autonomous Chain Checkpoint",
                "",
                f"- latest completed stage: `{previous_stage}`",
                f"- latest completed response: `{previous_response}`",
                f"- suggested next local action: `{next_action_text}`",
                f"- normalized next role: `{next_role}`",
            ],
        )

    append_event(
        events_file,
        {
            "timestamp": utc_now(),
            "event": "autonomy_finished",
            "latest_stage": previous_stage,
            "latest_response_file": str(previous_response),
            "next_role_hint": next_role,
            "next_action_hint": next_action_text,
        },
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
