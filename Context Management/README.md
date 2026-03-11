# Robust Trust Browser Orchestration

## Purpose

This folder translates the MathPipeProver pipeline into a manual browser workflow for the ChatGPT project `Robust Trust proof`.

The orchestrator is Codex. ChatGPT is the model endpoint. Local markdown files replace the API run directory as the durable workflow state.

## What Must Be Preserved From MathPipeProver

MathPipeProver is still the reference design. The browser version must preserve:

1. Role-based prompting.
2. Explicit context handoff between roles.
3. A durable log of prompts, responses, and next-step decisions.
4. Branch awareness when multiple proof routes are alive.
5. Human-visible state so a future run can resume without rereading the whole repo.
6. A durable proof-state source that records the skeleton, lemma status, and what is actually proved.

The browser version can simplify:

1. No separate `workflow_router` model call. Codex decides the next step after reading the answer.
2. No provider API. The `external_agent` contract becomes manual interaction with ChatGPT in the browser.
3. No need to mirror every `runs/<run_id>/...` artifact. Only the artifacts that improve resumption and context control should be kept.

It should not simplify away high-value judgment:

1. Codex should still inspect route selection and branch pruning decisions.
2. Codex should still inspect each breakdown before prover cycles start.
3. Automation should handle file movement, polling, and logging, not replace proof-level routing judgment.

## Verified ChatGPT UI Contract

Verified in the live UI on March 10, 2026.

Project navigation:

1. Open [chatgpt.com](https://chatgpt.com).
2. In the left sidebar, open `Projects`.
3. Open `Robust Trust proof`.

Model / effort selection:

1. Inside the project, the top model picker shows families such as `Auto 5.4`, `Thinking 5.4`, and `Pro 5.4`.
2. The control that matters for this workflow is the composer pill immediately to the right of the `+` button.
3. Click `Pro`.
4. Select `Extended`.
5. Confirm the pill now reads `Extended Pro`.

Project sources:

1. The project page has `Chats` and `Sources` tabs.
2. The `Sources` tab exposes `Add sources`.
3. Existing sources can be removed through `Source actions -> Remove`.
4. As of March 10, 2026, the project already contains:
   - `objective_statement.md`
   - `Robust_trust_Dworczak_Smolin.pdf`

## Recommended Context Policy

Keep two layers of context:

1. Project-level durable sources.
   - These should stay attached to the project unless they become clutter.
   - Default durable set:
     - `objective_statement.md`
     - `Robust_trust_Dworczak_Smolin.pdf`
     - `Context Management/source_notes/proof_state.md`
     - optionally `project_brief.md`

2. Chat-level temporary context.
   - Use the `+` button in the composer for files needed only for the current role or branch.
   - Prefer temporary attachment for:
     - branch-specific notes
     - role-specific context files
     - recent logs
     - counterexample memos
     - provisional breakdowns

Rule: durable files define the project; temporary files define the current move.

Critical rule: never send truncated context. If a role needs a long proof artifact, attach the full file or split the role into a smaller cycle. Do not clip proof drafts, reviews, or breakdowns.

## Simplified Orchestration Loop

### 0. Read local state

Before opening ChatGPT, read:

- `project_state.md`
- the current role context file under `roles/`
- the latest log entry in `logs/`

### 1. Pick the next proof role

Use one of the proof roles:

- `formalizer`
- `literature`
- `searcher`
- `breakdown`
- `prover`
- `reviewer`
- `consolidator`

For this project, `formalizer` is mostly complete already. When a late-stage branch already exists, the starting point should be `reviewer` on the latest full prover artifact, not a fresh restart from `formalizer`.

Preferred cycle size:

- one route at a time
- one lemma block at a time
- one reviewer pass on one new proof block at a time
- one narrowly scoped prover target at a time

Preferred prover packet contents:

- the current route memo
- the active breakdown
- the exact reviewer delta being patched
- at most the one or two local notes needed for the current lemma

Avoid giving prover the whole branch history unless the task is final glue or consolidation.

Do not ask the model to dump an entire long existence proof in one sweep unless the branch is already stable and nearly complete.

### 2. Build the packet locally

Assemble a local packet before sending anything:

- role name
- scope of this move
- exact objective
- required context files
- explicit output request
- restrictions on new assumptions
- expected next-step signal
- proof-state update target

Use `templates/prompt_packet_template.md`.

If the packet is too large, do not truncate it. Reduce the scope of the role or move long working artifacts to file attachments.

Before sending any `breakdown` or `prover` packet, inspect it manually and confirm that it is only carrying the materials needed for the current step.

### 3. Open the project and set effort

1. Open the `Robust Trust proof` project.
2. Set the composer pill to `Extended Pro`.
3. Check whether the project-level sources are correct.

### 4. Attach temporary context if needed

Use the composer `+` only for files specific to the current step.

### 5. Send the role prompt

Paste the role packet into a new chat unless continuing a branch-specific chat is better.

Recommended rule:

- one active chat per branch/role family when continuity matters
- a fresh chat when the context has drifted or the role changes substantially

### 6. Wait and poll

The orchestrator is responsible for waiting. A simple first version is:

- after sending, poll the page periodically
- use a ten-minute interval if there is no immediate completion signal
- once the answer is stable, capture it locally

### 7. Log the result

For every completed interaction, create a timestamped markdown log in `logs/` using `templates/conversation_log_template.md`.

Minimum fields:

- timestamp
- project URL or chat URL
- role
- packet inputs
- response summary
- exact next-step decision
- files to promote into durable context
- files to keep temporary

### 8. Update local context

After logging:

1. Update the relevant `roles/<role>/context.md`.
2. Update `project_state.md`.
3. Update `source_notes/proof_state.md`.
4. If a file should become durable project context, add it in the project `Sources` tab.
5. If a durable file is now noise, remove it from project sources and keep it only locally.

### 9. Decide the next move

Codex, not ChatGPT, decides whether to:

- continue in the same role
- hand off to another role
- split into branches
- terminate a dead route

Codex should also explicitly approve:

- route-selection decisions
- branch-pruning decisions
- any new or amended breakdown before the next prover cycle starts

## Current Project Status

The local repo already contains high-value prep:

- `objective_statement.md`
- `project_brief.md`

The workflow is intentionally starting from a clean baseline. Older draft path notes and archive materials can live in git history rather than in the active working set.

Current correction after the first live runs:

- the old `main` and `route_2` reviewer packets were tainted by internal context truncation
- re-reviews must be run on the full prover files
- the next restart should pick up from the late-stage `main` and `route_2` artifacts, not from `formalizer`

## Recommended Immediate Starting Point

Skip `formalizer` unless the target theorem changes.

Recommended next sequence:

1. `reviewer`: rerun review on the full `main` prover artifact.
2. `reviewer`: rerun review on the full `route_2` prover artifact.
3. `prover`: patch only the reviewer-identified missing lemma block or glue step.
4. `reviewer`: validate that delta before continuing.

## Skills Needed

The workflow now benefits from three reusable skill bundles:

1. `chatgpt-project-browser`
   - open a project
   - switch `Pro` to `Extended`
   - manage project sources

2. `proof-run-logger`
   - save each chat result as a local markdown record
   - update `project_state.md`
   - keep branch naming consistent

3. `context-packet-builder`
   - assemble the role packet from the current context files
   - distinguish durable project sources from temporary chat attachments

The first skill is created in Codex local skills as part of this setup. The second and third can be added later if repetition justifies them.

## Local Automation Added

The local state side is now scriptable.

Scripts:

- `scripts/build_prompt_packet.py`
  - creates a JSON packet and a Markdown packet ready to paste into ChatGPT
  - embeds selected local files

- `scripts/save_conversation_log.py`
  - saves the full response and next-step decision as JSON

Schema:

- `schemas/conversation_log.schema.json`

These scripts automate packet creation and logging without touching the browser. Browser-side source management and chat submission are feasible with Playwright, but should be scripted only after one real run confirms the selectors are stable enough.
