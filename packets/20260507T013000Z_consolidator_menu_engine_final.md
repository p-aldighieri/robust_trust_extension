# Consolidator pass — Menu engine final theorem (Phase C results integrated)

You are the Consolidator in the soft-scaffolding workflow.

## Your job

Assemble the Phase C results into a coherent **new** theorem statement
that supersedes the previous TRE-gen-Hall conditional structure
(`theorem_2_extension_proof_v5.md`).

The Phase C pivot delivers a strictly cleaner Tier 1 (no A5-thick, no
A8c-attain — ALL three previous added hypotheses for value-existence
and adversary-attainment are obsoleted) and a sharper Tier 2 (the
calibration condition is correctly framed as set-valued menu-Hall, with
a proven witness that bare set-valued mixing does NOT remove the
multi-dim vector-balance obstruction).

## Inputs

- Phase C breakdown (menu engine architecture):
  `logs/20260507T000000Z_breakdown_phase_C_menu_engine_response.md`.
- Phase C equivalence lemma (PROVED-CONDITIONAL on
  profile-realization sub-lemma):
  `logs/20260507T002000Z_prover_phase_C_equivalence_lemma_response.md`,
  reviewer `logs/20260507T010000Z_reviewer_phase_C_equivalence_lemma_response.md`.
- Phase C abort test (NEG verdict — set-valued mixing does not fix
  ternary non-radial Hall):
  `logs/20260507T002000Z_prover_phase_C_abort_test_response.md`,
  reviewer `logs/20260507T010000Z_reviewer_phase_C_abort_test_response.md`.
- Previous proof: `theorem_2_extension_proof_v5.md`.
- Paper PDF (Theorem 1 / Section 3.2 / Appendix A.1 for $W$ set;
  Section 5.2 / Appendix A.10 for spherical case).

## Target

A single proof report — the **new Tier 1 / Tier 2 theorem** with menu
engine — replacing the previous consolidator output. Format:

```markdown
# Robust Trust Theorem 2 — infinite-$M, \Theta$ extension via the payoff-profile menu engine

## 1. The setting and the question
(One paragraph; same as before but reframed for menu engine.)

## 2. Main theorem (two tiers, menu engine version)

**Theorem (Tier 1).** Under the standing hypotheses of Dworczak-Smolin
(2026), there exist $\sigma^*\in\Sigma$ and $\beta^*\in B$ with
$U(\sigma^*) = U^* = \sup_\sigma U(\sigma)$ and
$U(\beta^*,\sigma^*) = \inf_\beta U(\beta,\sigma^*) = U^*$.

(NO added hypotheses for Tier 1. This is strictly stronger than the
previous Tier 1 which required A5-thick + A8c-attain.)

**Theorem (Tier 2).** Under standing hypotheses + (menu-Hall): there
exists a coupling $\gamma_\alpha = \alpha(\mathrm{id},\mathrm{id})_\#\tau + (1-\alpha)\,\tau\otimes\kappa$
on $M\times M$ with $\kappa(\cdot\mid s)$ supported on the rowwise
minimizer correspondence $R(s) := \arg\min_{w\in C^*}s\cdot w$ for the
optimal menu $C^*$, and the induced posterior
$P_{\gamma_\alpha}(\cdot\mid m)$ lies in the Bayes cone $B(m) := \{\mu : \hat\sigma^*(m)\in\arg\max U(\hat\sigma',\mu)\}$
for $q$-a.e. $m$. Then $\sigma^*$ is robustly rationalizable in the
paper's a.e./on-path sense.

## 3. Why menu engine? (1 paragraph)
(Replaces Balder/Mertens/Lusin apparatus with finite-dimensional
$W$-geometry. Branch A's compactness + Mertens minmax + Lusin lift
were the wrong industrial machine; the right object is the compact
menu in finite-dim $W$.)

## 4. Definitions and notation
($W$, $\mathcal K(W)$, $F(C)$, $C^*$, $w^*$, $\beta^*$, $R(s)$, $B(m)$,
$\gamma_\alpha$, $q$.)

## 5. Proof — Tier 1 via the menu engine

### Lemma (menu-value equivalence).
$U^* = \sup_{C\in\mathcal K(W)} F(C)$, modulo a profile-realization
sub-lemma. Sketch + sub-lemma sketch.

### Lemma (menu existence).
$\mathcal K(W)$ is compact metrizable in Hausdorff topology; $F$ is
Lipschitz in $d_H$ (so continuous, in particular u.s.c.); compact +
u.s.c. ⇒ attainment. So $C^*\in\mathcal K(W)$ exists.

### Lemma (measurable labeling).
$m\mapsto w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$ admits a Borel
selector via Aliprantis-Border 18.13 (KRN). This delivers
$\sigma^*\in\Sigma$.

### Lemma (rowwise adversary attainment — A8c-attain automatic).
$R(s) := \arg\min_{w\in C^*}\,s\cdot w$ is nonempty closed for every
$s$ (compactness of $C^*$ in $\R^N$ + linear $w\mapsto s\cdot w$). KRN
gives a Borel selector $\bar w(s)\in R(s)$. Pulling back through
profile-realization gives $m^*(s)$ and $\beta^*(dm\mid s) = \delta_{m^*(s)}$.
$U(\beta^*,\sigma^*) = U^*$ by the rowwise-essential-inf identity.

### Tier 1 capstone.
$U(\sigma^*) = U^*$ and $U(\beta^*,\sigma^*) = U^*$ under standing
hypotheses alone.

## 6. Proof — Tier 2 via menu-Hall

### Lemma (Bayes cone $B(m)$).
$B(m)$ is closed convex (normal-cone slice of $W$ at $w^*(m)$).

### The L9 saddle gap (still real).
Branch A (= Tier 1) does not produce the upper saddle inequality
$U(\beta^*,\sigma) \le U(\beta^*,\sigma^*)$. The deterministic
worst-message selector $\bar w$ achieves the lower saddle but not the
upper saddle. Set-valued mixing over $R(s)$ does not fix this in
general (next subsection).

### Phase C abort test (sharpness witness for Tier 2).
**Claim.** The bare menu engine + standing hypotheses does NOT imply
posterior calibration $P_{\gamma_\alpha}(\cdot\mid m)\in B(m)$ for
$q$-a.e. $m$. The witness:
- $\Omega = \{0,1,2\}$, $A = \{a_0,a_1,a_2\}$ winner-takes-all, prior
  uniform, atomless full-support $\tau$, non-radial trust region
  $T = \{\mu : \mu(0)\le 0.4\}$.
- $C^* = \{v_0, v_1, v_2\}$ (three discrete profile vertices).
- $R(t_0) = \{v_1, v_2\}$ at boundary point $t_0 = (0.4, 0.3, 0.3)$.
- $B(t_0) = \{p : p_0\ge p_1, p_0\ge p_2\}$ (Bayes cone for $a_0$).
- Misaligned source mass at $t_0$ comes from $K_0^- = \{s : s_0\le s_1, s_0\le s_2\}$.
- Pointwise $s_1 - s_0\ge 0$, $s_2-s_0\ge 0$ on $K_0^-$. Conditional
  mean $\bar s$ inherits these inequalities. Forcing $\bar s\in B(t_0)$
  requires both inequalities to be equalities, i.e. $\bar s = (1/3,1/3,1/3)$
  a.s. With atomless $\tau$, no positive source mass concentrates on a
  point. Hence calibration fails.

This is the **sharpness witness for Tier 2**: bare menu structure does
not deliver upper-saddle calibration in $|\Omega|\ge 3$ non-radial
cases.

### Lemma (menu-Hall is the correct engineered hypothesis).
With menu-Hall imposed (the support-function form: for every $E\subseteq M$
and continuous affine $\phi$,
$\alpha\int_E\phi(m)\tau + (1-\alpha)\int_M\phi(s)\kappa(E\mid s)\tau \le \int_E h_{B(m)}(\phi)\,q$),
the calibration $P_{\gamma_\alpha}(\cdot\mid m)\in B(m)$ q-a.e. holds
by support-function duality. This is strictly milder than the
deterministic TRE-gen-Hall: $\kappa$ may mix over $R(s)$.

### Tier 2 capstone.
Under standing + menu-Hall, $\sigma^*$ is robustly rationalizable in
the paper's a.e./on-path sense.

## 7. What's tight, what's open

### Tight
- **Set-valued mixing does NOT fix the Hall obstruction** (Phase C
  abort test). The deterministic-vs-set-valued framing of TRE-gen-Hall
  was the wrong dichotomy.

### Open
- **Menu-Hall under additional structural conditions on $C^*$**:
  radial symmetry; zonotopal alignment; separability of Bayes cones;
  group-invariant trust region. Each of these may force menu-Hall
  automatically. Concrete classes from the paper (binary state,
  spherical via Section 5.2 + Appendix A.10) verify it.

## 8. Comparison with the paper's finite-case proof
(One paragraph: finite Sion gives the upper saddle for free via
finite-dim simplex compactness. The infinite-extension's analog of
Sion's "convex/concave-affine + compact" hypothesis is the convex
geometry of $W$; what's missing in general is the calibration step.)

## 9. Comparison with the previous v5 proof
(One paragraph: this version is strictly stronger on Tier 1 — no
A5-thick, no A8c-attain — and sharpens the Tier 2 obstruction by
correctly identifying it as multi-dim vector balance, not the
deterministic-vs-set-valued distinction. The conditional hypothesis is
renamed from TRE-gen-Hall to menu-Hall, and is strictly milder.)

## 10. References
(Same five primary refs as before: Dworczak-Smolin 2026, Balder 1988,
Mertens 1986, Aliprantis-Border 2006, Bogachev 2007. Note: Balder and
Mertens are no longer load-bearing for Tier 1 in this version — Tier 1
is finite-dimensional via $W$ — but they remain cited if the
profile-realization sub-lemma uses them.)
```

## Discipline

- Be honest about what changed. The new Tier 1 is genuinely stronger;
  the new Tier 2 has the same logical strength as the old (still
  conditional), but the conditional is framed correctly.
- The abort test is the sharpness witness for Tier 2's necessity. It
  demonstrates the deterministic-vs-set-valued distinction is not
  what matters.
- Length budget: 3000–4500 words. This is a proof report.
- All math reviewer-cleared in earlier passes.
