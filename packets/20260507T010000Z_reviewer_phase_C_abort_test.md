# Reviewer pass — Phase C abort test (verdict NEG)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover output for the Phase C abort test, with verdict **NEG**:
the menu engine does **not** fix the ternary non-radial Hall
obstruction. Even with set-valued mass-mixing over the rowwise
minimizer correspondence, the posterior at the boundary message
$t_0 = (0.4, 0.3, 0.3)$ cannot land in the Bayes cone $B(t_0)$.

The sharp computation:
- $C^* = \{v_0, v_1, v_2\}$ (three discrete profile vertices).
- $R(t_0) = \{v_1, v_2\}$ (rowwise minimizer set has two elements).
- $B(t_0) = \{p : p_0 \ge p_1, p_0 \ge p_2\}$ (Bayes cone for $a_0$).
- Misaligned mass arriving at $t_0$ comes from
  $K_0^- = \{s : s_0 \le s_1, s_0 \le s_2\}$.
- Barycenter of misaligned mass stays in $K_0^-$.
- $K_0^- \cap B(t_0)$ = uniform prior point only (zero mass under
  atomless τ).

Conclusion: the obstruction is intrinsic multi-dim vector balance,
not the deterministic-vs-set-valued dichotomy.

Full prover response:
`logs/20260507T002000Z_prover_phase_C_abort_test_response.md`.

## Items to audit

1. **$C^* = \{v_0, v_1, v_2\}$ identification.** For the TR-strategy
   $\hat\sigma^*(m) = $ plurality vertex of $P_T(m)$ with discrete
   $A = \{a_0,a_1,a_2\}$ and the given utilities, the image $C^*$ has
   exactly three profile vectors $v_\omega = (-1,...,1,...,-1)$ at
   coordinate $\omega$. Verify.
2. **$R(t_0) = \{v_1, v_2\}$.** At $s = t_0 = (0.4, 0.3, 0.3)$,
   $s\cdot v_\omega = -0.4 - 0.3 - 0.3 + 2s(\omega) = -1 + 2 s(\omega)$.
   So $s\cdot v_0 = -0.2$, $s\cdot v_1 = -0.4$, $s\cdot v_2 = -0.4$.
   Min is $-0.4$, attained at $v_1$ and $v_2$. Verify.
3. **$B(t_0)$ identification.** $\hat\sigma^*(t_0) = a_0$ since $t_0$
   has plurality on state 0. Bayes cone for $a_0$: posterior $p$ at
   which playing $a_0$ is optimal — $p\cdot v_0 \ge p\cdot v_\omega$
   for $\omega\ne 0$, equivalent to $p_0 \ge p_1, p_0\ge p_2$. Verify.
4. **Source cone $K_0^-$.** Mass sent to $t_0$-label by the misaligned
   adviser must come from posteriors where $t_0$ is a row minimizer
   — i.e., where $t_0\in R(s)$. Verify $K_0^- = \{s : s_0 \le s_1, s_0\le s_2\}$.
   Hmm wait — actually $t_0\in R(s)$ requires $s\cdot t_0 \le s\cdot v$
   for all $v\in C^*$ visible at $t_0$. But $t_0$ isn't in $C^*$; the
   selectors at $t_0$ are $\{v_1, v_2\}$. So mass sent to the
   $t_0$-LABEL means the adversary picks $m^*(s) = t_0$, which
   requires $t_0$-label to give the min. $\hat\sigma^*(t_0) = a_0$
   (plurality). The adversary picks message $t_0$ to make the agent
   play $a_0$, which is bad in states $\omega = 1, 2$. So adversary
   sends from $s$ with $s_0$ small relative to $s_1, s_2$ — that's
   $K_0^-$. Verify carefully.
5. **Barycenter argument.** Conditional source mean given
   $\beta^*(\cdot\mid\cdot)\restriction (\cdot, t_0)$ is in
   $\overline{\mathrm{conv}}(K_0^-)$. Conv hull of $K_0^-$ is in
   $\{s : s_0 \le 1/3\}$. $B(t_0) \subseteq \{p : p_0 \ge 1/3\}$. So
   barycenter of source mass + truthful prior at $t_0$ — is the
   convex combination $\alpha\cdot t_0 + (1-\alpha)\cdot \bar s$ where
   $\bar s\in\mathrm{conv}(K_0^-)$. For this to land in $B(t_0)$
   requires the barycenter's first coordinate to be at least the
   second and third. With $t_0$'s first coordinate at $0.4$ and
   $\bar s$'s first coordinate at most $1/3$, the barycenter's
   first coordinate is at most $0.4\alpha + (1-\alpha)/3$, which is
   less than $0.4$ for $\alpha < 1$. Whether this satisfies
   $\ge p_1, \ge p_2$ depends on $\bar s_1, \bar s_2$.
   **Verify the conclusion that for atomless $\tau$ with positive
   mass on $K_0^-$, the calibration fails.**
6. **Honest scope.** The verdict says "the obstruction is intrinsic
   multi-dim vector balance, not the deterministic-vs-set-valued
   dichotomy." Verify this is the right takeaway and not an
   overstatement. (Maybe a non-discrete $A$ or a richer trust region
   would make $C^*$ richer with new mixing options.)

## Output Format

```
\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: PROVER / BREAKDOWN / SEARCHER / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict

VERDICT: ...
Reason: ...

## Opinion and Next Move

(One paragraph. Recommend: accept the abort verdict and consolidate
the menu engine as the new Tier-1 theorem with menu-Hall as the
conditional, OR push for additional structural conditions on $C^*$
that might salvage Tier-2.)

## Detailed Review

(Per audit items 1–6.)
```

Length: 1200–1800 words.
