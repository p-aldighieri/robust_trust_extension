# Objective conformance pass

## Role

Fresh-chat **objective conformance check**. Read both:
- `objective_statement.md` (durable source) — the original target.
- `consolidator_01_response.md` (durable source) — what we proved.

Compare end-to-end. Does what we proved actually match what was
asked? Or did we narrow the question?

## What to do

### Step 1 — Restate the original objective
From `objective_statement.md` extract:
- The precise claim (Theorem 2 of Robust Trust, both directions).
- The standing hypotheses (Ω finite, full-support μ_0, A, Θ compact
  metric, u bounded continuous in a, conditional independence).
- The infinite-extension target (relax finite M and finite Θ).
- The intended scope: α ∈ [0,1], all |Ω|.

### Step 2 — Restate what's been proved
From `consolidator_01_response.md`:
- Five theorems with their hypothesis classes.
- Phase (b) regularity verdict.
- Coverage table.

### Step 3 — Side-by-side comparison
For each direction of Theorem 2 (optimality direction and existence
direction), check:
- Did we prove it for the full intended scope?
- Did we narrow to subclasses (binary, FBNF, smooth)?
- Are the subclasses representative or restrictive?

### Step 4 — Verdict per scope dimension
For each dimension:
- α: covered (0,1) substantively? Yes/no.
- Ω: any |Ω|, or restricted?
- M: arbitrary measurable subset of Δ(Ω)?
- Θ: any compact metric?
- u: any bounded continuous in a, or restricted to smooth strict-concave?

### Step 5 — Classification
Output one of:
- **OBJECTIVE_MET**: full scope achieved with no narrowing.
- **OBJECTIVE_MET_WITH_TRIVIAL_REGULARITY**: minor regularity added
  (e.g., smoothness for the closed-graph + support-function-continuity
  package), but otherwise full scope.
- **OBJECTIVE_NARROWED**: we proved a strictly weaker question.
  Identify exactly which subclasses are NOT covered.
- **OBJECTIVE_MISSED**: we didn't prove the claim.

## Output Contract

- Inline markdown.
- Be specific. Don't sugarcoat.
- End with one-line classification + recommendation.

## Constraints

- This is an INDEPENDENT check, not advocacy.
- The user wants this rigorous before sending to Piotr.
