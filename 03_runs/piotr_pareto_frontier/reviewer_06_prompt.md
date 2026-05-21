# Reviewer pass 06 — Verify binary capstone theorem

## Role

You are an independent Reviewer (fresh chat). You are reading the
capstone assembly **L_B6** for the binary-state infinite-extension of
Theorem 2 from `prover_07_response.md` (durable source).

This is the load-bearing verification of the project's strongest
positive result so far: **unconditional infinite-extension of Theorem 2
for binary state |Ω|=2, α∈(0,1), arbitrary M and Θ** under three
economically meaningful primitive conditions (R-EE)+(R-TD)+(R-IES).

If this PASSes, the project has its first publishable theorem in the
substantive α∈(0,1) regime, **strictly generalizing the paper's
Theorem 2 for the binary state case from finite M, Θ to arbitrary
measurable M, Θ**.

Companion durable sources you may consult: `prover_05_response.md`
(L_B1 with PATCH_SMALL→PASS), `prover_06_response.md` (L_B3 PASS,
L_B5 PATCH_BIG→PASS under regularity), `reviewer_04_response.md`
(L_B1 verify), `reviewer_05_response.md` (L_B3+L_B5 verify),
`searcher_03_response.md` (binary route plan), `exposition_v9.tex`
(v9 with finite-menu T1), paper PDF.

## The capstone theorem (statement to verify)

**Theorem.** Under the standing hypotheses of *Robust Trust*, with
\(|\Omega| = 2\), \(\alpha \in (0, 1)\), and the three regularity conditions:

- **(R-EE)** Endpoint exposure: at the optimal TRS endpoints \(L, R\),
  the Bayes cones \(B_W(w_L)\) and \(B_W(w_R)\) are singletons \(\{L\}\)
  and \(\{R\}\) respectively.
- **(R-TD)** Tie discipline: \(\tau\) assigns zero mass to the
  indifference belief between profile \(w_L = w^*(L)\) and \(w_R = w^*(R)\).
- **(R-IES)** Interior endpoint stationarity: \(0 < L < R < 1\) (the
  optimal trust region is a proper interior subinterval).

There exists a robustly rationalizable optimal strategy for arbitrary
measurable \(M\) and \(\Theta\). The strategy pair is:

- **Agent**: TRS continuation \(\hat\sigma^*(m) = R(w^*(\Pi_{[L,R]}(m)))\).
- **Adversary**:
  \(\hat\beta^*(\cdot \mid s) = \kappa_L(\cdot \mid s)\) for \(s \in S_+\) (high source),
  \(\hat\beta^*(\cdot \mid s) = \kappa_R(\cdot \mid s)\) for \(s \in S_-\) (low source),
  \(\hat\beta^*(\cdot \mid s) = \delta_s\) for \(s \in N_0\) (τ-null tie set or
  other τ-null leftovers).

Where \(S_+\) and \(S_-\) are defined as endpoint minimizer regions on
all of \(M\) (not only outside \([L, R]\)) — this is the **kernel-branch
correction** the prover identifies as essential.

\(\kappa_L\) and \(\kappa_R\) come from Lemma B1 applied to the two
endpoints. The total-balance conditions \(\eta_L(M) = \nu_L(M)\) and
\(\eta_R(M) = \nu_R(M)\) come from Lemma L_B5.

## Specific checks

### Step 1: TRS interval reduction (cite L_B2 / paper Theorem 1)
- Verify paper Theorem 1 is applied correctly.
- Under (R-IES), confirm \(L, R\) are interior to \([0, 1]\).

### Step 2: Endpoint-only adversarial image (cite L_B3)
- Verify the misaligned BR concentrates on \(\{L, R\}\) under TRS
  \([L, R]\).
- **Critical**: this should hold for ALL misaligned sources \(s \in M\),
  not only \(s \notin [L, R]\). Interior sources \(s \in [L, R]\) also
  go to the endpoints under the MISALIGNED kernel (truthful interior
  reporting is the ALIGNED channel only).

### Step 3: Endpoint stationarity (cite L_B5 patched)
- Verify the total-balance equations
  \[\alpha\!\int_{[0,L]}\!(L-m)\,\tau(dm) = (1-\alpha)\!\int_{S_+}\!(s-L)\,\tau(ds)\]
  and the symmetric \(R\)-version follow from v9 T1 Clarke-Danskin
  Fermat under (R-EE) + (R-TD) + (R-IES).

### Step 4: Apply Lemma B1 on both fibers
- Verify that the total-balance conditions are exactly the
  \(\eta(A_-) = \nu(S_+) < \infty\) hypothesis of L_B1.
- Confirm L_B1's "no-extra-fiber-traffic" stipulation is respected
  in the kernel-branch correction: \(\kappa_L\) targets \(A_- = [0, L]\cap M\)
  and \(\kappa_R\) targets \(A_+ = [R, 1]\cap M\), with no cross-routing.

### Step 5: Verify Bayes-optimality q-a.e.
For each on-path message \(m\):
- \(m \in (L, R) \cap M\): only aligned-truthful contribution; posterior
  is \(m\); TRS continuation Bayes-optimal at \(m\) trivially.
- \(m = L\): posterior is \(L\) by L_B1 Claim 2; under (R-EE), \(B_W(w_L) = \{L\}\),
  so \(R(w_L)\) is Bayes-optimal at \(L\).
- \(m = R\): symmetric.
- \(m \notin M\): \(q(\{m\}) = 0\); vacuous.

### Step 6: Compare with v8 architecture
- v8 Tier 2 = exact-contact + menu-Hall.
- v9 binary capstone = (R-EE) + (R-TD) + (R-IES); does NOT use menu-Hall.
- Verify (R-EE)+(R-TD)+(R-IES) are NOT equivalent to (or stronger than)
  menu-Hall in binary state.

### Step 7: Sharpness compatibility
- v8 WTA ternary witness has \(|\Omega| = 3\). Binary capstone is
  \(|\Omega| = 2\) only. No conflict.

### Cross-cutting

- **No menu-Hall is assumed**: confirm.
- **No atomlessness of \(\tau\) beyond what (R-TD) imposes (no atom at
  the tie belief)**.
- **No density of \(\tau\)**: confirm.
- **No smoothness of utility beyond what (R-EE) imposes (singleton
  Bayes cone at endpoints, generic in finite-action models)**.

## Verdict format

State your verdict:
- **PASS** — capstone is correct; binary infinite-extension of
  Theorem 2 closes under (R-EE)+(R-TD)+(R-IES).
- **PATCH_SMALL** — small fixes needed; identify them.
- **PATCH_BIG** — substantive gap; state how.
- **DISPROVED** — central step broken; counterexample or
  fatal logical error.
- **HOLD** — need more information.

If PASS: confirm the publishable theorem statement and confirm the
three regularity conditions are NOT equivalent to menu-Hall.

If non-PASS: be precise about which lemma cite is wrong, which step is
broken, and what's needed.

## Output Contract

- Inline as plain markdown.
- This is fresh-context review; do NOT trust the prover's claims.
- The kernel-branch correction is the SINGLE most important
  verification: confirm misaligned mass routes only to endpoints, NOT
  to truthful interior messages.
- End with one-line verdict + next-step signal.

## Critical end-of-route question

If the binary capstone PASSes, the project has its first unconditional
substantive-regime infinite-extension. Per user instruction, the
pipeline should continue trying for the general \(|\Omega| \ge 3\)
case via fresh attack vectors. State in your next-step signal whether
the binary capstone gives any **transferable insight** for the
general case (e.g., what about the binary proof exploits binary
specifically, and what generalizes).
