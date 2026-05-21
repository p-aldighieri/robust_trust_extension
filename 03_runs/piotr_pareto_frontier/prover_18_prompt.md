# Prover pass 18 — Phase (b): Eliminate (Reg-1)+(Reg-2), bare standard-Borel M

## Role

You are the Prover. **Five reviewer-PASS'd theorems are banked**
(T1 finite-menu Pareto-Hall, T2 α=0 singleton, Binary capstone, FBNF
capstone, G3 Hall biconditional + G4 polyhedral LP + Prover 17 worked
examples).

The user has authorized **Phase (b)**: attempt to eliminate the
regularity package (Reg-1)+(Reg-2) from the G3 biconditional. Two
possible outcomes:

1. **(b)+ success**: Reg-1+Reg-2 follow from standing Robust Trust
   hypotheses without extra assumptions. The biconditional G3 becomes
   genuinely unconditional in the Robust Trust setting.
2. **(b)− structural bound**: bare standard-Borel M admits a boundary-
   escape counterexample (Prover 13's), but Reg-1+Reg-2 are automatic
   under primitive smoothness assumptions on the Robust Trust model
   primitives.

Either outcome is a clean answer. The user wants a DEFINITIVE
position.

## What you must do

### Step 1 — Restate the regularity package
- (Reg-1) Closed-graph of $R: M\rightrightarrows M$ where
  $R(s) = \arg\min_{m\in M}\,s\cdot w^*(m)$.
- (Reg-2) Continuity of $m\mapsto h_{B(m)}(y)$ for fixed bounded
  Borel $y$, where $B(m) = N_W(w^*(m))\cap\Delta(\Omega)$.

### Step 2 — Examine when they're automatic
For each piece, check whether it follows from standing Robust Trust
hypotheses:
- $\Omega$ finite ⇒ $\Delta(\Omega) = $ compact simplex ⇒ $W$ compact
  in $\R^{|\Omega|}$.
- $A, \Theta$ compact metric, $u$ bounded continuous in $a$ ⇒ ?
- $\tau$ Borel probability on $M = \operatorname{supp}\tau$ compact.

What additional regularity does $w^*: M\to W^P$ need beyond Borel
measurability?

### Step 3 — Identify the gaps
For each (Reg-1) and (Reg-2), state precisely what extra hypothesis
beyond standing is needed. Candidates:
- $w^*$ continuous (this is "Bayes-optimal action is well-defined
  continuously"; generic under strict concavity in $a$).
- $W^P$ has a $C^1$ supporting hyperplane structure (smoothness of
  the supporting belief at each frontier profile).

### Step 4 — Boundary-escape counterexample revisited
Prover 13's boundary-escape construction had a non-compact M. In
Robust Trust, M is automatically compact. So that particular
counterexample doesn't apply.

**Check**: are there NEW counterexamples where M is compact but
Reg-1 or Reg-2 fails?

### Step 5 — The clean (b)+ result (if achievable)
State and prove the cleanest form:

**Theorem (b)+**: Under standing Robust Trust hypotheses + (Reg-1*)
(some weakening or sufficient condition) + (Reg-2*), the G3
biconditional holds. If (Reg-1*) and (Reg-2*) ARE the standing
hypotheses + measurability of $w^*$, we have an unconditional
Theorem 2 biconditional in the Robust Trust setting.

### Step 6 — Honest verdict
Pick one:
- **(b)+ success**: G3 is unconditional in Robust Trust as stated.
- **(b)+ partial**: Reg-1 follows from standing; Reg-2 needs $w^*$
  continuous (or similar primitive).
- **(b)+ neither**: both Reg-1 and Reg-2 need extra primitives.

## What I want

```
# Phase (b): Bare standard-Borel cone-Hall biconditional

## Setup recap (Robust Trust standing hypotheses)

## Step 1 — Regularity package
## Step 2 — Standing-hypothesis derivability
## Step 3 — Gap analysis
## Step 4 — Boundary-escape revisited under compact M
## Step 5 — The clean (b)+ result

## Verdict
- (b)+ success / partial / neither

## Open
- If (b)+ partial: what's the minimal extra primitive needed?
- If (b)+ neither: what does the regularity package add economically?
```

## Output Contract

- Inline markdown.
- Be honest. If standing + compactness gives Reg-1+Reg-2, say so.
  If not, identify precisely what's missing.
- End with verdict + next-step (start consolidator).

## Constraints

- Banned tools list applies.
- Per user: the goal is a DEFINITIVE position on whether the
  regularity package is needed. Don't hedge.
