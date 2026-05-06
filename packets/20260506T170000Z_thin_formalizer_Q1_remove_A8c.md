# Thin formalizer — Q1: Can (A8c-attain) be removed for Branch B Tier 1?

You are the Formalizer. **Keep this pass thin.** The route memo and
`theorem_2_extension_proof_v4.md` already have the precise machinery.
The only deliverable for this pass is a **crisp formal statement of
Open Question 1**, with explicit quantifiers, hypotheses, and known
inputs from the existing proof record.

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.

## Target

State **Open Question 1 (Q1)** precisely.

## Output Format

```markdown
## Q1 — Removing (A8c-attain) for Branch B Tier 1

### Setting (recall)

(One paragraph: standing hypotheses + (A5-thick); Branch A landed
giving $\sigma^*\in\Sigma$ with $U(\sigma^*) = U^*$ and
$\inf_{\beta\in B} U(\beta,\sigma^*) = U^*$ via L6 bottom-density; what
(A8c-attain) was doing in Branch B Tier 1 — providing a Borel selector
$m^*$ from the rowwise argmin correspondence $D(s)$, hence the Dirac
adversary $\beta^* = \delta_{m^*(s)}$.)

### What's known without (A8c-attain)

(One paragraph: under standing + (A5-thick) alone, $\inf_B U(\cdot,\sigma^*) = U^*$
holds — that's L6. The question is whether this infimum is **attained**.
$D(s)$ may be empty for a positive-τ set of $s$ when $\ell(\cdot,s)$
is not l.s.c. and pointwise inf is not realized.)

### Q1 (formal)

**Question.** Under the standing hypotheses of Dworczak–Smolin (2026)
+ (A5-thick), does there exist $\beta^*\in B$ such that
$U(\beta^*,\sigma^*) = U^*$?

Equivalently: is the infimum
$\inf_{\beta\in B} U(\beta,\sigma^*) = U^*$ **attained** in the
unrestricted measurable-kernel space $B$?

(Note: any positive answer must work even when the rowwise argmin
correspondence $D(s)$ is empty on a positive-τ set — i.e., $\beta^*$
cannot be Dirac-shaped.)

### Open subquestions / scope of plausible attacks

1. **Stochastic kernel attainment.** Can a non-Dirac $\beta^*$ attain
   the inf via integration when no pointwise rowwise argmin exists?
2. **Tightness/compactness of $B$.** Is there a topology on $B$ in
   which $U(\cdot,\sigma^*)$ is l.s.c. AND $B$ is compact, distinct
   from the dead product-narrow Sion route?
3. **Honest negative.** Counterexample: a model satisfying standing
   + (A5-thick) where $\sigma^*$ is the Branch-A maximizer and
   $\inf_B U(\cdot,\sigma^*) = U^*$ is **not attained** in $B$.

### Things this pass will NOT attempt

(One sentence: this is a thin formalizer; literature search,
breakdown, and proof attempts come in subsequent passes.)
```

## Discipline

- Length budget: 400–800 words. Be crisp.
- Use paper-canonical notation throughout.
- Don't propose strategies — just state Q1 precisely.
- Identify the "scope of plausible attacks" enumeration as a roadmap
  for the literature/breakdown passes that come next, not as
  conjectures.
