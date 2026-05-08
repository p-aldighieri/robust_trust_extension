# Prover pass — Phase C abort test: does the menu engine fix the ternary Hall violation?

You are the Prover. **This is the crucible test.** The previous
deterministic TRE-gen-Hall route hit a ternary non-radial
Hall-violation witness. The menu engine claims to fix this by allowing
the adversary to mix among row-minimizing messages instead of freezing
on a deterministic worst-message selector. Test this claim.

## Setting (taken from the prior negative witness)

- $\Om = \{0,1,2\}$, prior $\mu_0 = (1/3, 1/3, 1/3)$.
- $A = \{a_0, a_1, a_2\}$ discrete, with $u(a_\omega,\omega) = 1$,
  $u(a_i,\omega) = -1$ for $i\ne\omega$.
- $\Th$ singleton (drop the type for this test).
- $\tau$ atomless full-support on $M = \Delta(\Om)$ — say uniform
  Dirichlet, or piecewise-uniform on the simplex.
- Trust region $T = \{\mu\in\Delta(\Om) : \mu(0)\le 0.4\}$ (non-radial,
  exactly the prior witness model).
- $\sigma^*$ the TR-strategy: $\hat\sigma^*(m) = $ plurality vertex of
  $P_T(m)$. Equivalently, the agent picks the action of the state with
  the highest belief in the projected posterior.

## Setup in the menu language

The set $W = \{w\in\R^3 : \exists \hat\sigma,\ w(\omega) = \E_{\hat\sigma}[u(a,\omega)]\}$
is the convex hull of the three rows
$\big\{(1,-1,-1),\,(-1,1,-1),\,(-1,-1,1)\big\}$ in $\R^3$ — i.e., the
simplex spanned by these three vertices. (Or a richer convex set if
mixed actions are allowed; the convex hull is correct since we have
three pure actions and the triangle is the menu's universe.)

The TR-strategy menu is:
- For $m\in T$ ($\mu(0)\le 0.4$): the strategy plays the plurality
  vertex; the corresponding profile is the row vector for that vertex.
- For $m\notin T$: the strategy plays the boundary projection's
  plurality vertex.

So $C^* := \overline{w^*(M)}$ where $w^*(m)$ is the profile vector
generated at message $m$ by $\hat\sigma^*$. This is some compact
subset of $W$.

## Target: does menu-Hall hold at $C^*$ in this example?

The menu-Hall condition for a coupling $\kappa(\cdot\mid s)$ supported
on the rowwise minimizer correspondence
$R(s) := \arg\min_{w\in C^*} s\cdot w$ requires: with
$\gamma_\alpha = \alpha\,\mathrm{id}_\#\tau\otimes\mathrm{id}_\#\tau + (1-\alpha)\,\tau\otimes\kappa$
and $q$ its second marginal, the posterior
$P_{\gamma_\alpha}(\cdot\mid m) \in B(m)$ for $q$-a.e. $m$, where
$B(m)$ is the set of beliefs at which the menu element labeled by $m$
is Bayes-optimal.

**Crucially**, $\kappa$ is now set-valued / can mix; it is not forced
to be Dirac. The question: does this flexibility resolve the prior
ternary witness?

### Concrete computation requested

1. **Compute $C^*$ and identify the rowwise minimizer correspondence
   $R(s)$ for the boundary point $t_0 = (0.4, 0.3, 0.3)$.**
   At posterior $s = t_0$, what's $\min_{w\in C^*} s\cdot w$ and what's
   the argmin set $R(t_0)$?

2. **Identify the Bayes cone $B(t_0)$.**
   For the menu element corresponding to $t_0$ (which is the plurality
   vertex of $P_T(t_0) = t_0$ since $t_0\in T$), what's $B(t_0)$?
   That's the set of beliefs where playing the chosen action is
   Bayes-optimal.

3. **Test whether mass-mixing in $\kappa$ over $R(s)$** (allowing the
   adversary to spread mass over multiple row-minimizing messages)
   can make the posterior at $t_0$ land in $B(t_0)$.
   - If YES: produce the calibrated $\kappa$ explicitly. Menu engine
     resolves the Hall obstruction.
   - If NO: produce the precise obstruction — even with mass mixing,
     the posterior at $t_0$ cannot enter $B(t_0)$ because (geometric
     reason). This means menu-Hall is essential and the deterministic
     vs set-valued distinction does not save us.

4. **Honest verdict.**
   - **Verdict POS:** menu engine fixes the ternary witness. Then
     menu-Hall holds at the optimal $C^*$ in this concrete model, and
     the engine pivot is justified.
   - **Verdict NEG:** menu engine does NOT fix the ternary witness.
     Even set-valued mixing cannot calibrate at $t_0$. Then the
     calibration obstruction is intrinsic to the multi-dim TRE
     geometry, not to the deterministic-vs-mixing dichotomy.
     Diagnose what the obstruction really is.

## Output Format

```markdown
## Goal for this pass
(One paragraph.)

## Step 1: $C^*$, $R(s)$, and the minimizer set at $t_0$
(Computation.)

## Step 2: Bayes cone $B(t_0)$
(Computation.)

## Step 3: Mass-mixing test
(Set up the calibration problem; either solve it or surface the
obstruction.)

## Step 4: Verdict
(POS/NEG with justification.)

## Implications
- If POS: the menu engine resolves the prior Hall obstruction. Next:
  prove the general menu-Hall theorem.
- If NEG: identify the precise structural obstruction; recommend Plan
  B (set-valued calibrated transport assumed as a conditional
  hypothesis, exactly like TRE-gen-Hall but for set-valued couplings).

## Status

- Phase C abort test: PASSED / FAILED.
- Recommended next move:
```

## Discipline

- This is a concrete computation in a finite-dimensional setting.
- Use the paper's notation; the binary case (which the menu engine
  trivially handles via Appendix A.6) is not the issue here.
- Be honest: if the obstruction survives mass-mixing, say so.
- Length: 1500–2500 words.
