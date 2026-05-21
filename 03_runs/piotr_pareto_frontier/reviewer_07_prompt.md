# Reviewer pass 07 — Verify patched F1 (endpoint-fiber support)

## Role

Fresh-chat reviewer on the **patched F1** from
`prover_08_response.md` (durable source).

Verdict from Prover 08: **PATCH_BIG for literal F1; PASS for the
corrected endpoint-fiber F1**. The correction: kernel maps into the
ENDPOINT FIBER (interval $\ell_z([a_z, L(z)])$ for left, $\ell_z([R(z), b_z])$
for right), not into the singleton endpoint point $\{\ell_z(L(z))\}$.
Plus a Borel-chart/quotient-consistency clause.

This mirrors the binary capstone's L_B1 stipulation (no-extra-fiber-traffic).

## What you're reviewing

The patched F1 statement, parts (a'), (b'), (c'), and the Steps 1-6
proof in `prover_08_response.md`. Companion durable sources:
`prover_05_response.md` (L_B1), `reviewer_04_response.md`,
`prover_06_response.md`, `prover_07_response.md` (binary capstone),
`searcher_04_response.md` (FBNF route), v9 exposition, paper PDF.

## Specific checks

### Step 1 — Disintegration via FBNF-1
Verify the disintegration of τ over the foliation $\ell$ is standard
(Kallenberg or Aliprantis-Border).

### Step 2 — Apply L_B1 fiberwise
Verify the fiberwise application of L_B1 with $p = L(z), R(z)$ and
$A_-, A_+$ as ENDPOINT FIBERS (not singletons). Confirm:
- FBNF-6 gives the L_B1 hypothesis $\eta_z(A_-) = \nu_z(S_+)$.
- The resulting $\kappa_{L,z}$ is supported on $\ell_z([a_z, L(z)])\cap M$.

### Step 3 — Measurable pasting
Verify the Borel measurability of $z\mapsto\kappa_{L,z}, \kappa_{R,z}$
under the FBNF-1 foliation. The "Borel-chart/quotient-consistency"
clause: confirm what exactly this requires (probably: the foliation
charts $\ell_z$ are jointly Borel and the quotient $M\to Z$ is Borel).

### Step 4 — Fiber-preserving support
Verify (a') — the pasted kernel sends every source in fiber $z$ to
mass in the endpoint fibers of the SAME $z$ (FBNF-2).

### Step 5 — Calibration
The load-bearing step. Verify that for $q$-a.e. endpoint-fiber
message $m\in\ell_z([a_z, L(z)])$, the disintegration posterior
equals the BELIEF $\ell_z(L(z))$ — not the message belief $m$, but the
endpoint belief.

Wait: this is subtle. In binary, posterior at left-fiber message
$m\in[0, L]$ equals $L$ (the endpoint). In FBNF, posterior at
endpoint-fiber message $m = \ell_z(t)$ with $t\in[a_z, L(z)]$
should equal $\ell_z(L(z))$ (the fiber endpoint belief).

Verify this carefully via L_B1 Claim 2 (which gives posterior = $p$ on
left fiber $A_-$). Pull back via $\ell_z$ to get posterior =
$\ell_z(L(z))$.

### Step 6 — Bayes-optimality
Under FBNF-4 (fiberwise endpoint exposure), $\hat\sigma^*(m) = R(w_{z,L})$
is Bayes-optimal at posterior $\ell_z(L(z))$. Verify.

### Cross-cutting

- **No menu-Hall** anywhere; confirm.
- **FBNF-1 through FBNF-6** are essential and each used; identify
  which step.
- **Borel structure**: name every measurable-selection theorem invoked.

## Verdict format

- **PASS** — patched F1 is correct, FBNF route alive.
- **PATCH_SMALL** / **PATCH_BIG** / **DISPROVED** / **HOLD** otherwise.

## Output Contract

- Inline markdown.
- End with one-line verdict + next-step signal (F2? F3? F4?).
