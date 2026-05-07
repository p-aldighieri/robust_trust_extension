# Formalizer reread — Definition 2 on-path semantics, null messages, and the v7 scope question

You are the **Formalizer** in the soft-scaffolding workflow. This is a focused reread, not a fresh formalization. Output target: a precise account of what Definition 2 actually requires in the infinite-M, infinite-Θ setting, plus a list of ambiguities that the v7 menu-engine proof has been quietly resolving in one direction.

## Why this pass exists

The gatekeeper just classified v7 as `OBJECTIVE_NARROWED`. v7 establishes:

- **Tier 1a** (standing alone): existence of an optimal agent strategy σ* with U(σ*) = U*, plus ε-adversaries.
- **Tier 1b** (+ exact-contact): exact β*.
- **Tier 2** (+ menu-Hall): full robust rationalizability in the paper's a.e./on-path sense.

Menu-Hall was classified as **scope-changing**, because it is close to assuming the equilibrium calibration that Theorem 2 was supposed to produce. The gatekeeper's #1 proposed re-attack is to reread Definition 2 carefully: depending on the precise semantics of "on-path" and "for all m ∈ M", v7's narrowing may shrink, vanish, or reveal a different obstruction entirely.

## The questions you MUST answer

For each question, cite the paper precisely (section, equation/definition, quoted phrase). Do NOT speculate where the paper is silent — flag silences as ambiguities.

1. **Quantifier in Definition 2.** Definition 2 of *Robust Trust* says: there exists β* ∈ B adversarial against σ such that for all m ∈ M, σ̂(m) ∈ argmax_{σ̂'} U(σ̂', P_{β*}(·|m)). In the infinite setting:
   - Does "for all m ∈ M" mean literal-all, or τ-a.e., or q-a.e. where q is the second marginal of the joint adviser-message law?
   - Does the paper's general "infinite spaces are endowed with Borel σ-algebras and 'for all' is interpreted as 'almost all' where needed" convention apply to Definition 2 specifically, or only to the standing primitives?
   - Where in the paper's text or Appendix is this clarified?

2. **Definition of P_{β*}(·|m).** The conditional posterior is defined as a Bayes update under a mixture of α-truthful and (1-α)-misaligned adviser. In the infinite setting:
   - What is the reference measure? (q := α τ + (1-α) (m_*)#τ in v7's formulation, or some other choice?)
   - On what set of m is P_{β*}(·|m) defined? (q-a.e.? τ-a.e.? everywhere via a regular conditional probability?)
   - Does Definition 2 require σ̂(m) ∈ B(m) at every m, or only where P_{β*}(·|m) is defined?

3. **Null messages and adversary atoms.** Suppose τ is atomless on M and there is a Borel set N ⊆ M with τ(N) = 0. Definition 2 references "for all m ∈ M":
   - Is the adviser allowed to use β with β({m} | s) > 0 for some m ∈ N? (i.e., adversary atoms on τ-null messages)
   - Does the paper anywhere either (a) restrict β to be τ-absolutely-continuous, (b) restrict the conclusion to τ-a.e., or (c) explicitly allow null-message dust?
   - In the finite proof in Appendix A.2, all m ∈ M are τ-positive by definition, so this question does not arise. What is the natural infinite-extension reading?

4. **What does "robustly rationalizable" mean operationally in the infinite setting?** v7 proves the conclusion τ-a.e. (and in fact q-a.e. with q ≥ ατ when α > 0). State precisely:
   - Whether the τ-a.e. reading suffices to call σ "robustly rationalizable" in the paper's intended sense.
   - Whether the q-a.e. reading suffices, given that q charges τ-null messages whenever the adversary uses them.
   - Whether the two readings agree in the finite paper proof.

5. **Optimality direction (Theorem 2 part 1).** The paper proves: robustly rationalizable ⇒ optimal. In the infinite setting:
   - Is this verification direction proved at the same level of "for all m" as Definition 2, or does it need stronger Bayes-optimality (e.g. literal all m)?
   - Does v7's a.e./on-path conclusion immediately give the optimality direction, or is there a hidden gap?

## What you MUST NOT do

- Do not propose proof routes. That is the searcher's job.
- Do not declare the v7 result complete or incomplete. That is the gatekeeper's call (already made: NARROWED).
- Do not silently add hypotheses. If a question is genuinely ambiguous, log it as an ambiguity. Do not patch it for the convenience of any candidate route.

## Output Format

```markdown
## Plain-Language Reading of Definition 2 in the Infinite Setting

(One paragraph, your best reading of the formal target after the reread.)

## Per-Question Findings

### Q1. Quantifier in Definition 2
- Paper text: ...
- Best reading: ...
- Ambiguities: ...

### Q2. Definition of P_{β*}(·|m)
- Paper text: ...
- Best reading: ...
- Ambiguities: ...

### Q3. Null messages and adversary atoms
- Paper text (or silence): ...
- Best reading: ...
- Ambiguities: ...

### Q4. "Robustly rationalizable" in the infinite setting
- Paper text: ...
- Best reading: ...
- Ambiguities: ...

### Q5. Optimality direction
- Paper text: ...
- Best reading: ...
- Ambiguities: ...

## Consolidated Ambiguity List

(A flat numbered list of every ambiguity you flagged, suitable for a searcher to use as input.)

## Where v7's Proof Has Been Resolving Ambiguities Tacitly

(Identify each tacit choice v7 made, e.g. "v7 reads 'for all m' as τ-a.e.; alternative readings would have the following effect on the menu-Hall obstruction".)

## Implication for the Scope Question

(One paragraph. Under which readings of Definition 2 is the v7 narrowing real, under which does it collapse to a regularity issue, and under which does it reveal a different obstruction?)
```

Length: 1500–2200 words. Read the paper carefully — Section 3.3, Definition 2, Appendix A.2 are the key sections, but the standing-assumptions and measurability conventions in Section 2 may decide several of these questions.
