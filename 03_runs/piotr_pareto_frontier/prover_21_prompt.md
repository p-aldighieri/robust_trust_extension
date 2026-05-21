# Prover pass 21 — Binary tie-splitting: weaken (R-TD)

## Role

You are the Prover. The targeted-weakening searcher
(`searcher_weakening_response.md`) ranked "Binary tie-splitting" as
the top weakening to attempt: relax **(R-TD) tie discipline** in the
binary capstone to allow $\tau$ to have an atom at the indifference
belief between $w_L$ and $w_R$, via a measurable tie-splitting rule.

## What's being relaxed

**Current binary capstone hypothesis (R-TD)**: $\tau$ assigns zero
mass to the indifference belief $s^*\in(L, R)$ at which
$s\cdot w_L = s\cdot w_R$.

**New target (R-TD\*)**: $\tau$ may assign positive mass $\tau(\{s^*\}) = \kappa$
to the tie belief, with a measurable tie-splitting rule
$\lambda^-: \{s^*\} \to \Delta(\{L, R\})$ specifying how much of the
tied mass goes to $L$ vs $R$.

## Lemma to prove (Binary-TS, "tie-split binary capstone")

Under standing hypotheses + |Ω|=2 + α∈(0,1) + (R-EE) endpoint
exposure + (R-IES) interior endpoint + **(R-TD*) tie-split discipline**
(in place of R-TD), there exists a robustly rationalizable optimal
strategy.

Specifically, the adversary kernel is:
\[
\hat\beta^*(\cdot\mid s) = \begin{cases}
\kappa_L(\cdot\mid s) & s\in S_+ \cup\{s^*\}^{(L)} \\
\kappa_R(\cdot\mid s) & s\in S_- \cup\{s^*\}^{(R)} \\
\end{cases}
\]
where $\{s^*\}^{(L)}, \{s^*\}^{(R)}$ are the measurable tie-splitting
restrictions, and $\kappa_L, \kappa_R$ are from L_B1 with adjusted
total-balance.

## Proof structure

### Step 1 — Modify the L_B5 total-balance
The total-balance equations now include the tie-mass:

$\alpha\!\int_{[0,L]}\!(L-m)\,\tau(dm) + \alpha\,\tau(\{s^*\})\,\lambda^+(s^*)(L-s^*) = (1-\alpha)\!\int_{S_+}\!(s-L)\,\tau(ds) + (1-\alpha)\,\tau(\{s^*\})\,\lambda^-(s^*)(s^*-L)$

and symmetric for $R$. Here $\lambda^+(s^*), \lambda^-(s^*) \in [0,1]$
are the tie-splitting weights for aligned and misaligned at $s^*$.

### Step 2 — Tie-split kernel construction
At the atom $s = s^*$, the kernel routes mass to $\{L, R\}$ via the
tie-split weights. The induced posterior at $L$ now has contributions
from both the truthful interior path and the tied-mass routing.

### Step 3 — Verify L_B1 hypotheses
The modified total-balance is still $\eta(A_-) = \nu(S_+) + (\text{tied-mass term})$.
Apply L_B1 with the adjusted measures.

### Step 4 — Calibration at endpoint
Show that the calibration $P_{\hat\beta^*}(\cdot\mid L) = L$ still
holds after tie-mass adjustment. Use the standard balance derivation
plus the tie-split weights.

### Step 5 — Bayes-optimality
TRS continuation $\hat\sigma^*(m) = R(w^*(\Pi_T(m)))$ remains
Bayes-optimal at every q-positive message under R-EE.

## What I want

Rigorous proof of Binary-TS in the structure above. Verify:
- The tie-split weights are GENUINELY measurable (single-point Borel).
- L_B1's total-balance accommodates the tie-mass.
- Calibration at the endpoint is preserved.

Output:
```
# Lemma Binary-TS (Tie-split binary capstone)

## Statement
## Hypotheses (R-EE, R-IES, R-TD*, standing)
## Proof (Steps 1-5)
## Verification
## Comparison with binary capstone under R-TD
```

End with verdict + next-step.

## Constraints

- Banned tools list applies.
- L_B1 may be cited as proved.
- Per searcher_weakening recommendation: this is the top-priority weakening.
