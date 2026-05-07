# Prover pass — Lemma A.2 (the trapdoor lemma for Strategy 3)

You are the **Prover** in the soft-scaffolding workflow. This is a single, sharply scoped pass attacking the critical lemma identified by the Strategy-3 breakdown. Its outcome decides whether Strategy 3 lives or dies as a route to a non-narrowed Theorem 2.

## The lemma

**Lemma A.2 (uncalibrated minimal menu pruning).**

Assume the standing hypotheses of *Robust Trust* (Dworczak–Smolin 2026) and Assumption (exact-contact) from v8. Let $C^* \subseteq W$ be a compact menu satisfying

(C1) Behavioral minimality: $C^* \in \arg\max_{C \in \mathcal K(W)} F(C)$ and $F(D) < F(C^*)$ for every nonempty compact $D \subsetneq C^*$.

Let $w^*: M \to C^*$ be the canonical aligned-best labeling, $C^\dagger := \overline{w^*(M)} = C^*$ (forced by minimality), and $G(s) := \{m \in M : s \cdot w^*(m) = \min_{z \in C^*} s \cdot z\}$.

If **menu-Hall fails** for $w^*$ — i.e., there is no Borel kernel $\kappa(\cdot \mid s)$ supported on $G(s)$ τ-a.e. with disintegration posterior $P_{\gamma_\alpha}(\cdot \mid m) \in B(m)$ q-a.e. (where $\gamma_\alpha$ and $q$ are as in v8 §4) —

then there exists a nonempty compact $D \subsetneq C^*$ with $F(D) \ge F(C^*)$.

## What the lemma would mean if true

If A.2 holds, behavioral minimality (C1) **forces** menu-Hall: any $C^*$ for which menu-Hall fails has a proper compact subset $D$ that achieves at least the same $F$-value, which contradicts (C1). Therefore C1 is incompatible with menu-Hall failure. This would close Tier 2 unconditionally for behaviorally minimal canonical menus — a major positive result.

## What the lemma would mean if false

If A.2 is false, there is a behaviorally minimal $C^*$ where menu-Hall fails AND every proper compact subset has strictly lower $F$. In that case, behavioral canonicality is just a renaming — primitive minimality does not imply calibration, and Strategy 3's general form (C1, C2) collapses. Only the special-geometry routes (C3 binary, C4 spherical) survive, confirming v8 as the terminal result for general infinite Theorem 2.

## Three valid outcomes

You must produce **exactly one** of:

**(A) Proof of A.2.** Use the technique hint: Strassen/Kellerer duality + translation of a separating certificate into a menu deletion. Sketch:

- Menu-Hall is feasibility of a particular constrained transport problem (κ supported on $G(s)$, posterior in $B(m)$).
- Failure of menu-Hall ⇒ infeasibility ⇒ a separating certificate (a continuous affine $\phi$ and a measurable $E \subseteq M$ violating the support-function inequality of v8 §4).
- Translate the certificate into a Borel set $E_0 \subseteq M$ such that the labels $w^*(E_0)$ can be removed from $C^*$ without lowering $F$. The aligned term may go down on $E_0$; the misaligned term goes up by at least as much by the failed inequality.
- Conclude $D := \overline{w^*(M \setminus E_0)} \subsetneq C^*$ achieves $F(D) \ge F(C^*)$.

**(B) Counterexample to A.2.** A specific model (specify $\Om$, $A$, $u$, $\alpha$, $\tau$) and a specific behaviorally minimal $C^*$ where menu-Hall demonstrably fails AND every proper compact $D \subsetneq C^*$ satisfies $F(D) < F(C^*)$ strictly.

**(C) Honest stall.** A precise named obstacle. Examples:

- "Strassen/Kellerer duality with these Bayes-cone constraints requires regularity I cannot establish from standing assumptions; the dual certificate exists but does not translate into a menu deletion under bare Borel measurability."
- "Translating $E_0$ into a deletable label set requires that the misaligned-improvement on $E_0$ dominates the aligned-loss on $E_0$ uniformly, which I cannot prove without stronger geometric hypotheses on $C^*$ or $\tau$."

## What you MUST do

- Pick one outcome and commit to it.
- Be concrete with cones, supports, and inequalities. No "morally similar" hand-waves.
- If you prove (A), verify the construction's measurability explicitly. If you exhibit (B), verify both menu-Hall failure AND strict $F$-strictness for every proper subset (the second is the hard part). If (C), name the obstacle and what would unblock it.

## What you MUST NOT do

- Do not pivot to a different canonicality candidate (C2, C3, C4) mid-pass. They are scheduled for separate prover passes.
- Do not invoke menu-Hall as if it were a standing hypothesis.
- Do not claim a positive result that depends on choosing κ in a way that already encodes calibration — that would be the very renaming the breakdown's renaming test was designed to catch.
- Do not extend the standing assumptions silently. If your proof needs additional regularity, surface it as a hypothesis and explain why.

## Reference

v8 has the precise definitions of $w^*$, $C^\dagger$, $G(s)$, $B(m)$, $\gamma_\alpha$, $q$, menu-Hall (kernel form and support-function form), and the cone intersection lemma + no-free-dust theorem. v8 is in durable sources. The breakdown response is in `logs/20260507T110000Z_breakdown_strategy3_canonical_menu_response.md`.

## Output Format

```markdown
## Verdict
PROVED / DISPROVED / STALLED

## Outcome
(A) Proof of A.2 / (B) Counterexample / (C) Honest stall

## Argument

(If A: full proof with measurability checks.
If B: the model + verification that menu-Hall fails AND every proper compact subset strictly lowers F.
If C: precise named obstacle plus what would unblock it.)

## Implication for Strategy 3

(One paragraph. Does this verdict close Strategy 3 (in either direction), or does it leave specific candidates C2/C3/C4 still open as separate routes?)

## Implication for the Project

(One paragraph. Should the orchestrator:
- continue Strategy 3 with the next item on the breakdown's action list (B.2/C.2/D.2)?
- stop and commit v8 as terminal?
- pursue a different route entirely?)
```

Length: 1500–2200 words.
