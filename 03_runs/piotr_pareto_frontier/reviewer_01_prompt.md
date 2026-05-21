# Reviewer pass 01 — Verify Lemma 6 proof

## Role

You are an independent Reviewer for a smart-scaffolding proof project.
You are reading a Lemma 6 proof produced by a different Prover session.
Your job is to verify it carefully and return a verdict.

This is a **fresh chat**. You have not seen the Prover's work before.
The proof is in durable source `prover_01_response.md`. The full lemma
chain context is in `breakdown_01_response.md` (durable source). Other
durable sources: paper PDF, objective statement, prior attempts digest,
project closure memo, v8 proof, v8.2 exposition, route memo.

## What you are reviewing

**Lemma 6 (Integral Clarke-Danskin representation):**

Fix \(k\ge 1\) and \(\bar w = (w_1,\ldots,w_k)\in(\R^N)^k\). Let
\[
F_k(\bar w) \;=\; \int_M\!\phi_s(\bar w)\,\tau(ds), \quad
\phi_s(\bar w) \;=\; \alpha\max_i s\!\cdot w_i + (1-\alpha)\min_i s\!\cdot w_i.
\]
Then for every Clarke subgradient
\(g = (g_1,\ldots,g_k)\in\partial_C F_k(\bar w)\subseteq(\R^N)^k\),
there exist Borel measurable maps
\(\lambda^+, \lambda^- : M \to \Delta(k)\) such that for τ-a.e. \(s\in M\),
\(\operatorname{supp}\lambda^+(s)\subseteq\arg\max_j s\!\cdot w_j\),
\(\operatorname{supp}\lambda^-(s)\subseteq\arg\min_j s\!\cdot w_j\),
and for every \(i\in\{1,\ldots,k\}\),
\[
g_i \;=\; \alpha\!\int_M\lambda_i^+(s)\,s\,\tau(ds) \;+\; (1-\alpha)\!\int_M\lambda_i^-(s)\,s\,\tau(ds).
\]

Standing assumptions: \(\Omega\) finite (\(|\Omega| = N\)), \(M\subseteq\Delta(\Omega)\)
Borel, \(\tau\) probability measure on \(M\), \(\alpha\in[0,1]\). The
ambient L1–L5 statements are listed in `prover_01_response.md` and
proved/cited there.

## Your job — adversarial review

Read the proof carefully and adjudicate. You should be **skeptical**.
The team has spent two prior attempts on this theorem and stalled at the
calibration step; the formalizer and searcher concluded this Clarke-
Danskin route is the strongest available attack but also the most novel.
Verify rigorously.

### Specific checks

1. **Step 1: Clarke integral subdifferential interchange.**
   - Is the cited theorem (Clarke 1983 §2.7 Theorem 2.7.2 or equivalent)
     stated correctly?
   - Are its hypotheses verified completely? (Borel measurability of the
     integrand in \(s\), local Lipschitz in \(\bar w\) with uniform
     constant, integrability of Lipschitz modulus, finite measure.)
   - Does the conclusion produce the **closed Aumann integral** or the
     **uncloseed Aumann integral**? The proof claims the closure is
     removable in Step 2; verify the Step 1 statement is consistent.

2. **Step 2: Closedness of the Aumann integral in finite dimension.**
   - Is the cited result (Aumann 1965 / Hildenbrand 1974 / Aubin-
     Frankowska 1990) stated correctly?
   - Are the hypotheses (compact convex values + uniform integrable
     bound + measurability of the correspondence) verified?
   - The proof gives an alternate Dunford-Pettis argument. Is that
     argument correct, in particular the L¹/L∞ relationship and the
     continuity of integration?
   - Does the proof handle the case \(s\in M\setminus M_0\) (zero-
     measure exceptional set) correctly when later asserting
     "ξ(s) ∈ Ψ(s) for τ-a.e. s"?

3. **Step 3: Pointwise decomposition via L5.**
   - L5 is cited but not re-proved. Is the use of L5 correct as a
     pointwise fact (not as a measurable selection)?
   - Does the proof rely on L5 being applicable at *every* \(s\in M_0\)
     (not just τ-a.e.)?

4. **Step 4: Measurable selection of (λ⁺, λ⁻).**
   - This is the load-bearing step. The proof partitions M into Borel
     active-face cells \(E_{I,J}\) and applies KRN on each cell. Verify:
     - The cells are indeed Borel and form a partition.
     - The correspondence \(K_{I,J}(s)\) is correctly defined (handling
       both \(s\in M_0\) and \(s\notin M_0\)).
     - The graph of \(K_{I,J}\) is Borel.
     - The values are nonempty closed (use compactness of \(\Delta(I)\times\Delta(J)\)).
     - KRN / Castaing applies cleanly to deliver a Borel selector on
       each cell.
     - The pasted selector is Borel on the full \(M\).
   - **Critical check**: are the support constraints
     \(\operatorname{supp}\lambda^+(s)\subseteq\arg\max_j s\!\cdot w_j\)
     etc. preserved on positive-measure tie cells without atomlessness?

5. **Step 5: Putting it together.**
   - The integral identity is asserted from (2) + (3). Verify that
     (3) holds on a τ-full set, not just a.e., and that the integration
     step is valid.

6. **Sanity check.**
   - The k=2, N=2 example is explicit. Verify the computation by hand.
     If the lemma's formula gives the gradient at a regular point of
     \(F_k\), the answer should be the actual gradient. Confirm it.

7. **Cross-cutting concerns.**
   - Does the proof silently assume atomless τ anywhere? (It claims not.)
   - Does the proof require strict convexity / smoothness of \(W\)?
     (It should not — \(W\) does not even enter Lemma 6.)
   - Does the proof require finitely many ties / generic no-tie? (It
     should not.)
   - Does the proof avoid the banned moves? (No product-of-narrow Sion,
     no τ-AC restriction, no FOC + envelope.)

### Verdict format

State your verdict as one of:

- **PASS** — proof is correct, reviewer-cleared.
- **PATCH_SMALL** — proof is morally correct but needs small fixes (cite
  exactly which step and how to fix).
- **PATCH_BIG** — proof has a substantive gap that needs a real
  remediation pass.
- **DISPROVED** — the lemma is false, or the proof's central move is
  wrong in a way that no patch can fix. Give a counterexample.
- **HOLD** — you need more information to adjudicate; specify what's
  missing.

For PATCH_SMALL / PATCH_BIG: state precisely which step has the issue
and what the prover should produce to fix it. For DISPROVED: provide
the counterexample or the line of the proof that breaks.

## Output Contract

- Return everything inline in this chat as plain markdown.
- Be thorough: this is the load-bearing first lemma of the route.
- Be specific: cite section/equation numbers from `prover_01_response.md`
  when flagging issues.
- Do NOT just say "looks good" — your job is to find issues if they
  exist.
- End with: (a) one-line verdict, (b) one short paragraph of next-step
  signal (what the prover should do next: proceed to Lemma 7, or patch
  Lemma 6, or stop and re-think).

## Constraints

- Use only durable sources; do not request extra files.
- Stay focused on Lemma 6. If you notice issues in L1–L5 or in the
  downstream plan, flag them but do not rederive them.
- Banned tools list applies (`prior_attempts_digest.md`): no
  product-of-narrow Sion, no τ-AC restriction, no FOC + envelope, etc.
  Confirm the proof does not silently re-import these.
