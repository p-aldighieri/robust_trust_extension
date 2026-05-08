# Prover pass — Strategy 2 sharp test on the v7 ternary witness

You are the **Prover** in the soft-scaffolding workflow. This is a **single focused test** of the most actionable post-formalizer strategy. The result determines whether Strategy 2 (null-message dust) is alive or dead, and whether the v7 ternary witness is a true obstruction or merely a witness inside the menu engine.

## The setting (verbatim from v7's sharpness witness)

- $\Om = \{0,1,2\}$, $\mu_0 = (1/3, 1/3, 1/3)$.
- $A = \{a_0, a_1, a_2\}$ with payoff $u(a_\omega, \omega) = 1$ and $u(a_i, \omega) = -1$ for $i \ne \omega$.
- $\tau$ atomless full-support on $\Delta(\Om)$.
- Trust region $T = \{\mu \in \Delta(\Om) : \mu(0) \le 0.4\}$, non-radial.
- Aligned-best label $\hat\sigma^*(m) = $ plurality vertex of $P_T(m)$.
- Boundary message $t_0 = (0.4, 0.3, 0.3)$ with $\hat\sigma^*(t_0) = a_0$, payoff profile $v_0$.
- Rowwise minimizers $R(t_0) = \{v_1, v_2\}$.
- Bayes cone $B(t_0) = \{p : p_0 \ge p_1, p_0 \ge p_2\}$.
- Source cone $K_0^- = \{s : s_0 \le s_1, s_0 \le s_2\}$.
- The v7 obstruction: $K_0^- \cap B(t_0) = \{(1/3, 1/3, 1/3)\}$, atomless $\tau \Rightarrow$ no positive q-mass calibration possible at $t_0$.

## The test

Strategy 2 says: place adversary-only payoff profiles on a Borel $\tau$-null set $N \subseteq M$, decoupling the aligned labeling from the adversarial labeling. Determine whether this **repairs** the obstruction at $t_0$, or whether a **no-free-dust** lemma holds.

### Step 1 — Try to construct dust that repairs the witness.

Look for a Borel $\tau$-null $N \subseteq M$, a labeling $w_N : N \to W$, and an adversarial kernel $\kappa(\cdot \mid s)$ supported on $G(s) := \{m : s \cdot w(m) = \min_{C^\dagger} s \cdot w\}$ where the labeling now extends $w^*$ on the original support and $w_N$ on the dust, such that:

- the menu engine's optimality is preserved (dust does not change the aligned payoff because $\tau(N) = 0$);
- the adversary uses dust messages with positive q-probability ($q_\beta(N) > 0$ via $\int \kappa(N \mid s) \tau(ds) > 0$);
- at every dust message $m \in N$ used with positive q-probability, the conditional source barycenter $\E_{q_\beta}[s \mid m]$ lies in $B(w_N(m))$.

Be concrete. If a construction exists, exhibit it explicitly: which messages, which labels, which kernel, which Bayes cones, and verify the calibration inequalities.

### Step 2 — If Step 1 fails, prove a no-free-dust lemma.

The natural form of the lemma:

> **No-free-dust (proposed).** For the v7 ternary winner-takes-all witness with non-radial $T$ and atomless $\tau$, no Borel $\tau$-null labeling $w_N : N \to W$ and no adversarial kernel $\kappa$ can satisfy simultaneously: (a) rowwise-minimizer support, (b) positive $q$-mass on $N$, (c) Bayes-cone calibration at every dust message used.

The proof should isolate WHY the obstruction is not relocated by null-set decoupling. Candidate lever: for every payoff profile $v \in W$, the source cone $K_v^- := \{s : v \in R(s)\}$ has barycenter $\bar s \in K_v^-$ that is **separated** from the Bayes cone $B(v)$ in the sense that $K_v^- \cap B(v) \ne \emptyset$ only at degenerate points (e.g., the uniform prior). If this separation is uniform across all admissible $v$, no dust can rescue calibration in winner-takes-all ternary.

Be explicit: state the cones, compute their intersections, show separation, and exhibit the resulting barycenter inequality that no calibration can satisfy.

### Step 3 — If a no-free-dust lemma holds in this witness, classify the witness.

Three possibilities, choose the right one with justification:

(a) **Witness is purely a menu-engine artefact.** Strategy 3 (constrained-persuasion transport) or Strategy 5 (trust-region geometry) might still escape it.

(b) **Witness reveals a structural calibration obstruction in winner-takes-all ternary**, but the trust region $T = \{\mu : \mu(0) \le 0.4\}$ is not a primitive trust region (i.e., not arising from any sensible robust optimization with the given $u$). In that case, the witness is real but does not falsify Theorem 2 unrestricted.

(c) **Witness reveals a structural obstruction realizable as a primitive optimal trust region.** In that case, the original Theorem 2 (for $|\Om| \ge 3$ with non-radial $T$) does **not** generalize from the finite case without additional structural hypotheses, regardless of route choice. This would be a genuine counterexample to the unrestricted infinite extension — a definitive negative result.

To distinguish (b) from (c), check whether $T = \{\mu : \mu(0) \le 0.4\}$ can arise as the optimal trust region under standing primitives (some choice of $\alpha$, $\tau$, $\Theta$, $f$, $u$, $A$) in the v7 witness setup. If yes, (c). If no, (b).

## What you MUST do

- Pick one outcome: (Step 1 success), (Step 2 success → Step 3 (a/b/c)), or honest stall with named obstacle.
- Be concrete with cones, barycenters, and inequalities. No hand-waving.
- If the construction succeeds, verify it. If the lemma holds, prove it. If neither works in this pass, name the precise step that blocks.

## What you MUST NOT do

- Do not pivot to a different strategy mid-pass.
- Do not declare the project complete or terminal.
- Do not invoke menu-Hall as if it were a standing hypothesis — the whole point is to determine whether dust escapes it.

## Output Format

```markdown
## Verdict
PROVED / DISPROVED / STALLED

## Outcome
Step 1 succeeded / Step 2 succeeded / Step 3 (a/b/c) / honest stall

## Construction or Proof

(If Step 1: explicit dust construction with verification.
If Step 2: no-free-dust lemma with proof.
If Step 3: classification with justification.
If stalled: named obstacle and what would unblock it.)

## Implication for the Project

(One paragraph. What does this tell us about whether the original infinite Theorem 2 has a non-narrowed proof?)
```

Length: 1500–2200 words.

## Reference

The v7 sharpness witness is in `theorem_2_extension_proof_v7.md` (durable source). The formalizer reread (q_β-a.e. semantics, adversary atoms on τ-null messages allowed) is in `logs/20260507T060000Z_formalizer_reread_def2_response.md` if needed for reference. The searcher's ranking and the calibration-invariant remark are in `logs/20260507T070000Z_searcher_post_formalizer_response.md`.
