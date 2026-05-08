# Prover pass — Menu-to-message realization lemma

You are the Prover. Address the gap caught in the v6 consolidator
review: KRN gives a Borel selector $\bar w(s)\in R(s)\subseteq C^*$
(profile-level adversary), but for the actual message-game adversary
$\beta^*\in B$ we need a measurable $m^*(s)\in M$ such that, under
the chosen aligned labeling $w^*: M\to C^*$, $w^*(m^*(s)) = \bar w(s)$
(or a kernel that achieves this in expectation).

This is the bridge between profile-level adversary attainment
(automatic) and message-level adversary attainment (the actual Tier 1
claim).

## Inputs

- Phase C breakdown + equivalence lemma + abort-test logs.
- v6 consolidator: `theorem_2_extension_proof_v6.md`.
- v6 reviewer: `logs/20260507T020000Z_reviewer_consolidator_v6_response.md`.

## Target — Menu-to-message realization lemma

**Setup.** Let $C^*\in\mathcal K(W)$ be the menu maximizer (Tier 1).
The aligned-best labeling is the Borel selector
$w^*(m) := \arg\max_{w\in C^*}\,m\cdot w$ (single-valued for $\tau$-a.e. $m$
since $\Delta(\Om)$ is finite-dim and the argmax of a continuous linear
functional over a compact convex set is generically a single extreme
point; on the small set where it's multi-valued, KRN selects). The
rowwise minimizer is $R(s) := \arg\min_{w\in C^*}\,s\cdot w$, with
Borel selector $\bar w(s)\in R(s)$.

**Define** $M^*(s) := \{m\in M : w^*(m) = \bar w(s)\}$ (the messages
whose aligned label is the rowwise minimizer profile at source $s$).

**Question.** Is $M^*(s)\ne\emptyset$ for τ-a.e. $s$? If yes, KRN gives
$m^*(s)\in M^*(s)$ Borel, and $\beta^*(dm\mid s) := \delta_{m^*(s)}(dm)\in B$
realizes the profile-level adversary in the message game.

If $M^*(s)$ may be empty, what's the obstruction? Can it be repaired
by:
- (a) mixing $\beta^*$ over messages giving profiles close to $\bar w(s)$
  (approximate realization)?
- (b) prescribing a richer labeling rule that ensures every profile
  in $C^*$ is hit by some message?
- (c) replacing $C^*$ with the closure of the realized image
  $C^\dagger := \overline{w^*(M)}$ — does this preserve the value?

## Subquestions you MUST address

1. **The aligned-best labeling's image $w^*(M)$.** What's its structure?
   Is it always all of $C^*$, or can it be a proper subset (e.g.,
   only the exposed/extreme profiles)?

2. **Generic case: $C^*$ has finitely many extreme points.** In the
   ternary witness, $C^* = \{v_0, v_1, v_2\}$ and each $v_\omega$ is
   the argmax for the plurality-$\omega$ region of $\Delta(\Om)$.
   So $w^*(M) = \{v_0, v_1, v_2\} = C^*$, and $R(s) \subseteq w^*(M)$
   — $M^*(s)$ is nonempty. Generalize: when $C^*$ has finite extreme
   points and every extreme point is exposed by some posterior, the
   labeling realizes everything.

3. **Pathological case.** Could $C^*$ have a boundary profile that's
   not exposed by any $m\in\Delta(\Om)$? E.g., $C^*$ a closed set with
   an "interior boundary" profile that's not extreme but is in the
   relative boundary of $C^*$. Then $w^*(M)$ misses that profile. If
   $\bar w(s)$ ever lands there, $M^*(s) = \emptyset$.

4. **Mixing repair.** If $\bar w(s)$ is a non-exposed profile, it's
   in the convex hull of nearby exposed profiles. The adversary can
   mix over messages whose labels are those exposed profiles, with
   weights chosen so the **expected payoff equals** $s\cdot \bar w(s)$.
   This gives **integrated** realization, not pointwise. State and
   prove this carefully.

5. **Closure-pruning repair.** Replace $C^*$ by $C^\dagger := \overline{w^*(M)}$.
   Then realization is automatic (every used profile is hit by some
   message). But: is $F(C^\dagger) = F(C^*) = U^*$? Argue that the
   aligned term is unchanged ($\max_{w\in C^*}\,m\cdot w = \max_{w\in C^\dagger}\,m\cdot w$
   since the max over $C^*$ is achieved on $w^*(M)\subseteq C^\dagger$);
   the misaligned term may change since $\min_{w\in C^*}\,s\cdot w$
   could be smaller than $\min_{w\in C^\dagger}\,s\cdot w$.

   Hmm — the misaligned term DECREASES the agent's payoff (worse),
   so dropping unused profiles increases $\min$, which **increases**
   $F(C^\dagger) \ge F(C^*)$. So $F(C^\dagger) \ge F(C^*) = U^*$;
   combined with $F(C^\dagger) \le U^*$ from menu-value equivalence,
   $F(C^\dagger) = U^*$. So we can replace $C^*$ by $C^\dagger$
   without loss, and realization becomes automatic.

   Verify this argument is correct. **If yes, this is the fix:** the
   optimal menu can always be chosen to equal the closure of its
   own labeling image, in which case message-realization is automatic.

## Output Format

```markdown
## Goal for this pass
(One paragraph.)

## Step 1: Aligned-best labeling structure
(What is w^*(M)?)

## Step 2: Generic case — $w^*(M) = C^*$ when extreme points are exposed
(Ternary witness verification + generalization.)

## Step 3: Pathological case — when $w^*(M) \subsetneq C^*$
(Concrete construction of a $C^*$ with non-exposed boundary profile.)

## Step 4: Mixing repair (if pathological)
(Adversary mixes over messages giving extreme profiles.)

## Step 5: Closure-pruning repair (THE clean fix)
(Replace $C^*$ by $C^\dagger = \overline{w^*(M)}$. Verify $F(C^\dagger) = F(C^*) = U^*$.)

[DERIVED] Under closure-pruning, message-realization of the
profile-level adversary is automatic, and Tier 1 closes
unconditionally (modulo the standard profile-to-private-strategy
sub-lemma which is genuinely standard).

## Status

- Menu-to-message realization: PROVED via closure-pruning of $C^*$.
- Tier 1 status: now genuinely unconditional under standing
  hypotheses + standard profile-to-private-strategy sub-lemma.

## Exact next obstacle

Reviewer pass on this fix. After PASS, update the v6 consolidator to
state Tier 1 with the closure-pruning step explicit, and to state the
profile-to-private-strategy sub-lemma cleanly.
```

## Discipline

- The closure-pruning argument is the main content. Be careful about
  the inequality direction in the misaligned term.
- The profile-to-private-strategy sub-lemma should be cited as
  standard; don't re-derive it.
- Length: 1500–2500 words.
