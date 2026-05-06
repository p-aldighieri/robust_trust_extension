# Prover pass — Q1 negative lemma: (A8c-attain) cannot be removed

You are the Prover in the soft-scaffolding workflow.

## Goal

Per the literature pass recommendation, prove a **crisp negative
lemma** establishing that **(A8c-attain) cannot be removed** for
Branch B Tier 1 under standing + (A5-thick) alone. This closes Q1 with
a defensible NEGATIVE endpoint.

## Inputs

- `theorem_2_extension_proof_v4.md`, `phil_reny_route_memo.md`,
  `phil_reny_bundle.md`, `prior_attempts_digest.md`, paper PDF.
- Q1 formalizer:
  `logs/20260506T170000Z_thin_formalizer_Q1_remove_A8c_response.md`.
- Q1 literature pass:
  `logs/20260506T173000Z_literature_Q1_remove_A8c_response.md`.

## Target — Q1 Negative Lemma

**Lemma (Q1-NEG).** *There exist primitives satisfying the standing
hypotheses of Dworczak–Smolin (2026) + (A5-thick) such that:*

1. *The Branch-A maximizer $\sigma^*\in\Sigma$ exists with
   $U(\sigma^*) = U^*$ and $\inf_{\beta\in B} U(\beta,\sigma^*) = U^*$
   (so L6 bottom-density holds).*
2. *The rowwise argmin correspondence $D(s) := \arg\min_m \ell_{\sigma^*}(m,s)$
   is **empty** for a positive-τ set of $s$ (so (A8c-attain) **fails**).*
3. *No Borel kernel $\beta^*\in B$ attains $U(\beta^*,\sigma^*) = U^*$.*

**Construction.** The literature pass + the route memo's
counterexample structure suggest:
- $\Omega = \{0,1\}$ binary; $\Theta$ singleton; $A = [0,1]$.
- $\tau$ = a Bayes-plausible posterior law on $M = [0,1]$ with both
  states having full topological support (so (A5-thick) holds).
- Row payoff structurally encoding $g(m) = m$ for $m>0$, $g(0) = 1$
  (the L8c-Half-2 counterexample, but **realized via a Robust Trust
  primitive specification**).
- $\sigma^*$ such that $\ell_{\sigma^*}(m,s) = g(m)$ (or close enough).

## What you must produce

### Target 1: The negative lemma (statement + proof)

**Step 1.** Construct primitives $(\mu_0, \pi, f, u, \alpha)$ satisfying
standing + (A5-thick) such that the resulting Branch-A maximizer
$\sigma^*$ has $\ell_{\sigma^*}(m,s) = g(m,s)$ where $g(\cdot, s)$ has
$\inf = 0$ but argmin empty for τ-a.e. $s$. (Use the upward-spike
pattern $g(0,s) = 1$, $g(m,s) = m$ for $m>0$, possibly s-independent
for simplicity.)

**Step 2.** Verify (A5-thick) holds.

**Step 3.** Verify $\inf_{\beta\in B} U(\beta,\sigma^*) = U^*$ (L6
bottom-density still goes through, since L6 only used (A5-thick)).

**Step 4.** Show that **no Borel kernel $\beta^*\in B$ attains** the
infimum. The argument: any Borel $\beta^*\in B$ assigns row $\beta^*(\cdot\mid s)$
a probability measure on $M = [0,1]$. The misaligned-term contribution
is $C(\beta^*,\sigma^*) = \int g(m)\,\beta^*(dm\mid s)\,\tau(ds)$. For
this to equal 0 (the inf), $\beta^*(\cdot\mid s)$ must concentrate on
$\{0\}$ for τ-a.e. $s$. But then $g(0) = 1$ contributes 1 to each
row, so $C(\beta^*,\sigma^*) \ge 1 \cdot \tau\{s : \beta^*(\{0\}\mid s) > 0\}$ —
positive whenever $\beta^*$ uses the only candidate $m = 0$. Conclude
no Borel kernel attains.

**Step 5.** Verify the counterexample is **fully Robust-Trust-compliant**
— i.e., the primitives are realizable in Dworczak–Smolin's model class
with all standing assumptions.

### Target 2: Implications for the Tier 1 theorem

State the consequences:

- (A8c-attain) **cannot be removed unconditionally** under standing +
  (A5-thick) alone.
- The Tier 1 theorem statement must either keep (A8c-attain), or
  weaken the conclusion to an **approximate-adversary statement**:
  $\forall \varepsilon > 0$, $\exists \beta_\varepsilon\in B$ with
  $U(\beta_\varepsilon, \sigma^*) \le U^* + \varepsilon$. (This is just
  L6 bottom-density and holds unconditionally under (A5-thick).)
- The exact attainment requires (A8c-attain) or one of (P1)–(P3).

## Output Format

```markdown
## Goal for This Pass
(One paragraph.)

## Main Work

### Target 1: Q1 negative lemma

**Statement.** (Restate Lemma Q1-NEG with all primitives explicit.)

**Proof.**

Step 1: (Primitives.)
Step 2: (Verify (A5-thick).)
Step 3: (L6 bottom-density.)
Step 4: (No Borel attainer — the upward-spike obstruction.)
Step 5: (Robust-Trust-compliance verification.)

[DERIVED] Q1-NEG holds.

### Target 2: Implications for the published theorem

(Tier 1 must keep (A8c-attain) or weaken to approximate-adversary
statement.)

## Status Summary

- **Q1 status: CLOSED-NEGATIVE.** (A8c-attain) cannot be removed; the
  theorem must either keep it or weaken to ε-approximate adversary.

## Exact Next Obstacle

(Move to Q2 — relax (TRE-gen-Hall) for general |Omega|>=3.)
```

## Non-Negotiable Rules

- Be HONEST. The negative is the right answer per the literature
  pass; this pass formalizes it.
- Use Robust-Trust-compliant primitives.
- Length budget: 1500–2500 words.

## Scope Policy

Q1 only. The deliverable is the negative lemma + its consequences for
the theorem statement. After this passes review, Q2 is next.
