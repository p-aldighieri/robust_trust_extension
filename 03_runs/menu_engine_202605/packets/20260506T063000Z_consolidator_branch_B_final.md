# Consolidator pass — Branch B FINAL: Theorem 2 conditional extension

You are the Consolidator in the soft-scaffolding workflow.

## Your job

Assemble Branch A + Branch B into a **single coherent proof report**
delivering the **final conditional theorem**:

> **Theorem (Robust Trust Theorem 2 — infinite extension).** Under the
> standing hypotheses of Dworczak & Smolin (2026), plus
> **(A5):** $\pi(\cdot\mid\omega)\sim\tau$ for every $\omega\in\Omega$,
> and **(A8c-lsc):** for the Branch-A maximizer's value-preserving
> representative, $m\mapsto\ell_{\sigma^*}(m,s) := \sum_\omega s(\omega)\,p_\omega(m)$
> is lower semicontinuous on $M$ for τ-a.e. $s$, the existence direction
> of Theorem 2 extends to **infinite $M$ and infinite (compact metric)
> $\Theta$**:
>
> 1. There exists $\sigma^*\in\Sigma$ with
>    $U(\sigma^*) = U^* := \sup_{\sigma\in\Sigma} U(\sigma)$ (Branch A).
> 2. There exists $\beta^*\in B$ adversarial against $\sigma^*$:
>    $U(\beta^*,\sigma^*) = \inf_{\beta\in B} U(\beta,\sigma^*) = U^*$
>    (Branch B / L8 under (A8c-lsc)).
> 3. (When $\alpha > 0$.) $\hat\sigma^*(m) \in \arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$
>    for τ-a.e. $m\in M$ (Branch B / L9 under (A8c-lsc)).
>
> Hence $\sigma^*$ is **robustly rationalizable** in the sense of
> Definition 2, in the paper's a.e./on-path reading.

This is the **publishable conditional theorem** extending Dworczak–Smolin
Theorem 2 beyond finite $M$ and $\Theta$.

## Inputs

- `phil_reny_route_memo.md` — live route memo, all PROVED statuses.
- `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- `logs/20260506T030000Z_consolidator_branch_A_existence_response.md` —
  Branch A consolidator (already reviewer-PASS'd 2026-05-06).
- All L1–L9 prover and reviewer logs.

## Target

A clean, self-contained proof report — **the final theorem document**.
Structured for a mathematician who hasn't followed the orchestration.
Include both Branch A and Branch B, the Needed Assumptions (A5) and
(A8c-lsc), and an honest "Discussion" section addressing:
- Why (A5) is needed (perfect-revelation counterexample).
- Why (A8c-lsc) is needed (the $g(m) = m$ for $m>0$, $g(0) = 1$
  counterexample).
- Whether (A8c-lsc) can be relaxed (open problem).
- Comparison with the paper's finite-case proof.

## Output Format (use this exactly)

```markdown
# Robust Trust Theorem 2 — infinite-$M$, infinite-$\Theta$ conditional extension

## 1. Original Theorem 2 and the gap

(One paragraph. State Theorem 2 from the paper, including the finite
qualifier. Note that the optimality direction is finiteness-free; the
existence direction is the gap.)

## 2. Main Theorem (this paper)

**Theorem.** *Under the standing hypotheses of Dworczak–Smolin (2026)
— $\Omega$ finite with full-support prior $\mu_0$, $A$ and $\Theta$
compact metric, $u$ bounded and continuous in $a$, conditional
independence of $s$ and $\theta$ given $\omega$ — and the added
assumptions:*
- **(A5)** *$\pi(\cdot\mid\omega)\sim\tau$ for every $\omega\in\Omega$,*
- **(A8c-lsc)** *for the Branch-A maximizer's value-preserving
  representative $\hat\sigma^*$, the rowwise message payoff
  $\ell_{\sigma^*}(\cdot, s) := \sum_\omega s(\omega)\,p_\omega(\cdot)$
  is lower semicontinuous on $M$ for τ-a.e. $s$,*

*the existence direction of Theorem 2 holds for infinite $M$ and
infinite $\Theta$:*
1. *There exists $\sigma^*\in\Sigma$ with $U(\sigma^*) = U^*$.*
2. *There exists $\beta^*\in B$ adversarial against $\sigma^*$:
   $U(\beta^*,\sigma^*) = U^*$.*
3. *If $\alpha > 0$, $\hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma', P_{\beta^*}(\cdot\mid m))$
   for τ-a.e. $m\in M$.*

(Phrase precisely.)

## 3. Strategy

(Two-stage Phil Reny path. (Stage 1) Restricted-game existence of $\sigma^*$
via Mertens (1986) + Balder (1988); Lusin lift to all measurable
adversaries. (Stage 2) Adversary-side attainment of $\beta^*$ via
rowwise contact-selection under (A8c-lsc); per-message Bayes-optimality
via saddle + KRN.)

## 4. Definitions and Notation

(Cleanly: $\Omega$, $\mu_0$, $\pi(\cdot\mid\omega)$, $\tau$, $M$, $A$,
$\Theta$, $f$, $u$, $\alpha$, $\Sigma$, $B$, $F$, $U_F$, $U$, $U^*$,
$V^*$, $T_\lambda$, $K_n$, $K^*$, $\bar f$, $\lambda$, $\sigma^*$,
$p_\omega$, $\ell$, $\beta^*$, $m^*$, $q$, $P_{\beta^*}$.)

## 5. Proof — Branch A: existence of optimal $\sigma^*$ under (A5)

### Lemma L1 (constant-marginal continuity)
Statement, sketch citing Balder Theorem 2.2 p. 268.

### Lemma L2 (compactness of $\Sigma$)
Statement, sketch citing Balder §2 Theorem 2.3(a) + common-kernel
extraction.

### Lemma L7 ($\theta$ in the base)
Statement, sketch.

### Lemma L3+L4 (Mertens minmax + restricted-game $\sigma^*$)
Statement, sketch citing Mertens (1986) Cor B.

### Lemma L5 (Lusin-thick compacts under (A5))
Statement, sketch.

### Lemma L6 (Lusin lift contradiction)
Statement, sketch (smoothing kernel construction).

### Branch A capstone
Proof: $V^* = U^*$ via $F\hookrightarrow B$ + L6. $\sigma^*$ achieves $U^*$.

## 6. Proof — Branch B: adversary attainment under (A8c-lsc)

### Lemma L8a (restricted dual value formula)
$\inf_F U_F(\sigma^*,\varphi) = \text{const} + (1-\alpha)\int_M \operatorname*{essinf}_m \ell_{\sigma^*}(m,s)\,\tau(ds)$.

### Lemma L8c-Half-1 (pointwise inf = essential inf τ-a.e.)
Via Jankov–von Neumann + L6 bottom-density.

### Lemma L8c-Half-2 (pointwise attainment under (A8c-lsc))
Berge / measurable minimum + KRN selector.

### Lemma L8 ($\beta^*$ adversarial)
$\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)$ achieves $\inf_B U(\cdot,\sigma^*) = U^*$.

### Lemma L9 (per-message Bayes-optimality)
Decomposition + saddle + KRN.

## 7. Discussion

### Why (A5) is needed
Perfect-revelation counterexample: $\Omega = \{0,1\}$, $\pi(\cdot\mid\omega) = \delta_{\delta_\omega}$.
Without (A5), L5 support-thickness fails.

### Why (A8c-lsc) is needed
$\ell(m,s) = m$ for $m>0$, $\ell(0,s) = 1$ counterexample. Without
(A8c-lsc), the Lusin shells can have a τ-null upward jump, blocking
pointwise attainment of $\inf_m\ell$.

### Open: can (A8c-lsc) be relaxed?
The construction-side fix would be to build a Branch-A maximizer
with rowwise l.s.c. baked into the representative. This is open. The
current proof structure does not deliver such a representative.

### Comparison with paper's finite-case proof
Finite $M$, $\Theta$ ⇒ $B$, $\Sigma$ are products of finite simplices.
Sion 4.2' applies directly. Our extension via Mertens + Balder + Lusin
+ (A5) + (A8c-lsc) recovers the same conclusion in the infinite case.

## 8. Assumptions Used

- Standing (Dworczak–Smolin 2026).
- (A5): $\pi(\cdot\mid\omega)\sim\tau$ for every $\omega$.
- (A8c-lsc): rowwise l.s.c. message payoff for value-preserving
  representative.

## 9. Open questions

- Removal of (A8c-lsc).
- $\alpha = 0$ case for L9.
- Lean formalization (left as future work; the prior attempt's
  axiomatized GameSetup is structurally weaker than this proof).

## 10. References

- Dworczak & Smolin 2026.
- Balder 1988, Math. Op. Res. 13(2).
- Mertens 1986, Int. J. Game Theory 15(4).
- Aliprantis–Border 2006 (KRN, Berge, etc.).
- Bogachev 2007 (Lusin, disintegration).
```

## Discipline

- Use paper-canonical notation throughout.
- Cite each lemma's reviewer-passing log file by name (or by route-memo
  lemma label if logs are not visible).
- Sketches are 1–3 sentences each. Do not re-derive in full.
- Be honest about (A5) and (A8c-lsc) as added assumptions.
- Length budget: 3000–5000 words.

## Scope Policy

This is the FINAL consolidator pass. Produce the publishable theorem
document. Do not propose new lemmas.
