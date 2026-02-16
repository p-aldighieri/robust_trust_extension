# Project brief: Extending Theorem 2 (Robust Trust) beyond finite M and Θ

## Goal
Prove the **existence** part of Theorem 2 in *Robust Trust* (Dworczak–Smolin) **without assuming** that the adviser-belief support \(M\) and the agent type space \(\Theta\) are finite.

Equivalently: establish that the agent’s robust max–min problem admits a **robustly rationalizable** optimal strategy (a saddle point / zero-sum equilibrium with the misaligned adviser) when \(M\) and \(\Theta\) may be infinite, within the paper’s measurable, compact-metric setup.

## Context
- The paper models an agent choosing actions under uncertainty, combining private information \(\theta\) with advice from an informed adviser.
- The adviser is truthful with probability \(\alpha\) and adversarial (arbitrary messaging) with probability \(1-\alpha\).
- Theorem 2 has two parts:
  - **Optimality:** any robustly rationalizable strategy is optimal.
  - **Existence (as stated):** a robustly rationalizable strategy exists if **\(M\)** and **\(\Theta\)** are finite.
- The finiteness assumption is used to make a direct minimax argument (via Sion-type conditions) technically straightforward. The project is to remove that crutch.

## What we need
1. **A precise generalized statement** of Theorem 2 (quantifiers + assumptions), keeping the paper’s primitives intact:
   - \(\Omega\) finite; \(A\) compact metric; \(\Theta\) compact metric; bounded utility \(u\) (continuous in \(a\)); measurability throughout.
   - Only \(M\) and \(\Theta\) are allowed to be infinite.

2. **Strategy-space formalization for infinite settings**
   - Model \(\sigma\) and \(\beta\) as measurable stochastic kernels.
   - Choose topologies (typically weak/weak* topologies on probability measures, product topologies on kernel spaces).

3. **Existence machinery**
   - Show convexity and compactness (or sequential compactness/tightness) of the relevant strategy spaces under the chosen topology.
   - Verify continuity or suitable semi-continuity of the payoff functional in each argument.
   - Apply an appropriate minimax / saddle-point theorem (Sion, Fan, Glicksberg-type, or an infinite-dimensional extension), or construct a saddle point directly.

4. **No assumption smuggling**
   - Any additional technical conditions needed (for example, continuity in \(\theta\), continuity of type kernels \(f(\cdot\mid\omega)\), existence of measurable maximizers, compactness of certain induced correspondences) must be explicitly flagged as **Needed assumption**, not silently adopted.

5. **Fallback: counterexample if needed**
   - If a robustly rationalizable strategy can fail to exist under the baseline assumptions with infinite \(M\) and/or \(\Theta\), produce a minimal counterexample.
   - Then propose the weakest additional condition(s) under which existence is restored.

## Deliverables
1. **Generalized Theorem 2 statement** (optimality + existence) with explicit assumptions and quantifiers.

2. **Proof package**
   - A clean proof of the **optimality direction** that does not rely on finiteness.
   - A fully rigorous proof (or a clearly identified counterexample) for the **existence direction** when \(M\), \(\Theta\) are infinite.

3. **Technical appendix of lemmas** (as needed)
   - Compactness/tightness results for the strategy spaces.
   - Continuity or semi-continuity of payoff as a function of kernels.
   - A precise minimax/saddle-point theorem statement with conditions checked line-by-line.

4. **Assumption ledger**
   - A short list separating:
     - assumptions already present in the paper’s model section, and
     - additional assumptions that turn out to be necessary for the infinite-space existence proof.

5. **Certification view (optional but valuable)**
   - If existence holds, an explicit “certificate” template: how to exhibit \(\beta^*\) that makes a proposed \(\sigma^*\) robustly rationalizable.

