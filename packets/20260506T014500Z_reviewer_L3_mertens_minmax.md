# Reviewer pass — L3 (Mertens minmax checklist) and folded L4 attainment

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover proof of **L3 (Mertens Cor B applied to the restricted game)**
from `phil_reny_route_memo.md`, with **L4 (existence/attainment of
$\sigma^*$) folded in via standard u.s.c.+compact attainment**. The
prover's response is **pasted verbatim below**.

## Inputs (durable sources)

- `phil_reny_route_memo.md` — live route memo. L1, L2, L7 PROVED.
- `phil_reny_bundle.md` — Phil's contribution + Mertens (1986) Cor B verbatim.
- `prior_attempts_digest.md` — dead routes.
- Paper PDF.

## Specific items the reviewer MUST audit

1. **Hausdorff via Balder quotient.** The prover proposes a route-memo
   amendment: "Σ is the Balder quotient kernel space, i.e. kernels are
   identified when they agree $\bar G$-a.e." Verify (a) that this
   identification is standard in the kernel-topology literature (Balder
   §2 quotient by null subspace); (b) that it does not change any payoff
   or add any primitive assumption; (c) that under this identification
   $T_\lambda$ is genuinely Hausdorff (the locally convex quotient is
   Hausdorff iff the null subspace is closed, which Balder confirms).
2. **Mertens Cor B citation accuracy.** Mertens (1986), §2, Corollary B,
   p. 238: $\max_\sigma \inf_\tau f(\sigma,\tau) = \inf_\tau \max_\sigma f(\sigma,\tau)$
   for compact Hausdorff $S$, arbitrary $T$, $f(\cdot,t)$ u.s.c. for each
   $t$, with $\sigma$ ranging over regular Borel probabilities on $S$ and
   $\tau$ over finitely supported probabilities on $T$. Verify the
   prover's quoting matches.
3. **Convexity collapse on $F$ side (affineness in $\varphi$).** The
   prover argues $\sum_i p_i U_F(\sigma,\varphi_i) = U_F(\sigma,\bar\varphi_\tau)$
   where $\bar\varphi_\tau = \sum_i p_i \varphi_i \in F$. Verify
   affineness in $\varphi$ holds — i.e., the misaligned term integrates
   linearly against the density. (Note: the prover wrote $\sigma(da\mid m)$
   without $\theta$ in step 5; verify this is a notational shorthand and
   the argument extends to $\sigma(da\mid m,\theta)$ by L7.)
4. **Convexity collapse on $\Sigma$ side (barycenter argument).** The
   prover uses: for compact convex $\Sigma$ in a Hausdorff locally convex
   space, every regular Borel probability $\rho$ on $\Sigma$ has a
   barycenter $b(\rho)\in\Sigma$ with $\int h\,d\rho = h(b(\rho))$ for
   continuous affine $h$. Verify (a) $\Sigma$ is compact convex in the
   Hausdorff locally convex Balder quotient; (b) the barycenter
   $b(\rho)$ exists in $\Sigma$ (rather than in some larger
   completion); (c) $U_F(\cdot,\varphi)$ is continuous affine on $\Sigma$
   for each $\varphi$.
5. **Boundedness.** $|U_F(\sigma,\varphi)| \le \|u\|_\infty$. Trivial but
   verify.
6. **Attainment of $\sigma^*$ (= L4).** $V(\sigma) := \inf_\varphi U_F(\sigma,\varphi)$
   is u.s.c. as an inf of continuous functions; $\Sigma$ compact ⇒
   attainment. Confirm the prover's argument is complete and the value
   $V^* = V(\sigma^*) = \max_\sigma \inf_\varphi U_F$ is the
   restricted-game value.
7. **Notation discipline.** The prover uses Phil's $G(\cdot\mid\omega)$,
   $\bar G$ in places and the paper's $\pi(\cdot\mid\omega)$, $\tau$ in
   others. Flag this if it muddles anything; otherwise note as cosmetic.
8. **Scope discipline.** Did the prover stop at L3 + L4 attainment? Did
   they invoke any dead-route machinery?

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

(One paragraph. If PASS, recommend the next prover target — should be
L5: Lusin-thick compact construction.)

## Detailed Review

(Per audit items 1–8.)
```

Length budget: 1500–2500 words.

---

## PROVER RESPONSE TO REVIEW (verbatim)

```
Goal for This Pass

Establish L3 for the restricted absolutely-continuous adviser game: take the agent's strategy space S:=Σ with Balder's T_λ kernel topology, take the adversary's pure set T:=F with no topology, and set f(σ,φ):=U_F(σ,φ). The objective is to verify Mertens's hypotheses one by one, apply Mertens (1986), §2, Corollary B, p. 238, and then collapse both sides of Mertens's mixed-strategy statement back to the pure restricted-game equality by convexity and affineness. The pass stays inside the restricted F-game; it does not attempt the Lusin lift to unrestricted adviser kernels.

Main Work
Target 1: L3 — Mertens minmax checklist

Claim: In the restricted game where the misaligned adviser uses densities φ(m|s) with respect to Ḡ := Σ_ω μ_0(ω) G(·|ω), the payoff U_F : Σ × F → ℝ satisfies Mertens's hypotheses. Therefore, max_{σ∈Σ} inf_{φ∈F} U_F(σ,φ) = inf_{φ∈F} max_{σ∈Σ} U_F(σ,φ). Moreover, the left-hand maximum is attained by some pure kernel σ*∈Σ.

Argument:

Step 1: Σ is compact Hausdorff in T_λ.
By L2, Σ is compact in the Balder topology T_λ. Here T_λ is the topology of weak convergence of the induced joint measures σG(·|ω), for each ω, exactly as in Phil's note: σ_n→σ iff σ_n G(·|ω) weak*-converges to σG(·|ω) for each ω, and Phil records that Σ is compact under this topology.

For Hausdorffness, use Balder's quotient formulation of kernel weak convergence. Balder defines the null subspace X and the quotient map, and states that because X is weakly closed, the quotient space is a Hausdorff topological vector space and is locally convex. In the game application, Balder then records that the relevant strategy image R_i is a compact convex subset of that Hausdorff locally convex space, citing Theorem 2.3(a). This is exactly the kernel-space point needed here: Σ should be read as the Balder quotient of kernels modulo Ḡ-a.e. equality. Since μ_0 has full support, Ḡ-null sets are precisely the sets null for every G(·|ω), so the finite family (G(·|ω))_{ω∈Ω} separates the same payoff-relevant equivalence classes. On raw pointwise representatives the topology would generally fail to be Hausdorff, because kernels differing only on Ḡ-null messages cannot be separated. On the Balder quotient, it is Hausdorff.

Step 2: U_F(σ,φ) is continuous, hence u.s.c., in σ for each φ∈F.
This is precisely L1.

Step 3: U_F is bounded from above and below.
The model's primitive payoff u is bounded, and α∈[0,1]. Each term in U_F is an expectation of u under a probability law, and the two terms are combined with weights α and 1−α. Hence, for every (σ,φ), -‖u‖_∞ ≤ U_F(σ,φ) ≤ ‖u‖_∞, |U_F(σ,φ)| ≤ ‖u‖_∞.

Step 4: Apply Mertens Corollary B.
Mertens (1986), §2, Corollary B, p. 238: for compact Hausdorff S, arbitrary T, and f(s,t) u.s.c. on S for each t∈T, max_ρ inf_τ f(ρ,τ) = inf_τ max_ρ f(ρ,τ), where ρ ranges over regular Borel probabilities on S, and τ ranges over finitely supported probabilities on T. Applying this with S=Σ, T=F, and f=U_F yields the mixed-strategy form (M).

Step 5: Affineness lemma and adversary-side convexity collapse.
For fixed φ, U_F(·,φ) is affine in σ. For fixed σ, U_F(σ,·) is affine in φ. Thus, for τ=Σ_i p_i δ_{φ_i}, define the finite barycenter φ̄_τ := Σ_i p_i φ_i. Since F is convex, φ̄_τ ∈ F, and by affineness, Σ_i p_i U_F(σ,φ_i) = U_F(σ,φ̄_τ). Therefore inf_{τ∈Δ_f(F)} Σ_i p_i U_F(σ,φ_i) = inf_{φ∈F} U_F(σ,φ).

Step 6: Agent-side convexity collapse and pure-strategy attainment.
Because Σ is a compact convex subset of Balder's Hausdorff locally convex quotient space, every regular Borel probability ρ∈P_R(Σ) has a barycenter b(ρ)∈Σ. For every continuous affine function h on Σ, ∫_Σ h(σ)ρ(dσ) = h(b(ρ)). Applying this to h(σ)=U_F(σ,φ) gives ∫_Σ U_F(σ,φ)ρ(dσ) = U_F(b(ρ),φ). Now collapse the left side of (M): max_ρ inf_τ Ū(ρ,τ) = max_ρ inf_φ U_F(b(ρ),φ) = max_σ inf_φ U_F(σ,φ). Similarly for the right side.

Finally, define V(σ) := inf_{φ∈F} U_F(σ,φ). Since V is the infimum of continuous functions of σ, V is upper semicontinuous. Since Σ is compact, V attains its maximum. Hence there exists σ*∈Σ with inf_φ U_F(σ*,φ) = max_σ inf_φ U_F(σ,φ).

[DERIVED] L3 is established for the restricted F-game: max_σ inf_φ U_F(σ,φ) = inf_φ max_σ U_F(σ,φ), and the agent-side maximum is attained by a pure kernel σ*∈Σ.

Target 2: Subquestion answers

1. Compactness and Hausdorff. Compactness is L2. Hausdorffness holds on the Balder quotient kernel space. The quotient caveat is essential only if Σ was written as raw kernels rather than payoff-relevant equivalence classes.

2. U.s.c. in σ for each φ. L1 gives continuity, hence u.s.c.

3. Bounded payoff. |U_F| ≤ ‖u‖_∞.

4. Convexity collapse on F side. Affineness + convexity of F.

5. Convexity collapse on Σ side. Barycenter argument in Hausdorff locally convex space.

6. Affineness verification. The payoff is affine in σ (linear integration against σ(da|m)) and affine in φ (linear in the density).

7. Agent-side maximum attainment. V(σ)=inf_φ U_F(σ,φ) is u.s.c., Σ compact.

Assumption Changes

[ASSUMPTION-] No new model assumption is needed.
[ASSUMPTION-] No topology on F is introduced.

Breakdown Amendments

[BREAKDOWN_AMEND] Make explicit in the route memo that Σ is the Balder quotient kernel space, i.e. kernels are identified when they agree Ḡ-a.e. Without this standard identification, T_λ can fail Hausdorff on raw representatives because null-set modifications cannot be separated. This amendment changes no payoff and adds no primitive assumption.

Status Summary

L3 status: PROVED, with the standard Balder quotient clarification for Hausdorffness.

Exact Next Obstacle

L4 is now almost mechanical on the existence side: define σ*∈argmax_{σ∈Σ} inf_{φ∈F} U_F(σ,φ) using the attainment just proved. The next substantive obstacle is L5, the Lusin-compact lift from F back to unrestricted measurable adviser deviations.
```
