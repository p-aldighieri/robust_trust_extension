# Thin formalizer — Q2: Removing (TRE-gen-Hall) for general $|\Omega|\ge 3$

You are the Formalizer. **Keep this pass thin.** The route memo and
`theorem_2_extension_proof_v4.md` already have the precise machinery.
The only deliverable for this pass is a **crisp formal statement of
Open Question 2**, with explicit quantifiers and known inputs.

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- Q1 closure (negative endpoint): logs from
  `20260506T180000Z_*` and `20260506T184500Z_*`.

## Target

State **Open Question 2 (Q2)** precisely.

## Output Format

```markdown
## Q2 — Removing (TRE-gen-Hall) for general $|\Omega|\ge 3$

### Setting (recall)

(One paragraph: standing hypotheses + (A5-thick) + (A8c-attain). Branch
A and L8 give $\sigma^*\in\Sigma$ value-attaining and $\beta^*\in B$
rowwise adversarial. The L9 saddle gap means (TRE-gen-Hall) is needed
for Definition 2 robust rationalizability — specifically, the
posterior $P_{\gamma_\alpha}(\cdot\mid m)\in C(m)$ q-a.e.)

### What's known

(One paragraph: binary $\Omega = \{0,1\}$ verified via paper's
Appendix A.6 quantile transport. Ternary radial/spherical case via
Section 5.2 + Appendix A.10. General ternary FAILS without Hall.
The structural condition (TRE-gen-Hall) splits into:
- (TRE-gen): generalized trust region with continuous Bregman
  projection + monotone single-valued worst-message map.
- Hall: vector mass-balance / Strassen-type feasibility inequality.
Bare (TRE-gen) is not enough for $|\Omega|\ge 3$; the obstruction is
vector balance.)

### Q2 (formal)

**Question.** Under standing hypotheses + (A5-thick) + (A8c-attain), and
WITHOUT assuming (TRE-gen-Hall), does the per-message Bayes-optimality
clause of Definition 2 hold for the rowwise-adversary $\beta^* = \delta_{m^*(s)}$
constructed in L8? Equivalently: does
$P_{\beta^*}(\cdot\mid m) \in C(m)$ for q-a.e. $m$ hold automatically
in the RT model class for general finite $\Omega$ with $|\Omega|\ge 3$?

Or, alternative (weaker) form: can (TRE-gen-Hall) be **derived** from
a more primitive structural condition (e.g., the infinite-extension of
the paper's Theorem 1) for general $|\Omega|\ge 3$ — instead of being
imposed as a stand-alone assumption?

### Open subquestions / scope of plausible attacks

1. **Generalized Theorem 1 in infinite $M, \Theta$.** Does the paper's
   trust-region characterization extend to infinite $M$? If yes, does
   the resulting TR structure automatically satisfy the Hall inequality?
2. **Multi-dim quantile / OT generalization.** Does Appendix A.6's
   binary quantile transport generalize to higher $|\Omega|$ via
   Brenier maps or Knothe rearrangement?
3. **Honest negative.** Counterexample: a model with $|\Omega| = 3$
   satisfying standing + (A5-thick) + (A8c-attain) where the rowwise
   $\beta^* = \delta_{m^*(s)}$ has posterior NOT in $C(m)$ on a
   positive-q set, demonstrating that (TRE-gen-Hall) cannot be
   derived from those weaker conditions.

### Things this pass will NOT attempt

(One sentence: thin formalizer; literature search, breakdown, and
proof attempts come in later passes.)
```

## Discipline

- Length budget: 400–800 words.
- Use paper-canonical notation throughout.
- Don't propose strategies; state Q2 precisely.
