# Planning pass — Branch B (L8: produce adversarial $\beta^*$)

You are advising on Branch B of the Theorem 2 infinite-extension
project. **Branch A is complete:** under standing + (A5), there exists
$\sigma^*\in\Sigma$ with $U(\sigma^*) = U^* = V^*$ (existence-of-optimal-agent-strategy).

**Branch B is the genuinely open hard step.** It has two pieces:
- **L8 (adversary attainment):** Show there exists $\beta^*\in B$ with
  $U(\beta^*,\sigma^*) = \inf_\beta U(\beta,\sigma^*) = U^*$.
- **L9 (per-message Bayes-optimality):** Given $\beta^*$ from L8, show
  $\hat\sigma^*(m)\in\arg\max_{\hat\sigma'} U(\hat\sigma',P_{\beta^*}(\cdot\mid m))$
  for every (or τ-a.e.) $m\in M$ — the Definition 2 condition.

Phil Reny's email explicitly acknowledges that his Lusin route delivers
$\sigma^*$ but **not** $\beta^*$. The previous attempts in
`prior_attempts_digest.md` got blocked precisely on the adversary-side
attainment problem (escape of mass, broken continuity in $\beta$).
**The product-narrow + Sion approach in $\prod_\mu \Delta(M)$ is dead.**

This is **not** a proof pass. It is a planning/structuring pass to pick
the right Branch B route before committing to a prover sequence. The
output will become a Branch B route memo (durable source) that the
prover passes will work from.

## Inputs

- `phil_reny_route_memo.md` — Branch A is closed; L8 entry already lists
  three candidate techniques; L9 entry sketches the issue.
- `phil_reny_bundle.md` — Phil's contribution.
- `prior_attempts_digest.md` — what's banned. Read carefully — escape of
  mass is real.
- `Robust_trust_Dworczak_Smolin.pdf` — the paper.
- `objective_statement.md` — original goal.

## What you must produce

A single markdown deliverable in the response body, with **exactly** the
following sections:

```markdown
## 1. The L8 problem precisely

(State L8 in paper notation. Explicitly note: $V^* = U^*$ is known from
Branch A, so we want the *infimum* on the unrestricted side to be
*attained*, not just to equal $V^*$. This is a genuine attainment
question, not a value-equality question.)

## 2. Why product-narrow attainment is forbidden

(Recall the prior-attempts diagnosis: escape of mass on countable-atomic;
broken Lemma 4.4 continuity-in-β for bounded measurable g. Spell out
precisely which structural feature causes failure.)

## 3. Three candidate techniques — evaluate each honestly

### 3a. Direct hyperplane / supporting-functional construction

(Idea: From Branch A, $\sigma^*$ secures $U^*$ against every $\beta\in B$.
The set $\{\beta\in B: U(\beta,\sigma^*) \le U^*\}$ is nonempty if and
only if $\sigma^*$ is exactly value-securing, which we have. We need an
actual minimizer. Approach: separate $\sigma^*$ from the closed convex
*image* set $\{U(\cdot,\sigma^*): \beta\in B\}$ on the value $U^*$. For
each ε, find $\beta_\varepsilon$ with $U(\beta_\varepsilon,\sigma^*) \le U^* + \varepsilon$.
Then check whether the family $(\beta_\varepsilon)$ has a tight
sub-net or Young-measure limit that attains the infimum.)

(Honest evaluation: does this work? Where might it inherit the dead
escape-of-mass obstruction? Tightness of $(\beta_\varepsilon)$ in some
Young-measure sense without using product-narrow on $\prod_\mu\Delta(M)$
is the technical question. Refer to Balder (1988) §3 on existence of
behavioral-strategy equilibria as a possible analogue.)

### 3b. Dual extreme-point construction from L4

(Idea: The Mertens minmax in L3+L4 yields the dual minimizer over
finite-support probabilities on $F$. Extract an extreme-point selector
that disintegrates into a τ-density $\varphi^*$, and check whether
$\beta_{\varphi^*}\in B$ attains the infimum or only approximates it.)

(Honest evaluation: This produces a *restricted-game* minimizer, not an
unrestricted one. Closing the gap requires either equating the two
games at the inf side — which Branch A's $V^* = U^*$ partly does at the
sup side — or proving that any near-minimizer in $B$ has an approximating
$\varphi$-element in $F$. Since L6 already establishes the latter,
this might in fact close: any near-$U^*$-minimizing $\beta$ admits a
near-$U^*$-minimizing $\varphi_\varepsilon$ in $F$, and if the
finite-support Mertens minimizer over $F$ is itself attained in $F$,
the inf is achieved. Investigate.)

### 3c. Coarsened adversary class $B' \supseteq F$

(Idea: Embed into a class $B'\supset F$ on which compactness/attainment
is automatic — e.g., the Balder stable transition probabilities indexed
by τ on $M$. Prove (i) $\inf_{B'} U(\cdot,\sigma^*) = \inf_F U_F(\sigma^*,\cdot) = V^* = U^*$,
(ii) $B'$-attainment is straightforward by compactness on the τ-base,
(iii) the $B'$-minimizer pulls back to $B$ via Radon-Nikodym
disintegration.)

(Honest evaluation: The class $B'$ should be the Balder-stable kernels
into $M$ from $M$, against the τ-base, modulo τ-a.e. equivalence. This
is **not** $\prod_\mu\Delta(M)$. The compactness comes from Balder
Theorem 2.3(a) applied to $M\to M$ kernels with finite τ-base.
Investigate whether this delivers the actual $\beta^*$ in $B$ or only
in a quotient.)

## 4. Ranked recommendation

(Pick the most viable of 3a, 3b, 3c. Justify in 1 paragraph. Identify
the next prover target as a single concrete L8 sub-lemma the prover
can attempt.)

## 5. L9 outlook

(Brief: once L8 lands, what does L9 need? Disintegration of the
saddle-point property + measurable selection. Sketch the standard
recipe — but do not prove it here.)

## 6. Risks and aborts

(Honest list: situations where Branch B genuinely cannot close even
under (A5). E.g., if L9 requires a measurable selection that fails for
non-Polish $\Theta$ (here Polish so OK), or if the adversary-side
attainment is genuinely open (in which case the route memo should
record Branch B as "open under (A5) too" and recommend publishing
Branch A on its own).)
```

## Discipline

- Use paper-canonical notation throughout.
- Cite Balder, Mertens, Sion by section/theorem number.
- Do NOT invoke any of the dead-route machinery from
  `prior_attempts_digest.md` (no product-narrow + Sion, no atomic
  truncation, no exact raw lifting).
- Do NOT attempt to prove L8 here. The output is a *plan*.
- Length budget: 1500–2500 words.
