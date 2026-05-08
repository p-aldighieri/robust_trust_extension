# Alternative Proof of Theorem 2 — Browser Orchestration

## Purpose

This folder manages the formalization and verification of Piotr Dworczak's alternative proof of Theorem 2 (Robustly Rationalizable Solution) from "Robust Trust" (Dworczak & Smolin, 2026).

The orchestrator is Claude Code. ChatGPT Pro (Extended) is the model endpoint. Local markdown files serve as the durable workflow state.

## Relationship To Other Projects

- **Paper**: `../Robust_trust_Dworczak_Smolin.pdf`
- **Alternative proof sketch**: `Robust trust_alternative proof_minimax theorem.pdf` (in this folder)
- **Extension project** (separate): `../Context Management/` — extends Theorem 2 beyond finite M and Θ. That is a DIFFERENT objective. Do NOT mix artifacts.

## Folder Structure

```
Theorem_alternative_proof/
├── objective_statement.md          # What we're proving
├── project_state.md                # Orchestration state
├── README.md                       # This file
├── Robust trust_alternative proof_minimax theorem.pdf  # Piotr's sketch
├── source_notes/
│   ├── proof_state.md              # Mathematical state of the formalization
│   └── (additional notes as created)
├── logs/                           # Timestamped interaction logs
├── packets/                        # Built role packets
├── templates/                      # Prompt and log templates
├── roles/                          # Role-specific context
├── schemas/                        # JSON schemas
└── scripts/                        # Local automation
```

## Orchestration Loop

Same as `Context Management/README.md`:
1. Read local state
2. Pick next proof role
3. Build packet locally
4. Open ChatGPT project, set Extended Pro
5. Attach temporary context
6. Send role prompt
7. Wait and poll (use heartbeat watcher MCP)
8. Log result
9. Update local context
10. Decide next move

## ChatGPT Project

- Name: `Robust Trust alternative proof`
- URL: `https://chatgpt.com/g/g-p-69b612c07c108191a7597062801a020e/project`

## Key Differences From The Extension Project

1. **Goal**: Verify an existing proof sketch, not create a new theorem.
2. **Scope**: Finite M and Θ (the infinite case is an exploratory question, not the main target).
3. **Approach**: FOC + envelope theorem, not Sion's minimax.
4. **Risk profile**: The sketch has known gaps. The primary value is identifying what works and what doesn't.
