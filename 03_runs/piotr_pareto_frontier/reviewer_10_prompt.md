# Reviewer pass 10 — Verify FBNF capstone theorem

## Role

Fresh-chat reviewer on Prover 11's **FBNF capstone** from
`prover_11_response.md`. This is the |Ω|≥3 analog of the binary
capstone — if PASS, the FBNF class admits an unconditional
infinite-extension of Theorem 2 for α∈(0,1), arbitrary measurable M, Θ.

Companion durable sources: F1 (prover_08_response + reviewer_07),
F2 (prover_09_response + reviewer_08), F3 (prover_10_response +
reviewer_09_response), binary capstone (prover_07_response +
reviewer_06_response), v9 exposition, paper PDF.

## The capstone theorem (to verify)

**Theorem (FBNF infinite-extension of Theorem 2).** Under standing
hypotheses, |Ω|≥3, α∈(0,1), and primitive class FBNF-1...5 + FBNF-7,
there exists a robustly rationalizable optimal strategy for arbitrary
measurable M and Θ. FBNF-6 (fiberwise total balance) is derived from
optimality + F3.

Strategy pair $(\hat\sigma^*, \hat\beta^*)$ explicit:
- $\hat\sigma^*(m) = R(w^*(\Pi_T(m)))$ (TRS).
- $\hat\beta^*(\cdot|s)$ is pasted fiberwise from B1 kernels.

## Specific checks

### Steps 1-2 (TRS + endpoint-only image)
- Paper Theorem 1 + FBNF-2 give TRS in fibered form.
- F2 + FBNF-7 give global endpoint-only image.

### Steps 3-4 (stationarity + B1 lift)
- F3 gives FBNF-6 (fiberwise total balance).
- F1 (endpoint-fiber form) constructs the global kernel from
  fiberwise B1 kernels.

### Step 5-6 (Bayes-optimality + Definition 2)
- FBNF-4 gives Bayes-optimality at endpoint-fiber messages.
- Interior fiber messages are aligned-truthful; posterior = m;
  TRS continuation Bayes-optimal at m.

### Cross-cutting
- **FBNF-7 is primitive**, not derived: confirm.
- **FBNF-6 is derived**, not primitive: confirm.
- **No menu-Hall**: confirm.
- **Coverage examples** (spherical, affine MLR, polyhedral with
  scalarizable faces): verify each.
- **WTA ternary witness** correctly excluded by failure of FBNF-7:
  confirm.

## Verdict format
- PASS / PATCH_SMALL / PATCH_BIG / DISPROVED / HOLD.

## Output Contract
- Inline markdown.
- End with verdict + next-step.
- If PASS: confirm this is the |Ω|≥3 unconditional infinite-extension
  for the FBNF class, strictly weaker than menu-Hall.
