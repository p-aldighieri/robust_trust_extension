
========
ROLE: user (id=58d3290e-4b9d-430e-9def-29d22a2fce75)
========
# Reviewer pass — L2 (compactness of $\Sigma$)

You are the Reviewer in the soft-scaffolding workflow.

## What you are reviewing

A prover proof of **L2 (compactness of $\Sigma$)** from
phil_reny_route_memo.md. The prover's response is **pasted verbatim
below**. Your job is to audit it for mathematical correctness, citation
accuracy, and scope fidelity.

## Inputs (durable sources)

- phil_reny_route_memo.md — live route memo. L1 is PROVED (Balder
  Theorem 2.2 p. 268). L2 is the current target.
- phil_reny_bundle.md — Phil's contribution + Balder/Mertens précis.
- prior_attempts_digest.md — dead routes; sanity check.
- Paper PDF for canonical notation.

## Specific items the reviewer MUST audit

1. **Topology choice (single-base vs simultaneous).** The prover picks
   $T_\lambda$ with $\lambda = \tau\otimes\bar f$, $\bar f = \sum_\omega
   \mu_0(\omega) f(\cdot\mid\omega)$. Verify (a) that
   $\lambda_\omega^\pi := \pi(\cdot\mid\omega)\otimes f(\cdot\mid\omega)\ll\lambda$
   and $\lambda_\omega^\tau := \tau\otimes f(\cdot\mid\omega)\ll\lambda$;
   (b) that $\lambda$ is recoverable as the finite mixture
   $\sum_\omega \mu_0(\omega)\lambda_\omega^\tau$; (c) that convergence
   in $T_\lambda$ is equivalent to simultaneous convergence in all the
   $T_{\lambda_\omega^\pi}$ and $T_{\lambda_\omega^\tau}$ topologies via
   Radon-Nikodym multiplication of test functions.
2. **Compactness citation.** The prover cites **Balder (1988) §2 Theorem 2.3(a)**
   for compactness of transition probabilities into a compact metric
   action space. Verify Theorem 2.3(a) is exactly this — weak compactness
   of $\{\sigma:X\to\Delta(A) \text{ measurable}\}$ when $A$ is compact
   metric/metrizable Lusin, with no extra tightness needed.
3. **Common-kernel extraction lemma.** The prover proves: if simultaneous
   weak limits $Q_\omega^\pi$ and $Q_\omega^\tau$ exist for every $\omega$,
   then ONE common measurable kernel $\sigma$ satisfies $Q_\omega^\tau =
   \sigma\,\lambda_\omega^\tau$ and $Q_\omega^\pi = \sigma\,\lambda_\omega^\pi$.
   Audit:
   - The finite-mixture $Q := \sum_\omega \mu_0(\omega)\,Q_\omega^\tau$ is
     a Balder-weak limit of $\sigma_i\lambda$ (does this need bounded
     Carathéodory tests, or can it be done with $L^1$-dominated tests?).
   - Disintegration $Q(dx,da) = \lambda(dx)\,\sigma(da\mid x)$ on a
     standard Borel space — verify the standard-Borel hypothesis
     holds for $X = M\times\Theta$.
   - The Radon-Nikodym multiplication step: $r_\omega^\tau := d\lambda/d\lambda_\omega^\tau$
     — verify this is in $L^1$ (it had better not be the inverse, since
     $\lambda_\omega^\tau\ll\lambda$, NOT the other way around). Same
     for $h_\omega := d\tau/d\pi(\cdot\mid\omega)$ — wait, we have
     $\pi(\cdot\mid\omega)\ll\tau$, so the natural Radon-Nikodym density
     is $d\pi(\cdot\mid\omega)/d\tau$, not the inverse. Check the prover
     hasn't inverted a Radon-Nikodym density.
4. **Theorem 2.5 (product-kernel) explicitly NOT needed.** The prover
   claims Theorem 2.5 doesn't enter L2 because all base laws are fixed.
   Verify this is correct.
5. **Standing-hypotheses sanity.** Did the prover smuggle any new
   hypothesis on $f(\cdot\mid\omega)$, on $\pi(\cdot\mid\omega)$, or on
   the relationship between them?
6. **Scope discipline.** Did the prover stop at L2, or did they overrun
   into L7 / L3? Did they invoke any dead-route machinery?

## Output Format


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

(One paragraph. If PASS, recommend the next prover target — should be L7.)

## Detailed Review

### Step-by-Step Audit

(Per audit item 1–6 above. Specific findings or "Pass" with one-line
justification.)

### Citation Audit

- Balder Theorem 2.3(a) — does it exist and say what the prover claims?
- Theorem 2.5 — does the prover correctly skip it?

### Radon-Nikodym sanity check

- Are the densities $r_\omega^\tau = d\lambda_\omega^\tau/d\lambda$ (or
  $d\lambda/d\lambda_\omega^\tau$) and $h_\omega = d\pi(\cdot\mid\omega)/d\tau$
  (or its inverse) named correctly and in the right direction?

### Scope and Assumptions

- New assumptions:
- Scope drift:
- Dead-route machinery invoked:

### Concrete Fixes or Hints for the Next Pass

- (Focused patch instructions.)


## Length budget

1500–2500 words.

---

## PROVER RESPONSE TO REVIEW (verbatim)


Goal for This Pass

Establish L2: compactness of the agent kernel space Σ in the Balder weak, or stable, topology needed for L1, while making sure that limits of the ω-indexed joint laws are induced by one common measurable kernel σ:M×Θ→Δ(A), not by a constellation of unrelated ω-specific kernels. The route memo flags exactly this "one common kernel" point as the L2 issue, with θ kept inside the base coordinate (m,θ).

Main Work
Target 1: L2 — Compactness of Σ

Claim: Let

X := M×Θ,
f̄ := Σ_{ω∈Ω} μ_0(ω) f(⋅∣ω),
λ := τ⊗f̄.

Endow Σ, the measurable kernels σ:X→Δ(A), with the Balder weak topology T_λ:

σ_i → σ

iff for every Carathéodory test g:X×A→ℝ, measurable in x=(m,θ), continuous in a, and dominated by some q∈L^1(λ),

∫_X ∫_A g(x,a)σ_i(da∣x)λ(dx) → ∫_X ∫_A g(x,a)σ(da∣x)λ(dx).

Then Σ is compact in T_λ. Moreover, this single-base topology is equivalent to the route memo's simultaneous topology requiring Balder-weak convergence for all

λ_ω^π := π(⋅∣ω)⊗f(⋅∣ω),  λ_ω^τ := τ⊗f(⋅∣ω),

and every simultaneous limit is induced by one common measurable kernel σ.

Argument:

Step 1: Choose the working topology.

Use T_λ, the single Balder weak topology generated by the common base λ=τ⊗f̄, f̄=Σ_ω μ_0(ω)f_ω.

This is cleaner than carrying 2|Ω| marginal topologies in parallel.

Justification: Since τ=Σ_{ω'} μ_0(ω')π(⋅∣ω') and μ_0 has full support, π(⋅∣ω)≪τ for every ω. Similarly, f_ω:=f(⋅∣ω)≪f̄. Hence λ_ω^π≪λ, λ_ω^τ≪λ.

Conversely, λ=τ⊗f̄=Σ_ω μ_0(ω)(τ⊗f_ω)=Σ_ω μ_0(ω)λ_ω^τ.

Thus convergence in T_λ implies convergence for every λ_ω^π and λ_ω^τ by multiplying tests by the relevant Radon-Nikodym density. The multiplied test remains a Balder Carathéodory integrand because Balder allows L^1-domination in the base variable. Balder §2 defines the weak topology on transition probabilities by continuity of I_g for Carathéodory g, and Theorem 2.2 identifies this as an equivalent portmanteau-style characterization.

The reverse implication follows from the finite mixture identity above: ∫g d(σ_iλ) = Σ_ω μ_0(ω) ∫g d(σ_i λ_ω^τ), so simultaneous convergence for the τ⊗f_ω marginals implies convergence under λ. The π-marginals are then recovered from the τ-marginals using π_ω≪τ. This keeps θ in the base coordinate throughout.

Step 2: Establish compactness of the kernel space.

Apply Balder §2, Theorem 2.3(a), to the finite measure space (X,B(X),λ) and the compact metric action space A. Balder's setup defines transition probabilities from a finite measure space (T,T,μ) into a metrizable Lusin action space; compact metric A is a metrizable Lusin space. Balder §2 then defines the weak topology by Carathéodory integral functionals I_g. The compactness result itself is Theorem 2.3(a): the set of transition probabilities into the compact action space is weakly compact.

Justification: No extra tightness assumption is needed. In the usual Prohorov language, the fiber laws σ(⋅∣x)∈Δ(A) are uniformly tight because A itself is compact: σ(A∣x)=1 for every x∈X.

Balder's §3 equilibrium proof confirms this is exactly the compact-action case: condition (C3) assumes each action space A_i is compact metric, and the proof invokes Theorem 2.3(a) to obtain compact convex strategy sets. So the precise compactness hammer is Balder §2, Theorem 2.3(a), not Theorem 2.5.

Step 3: Prove the common-kernel extraction lemma.

Lemma, common-kernel extraction. Let (σ_i)⊂Σ be a net, and suppose that for every ω the joint laws σ_i(da∣x)λ_ω^τ(dx) and σ_i(da∣x)λ_ω^π(dx) have Balder-weak limits Q_ω^τ and Q_ω^π, respectively. Then there exists one measurable kernel σ:X→Δ(A) such that Q_ω^τ(dx,da) = λ_ω^τ(dx)σ(da∣x), Q_ω^π(dx,da) = λ_ω^π(dx)σ(da∣x) for every ω. The equalities are understood up to the corresponding base-null sets.

Proof. First form the finite mixture Q := Σ_ω μ_0(ω) Q_ω^τ.

For every bounded or L^1-dominated Carathéodory g, ∫g dQ = lim_i Σ_ω μ_0(ω) ∫g d(σ_i λ_ω^τ) = lim_i ∫g d(σ_i λ).

Thus Q is the Balder-weak limit of σ_iλ. Its marginal on X is λ, because tests g(x,a)=φ(x) with bounded measurable φ are admissible. Since X×A is standard Borel, disintegrate: Q(dx,da) = λ(dx)σ(da∣x) for some measurable kernel σ.

Now fix ω, and let r_ω^τ := dλ/dλ_ω^τ ∈ L^1(λ).

For any bounded Carathéodory g, ∫g dQ_ω^τ = lim_i ∫g(x,a)σ_i(da∣x)λ_ω^τ(dx) = lim_i ∫r_ω^τ(x)g(x,a)σ_i(da∣x)λ(dx).

The product r_ω^τ g is still an admissible Balder test: measurable in x, continuous in a, and dominated by an L^1(λ) function. By Balder §2, Theorem 2.2, the last expression converges to ∫r_ω^τ(x)g(x,a)σ(da∣x)λ(dx) = ∫g(x,a)σ(da∣x)λ_ω^τ(dx).

Hence Q_ω^τ = σλ_ω^τ.

Finally let h_ω := dτ/dπ(⋅∣ω), λ_ω^π = h_ω λ_ω^τ.

The same Radon-Nikodym multiplication gives, for every admissible g, ∫g dQ_ω^π = lim_i ∫h_ω g d(σ_iλ_ω^τ) = ∫h_ω g dQ_ω^τ = ∫g d(σλ_ω^π).

Therefore Q_ω^π = σλ_ω^π. This proves that the π-side and τ-side limits are not independent little planets orbiting Ω; they are all shadows cast by the same kernel σ. The Balder theorem used in this extraction is §2, Theorem 2.2; the remaining step is standard disintegration on standard Borel spaces.

Step 4: Stitch.

Balder §2, Theorem 2.3(a), gives compactness of Σ in T_λ. Step 1 shows T_λ is equivalent to the route memo's simultaneous topology. Step 3 shows that any simultaneous limit is represented by one measurable kernel σ, with all ω-indexed π- and τ-marginals recovered by changing the base measure via Radon-Nikodym densities.

[DERIVED] L2 is established: Σ is compact in the Balder weak topology relevant for L1, and compactness produces common-kernel limits.

Target 2: Subquestion answers

1. Common-kernel issue. The common-kernel lemma above resolves it. The move is to introduce the dominating base λ=τ⊗f̄, take the finite mixture of the τ⊗f_ω limits, disintegrate that mixture into one kernel σ, and then use Radon-Nikodym multiplication plus Balder §2, Theorem 2.2, to prove every ω-indexed limit is the corresponding restriction of σ. The hypothesis π(⋅∣ω)≪τ is exactly what forces the π-marginals to agree with the τ-side kernel.

2. Choice of topology. The cleaner statement of L2 is the single-base Balder topology T_{τ⊗f̄}. The simultaneous 2|Ω|-marginal topology in the route memo is equivalent because the λ_ω^π and λ_ω^τ bases are dominated by τ⊗f̄, while τ⊗f̄ is a finite mixture of the τ⊗f_ω bases. The π-marginals should be treated as recovered ex post.

3. Compactness reference. The exact compactness citation is Balder (1988), §2, Theorem 2.3(a): weak compactness of the set of transition probabilities into the compact action space. Balder §3, Theorem 3.1 is an equilibrium theorem, not the primitive compactness theorem; its proof uses Theorem 2.3(a) after imposing compact metric action spaces. Tightness is automatic because all action laws live on compact A.

4. Product-kernel continuity, Theorem 2.5. Theorem 2.5 does not enter L2. It states continuity of the product mapping for transition probabilities, and Balder uses it in §3 to prove expected-payoff continuity when product kernels vary. Here f(⋅∣ω), π(⋅∣ω), and τ are fixed base laws, and θ is already inside the base coordinate x=(m,θ). Radon-Nikodym transfer plus Theorem 2.2 is enough.

Assumption Changes

[ASSUMPTION-] No new tightness, bounded-density, or equivalence assumption is needed.

[ASSUMPTION-] No additional condition on f(⋅∣ω) is needed beyond the standing finite-Ω, full-support mixture setup.

Breakdown Amendments

[BREAKDOWN_AMEND] Restate L2 using the single dominating base λ=τ⊗f̄, f̄=Σ_ω μ_0(ω)f(⋅∣ω), and treat the route memo's simultaneous π- and τ-marginal convergence as the equivalent derived formulation.

[BREAKDOWN_AMEND] Correct the compactness reference: use Balder §2, Theorem 2.3(a). Balder §3 confirms this usage in the compact-action equilibrium proof; Theorem 2.5 is not the L2 compactness input.

Status Summary

L2 status: PROVED.

Exact Next Obstacle

Proceed to L7 — reintroducing θ as the next route-memo item. The present proof already keeps θ in the base coordinate (m,θ), so L7 should now be a verification pass rather than a new compactness argument.



========
ROLE: assistant (id=608f518a-4f36-49f5-9bd3-0fe81a1cd299)
========
review_control
verdict: PATCH_SMALL
route_status: viable
recommended_next_phase: PROVER
proof_status: partial
Verdict

VERDICT: PATCH_SMALL
Reason: The route is viable and the compactness theorem is the right hammer, but the common-kernel extraction contains two Radon-Nikodym inversions. As written, it uses densities that may not exist: dλ/dλ
ω
τ
	​

 and dτ/dπ(⋅∣ω). Correcting these to dλ
ω
τ
	​

/dλ and dπ(⋅∣ω)/dτ repairs the proof. This is a local but central error, not a cosmetic one: left unpatched, it smuggles equivalence assumptions that are not in the standing hypotheses.

Opinion and Next Move

Do a targeted prover patch, then move to L7. The proof has the right architecture: use the single dominating base λ=τ⊗
f
ˉ
	​

, apply Balder compactness for kernels into compact A, and recover all ω-indexed limits through one disintegration. The density arrows need to be turned around, and the finite-mixture argument should explicitly handle L
1
-dominated tests using λ
ω
τ
	​

≤μ
0
	​

(ω)
−1
λ. After that, L2 is ready to bank and the next target should indeed be L7, since the route memo lists L7 immediately after L2 and before Mertens/Lusin assembly. 

phil_reny_route_memo

Detailed Review
Step-by-Step Audit

1. Topology choice: single-base vs simultaneous. Mostly pass, with the same RN-direction caveat. The choice

λ=τ⊗
f
ˉ
	​

,
f
ˉ
	​

=
ω
∑
	​

μ
0
	​

(ω)f(⋅∣ω)

is sound. Since μ
0
	​

 has full support and

τ=
η
∑
	​

μ
0
	​

(η)π(⋅∣η),

we have π(⋅∣ω)≪τ. Likewise f(⋅∣ω)≪
f
ˉ
	​

. Hence

λ
ω
π
	​

=π(⋅∣ω)⊗f(⋅∣ω)≪λ,λ
ω
τ
	​

=τ⊗f(⋅∣ω)≪λ.

Also,

λ=τ⊗
f
ˉ
	​

=
ω
∑
	​

μ
0
	​

(ω)(τ⊗f(⋅∣ω))=
ω
∑
	​

μ
0
	​

(ω)λ
ω
τ
	​

.

So item (a) and (b) pass.

For item (c), T
λ
	​

⇒T
λ
ω
π
	​

	​

,T
λ
ω
τ
	​

	​

 uses multiplication by dλ
ω
π
	​

/dλ or dλ
ω
τ
	​

/dλ, not the inverse. The reverse direction is also valid: simultaneous convergence for the τ-bases implies T
λ
	​

-convergence by the finite mixture identity. For L
1
-dominated tests this is legitimate because

μ
0
	​

(ω)λ
ω
τ
	​

≤λ,

so q∈L
1
(λ)⇒q∈L
1
(λ
ω
τ
	​

). The π-bases are then recovered from the τ-bases through dπ(⋅∣ω)/dτ.

2. Compactness citation. Pass. Balder’s setup is indeed transition probabilities from a fixed finite measure space into a metrizable Lusin target. He defines a transition probability as a kernel from a fixed finite measure space (T,T,μ) into (Z,B(Z)). 
ResearchGate
 He defines Carathéodory integrands as measurable in the base variable, continuous in the target variable, and dominated by an L
1
(T) function. 
ResearchGate
 He then defines the weak topology as the coarsest topology making the relevant I
g
	​

 functionals continuous. 
ResearchGate
 Theorem 2.3(a) states weak compactness of the transition-probability set in the relevant compact target setting. 
ResearchGate
 Since our A is compact metric under the paper’s standing assumptions, no extra tightness hypothesis is needed. 

objective_statement

Small wording patch: say “Balder Theorem 2.3(a), applied with compact metric target A” rather than “metrizable Lusin target” alone. A merely Lusin noncompact action space would need tightness/inf-compact machinery; compactness of A is doing real work here.

3. Common-kernel extraction lemma. Structure pass, execution patch required.

The finite-mixture step is correct after one explicit sentence: if g is T
λ
	​

-admissible and ∣g∣≤q∈L
1
(λ), then q∈L
1
(λ
ω
τ
	​

) because λ
ω
τ
	​

≤μ
0
	​

(ω)
−1
λ. Therefore

∫gdQ=
ω
∑
	​

μ
0
	​

(ω)∫gdQ
ω
τ
	​

=
i
lim
	​

ω
∑
	​

μ
0
	​

(ω)∫gd(σ
i
	​

λ
ω
τ
	​

)=
i
lim
	​

∫gd(σ
i
	​

λ).

This works for L
1
-dominated Carathéodory tests, not only bounded ones. Balder’s Theorem 2.2 supports this portmanteau/topology characterization by continuity of the I
g
	​

 functionals. 
ResearchGate

Disintegration is fine. M⊆Δ(Ω), with Ω finite, and Θ compact metric, so X=M×Θ is standard Borel; A is compact metric, hence standard Borel. The paper’s model supplies these compact metric/Borel hypotheses. 

objective_statement

 Thus Q(dx,da)=λ(dx)σ(da∣x) is legitimate.

The RN multiplication step is the broken part. It must read:

r
ω
τ
	​

:=
dλ
dλ
ω
τ
	​

	​

,

not dλ/dλ
ω
τ
	​

. Then

∫gd(σ
i
	​

λ
ω
τ
	​

)=∫r
ω
τ
	​

(x)g(x,a)σ
i
	​

(da∣x)λ(dx).

Similarly, for the π-side,

h
ω
	​

:=
dτ
dπ(⋅∣ω)
	​

,λ
ω
π
	​

=h
ω
	​

λ
ω
τ
	​

.

The prover wrote h
ω
	​

=dτ/dπ(⋅∣ω), which is the wrong direction and need not exist.

4. Theorem 2.5 explicitly not needed. Pass. Theorem 2.5 is about weak convergence of product transition probabilities; Balder’s own introduction to §2 labels it as the product-transition-probability result. 
ResearchGate
 L2 varies only the agent kernel σ over a fixed base law. The base laws λ,λ
ω
π
	​

,λ
ω
τ
	​

 are not themselves varying kernels, and θ is already inside x=(m,θ). Theorem 2.5 may be useful elsewhere, but not for this compactness lemma.

5. Standing-hypotheses sanity. Pass after RN patch. The proof uses only: finite Ω, full-support μ
0
	​

, compact metric A,Θ, measurable f(⋅∣ω), and the mixture definitions of τ,
f
ˉ
	​

. The paper and route memo have those assumptions. 

objective_statement

 As written, however, the inverted densities would silently require λ≪λ
ω
τ
	​

 and τ≪π(⋅∣ω), which are not standing assumptions and are generally false.

6. Scope discipline. Pass. The prover stops at L2, with only a note that L7 should come next. That matches the route memo’s attack order. 

phil_reny_route_memo

 No product-of-narrow/Sion replay, adversary-side compactness, exact raw lifting, or other banned machinery appears. The prior-attempt digest explicitly warns against those routes, and the prover avoids them. 

prior_attempts_digest

Citation Audit

Balder Theorem 2.3(a). Yes, it exists and is the right compactness citation for this L2, provided it is applied with compact metric A. Balder sets up finite base measure spaces and transition probabilities, defines the weak topology through Carathéodory integral functionals, and states weak compactness in Theorem 2.3(a). 
ResearchGate
+3
ResearchGate
+3
ResearchGate
+3

Balder Theorem 2.2. The prover’s use of Theorem 2.2 for transfer via test functions is appropriate. The theorem states the weak topology through equivalent continuity conditions for the relevant I
g
	​

 functionals, including Carathéodory tests. 
ResearchGate

Theorem 2.5. Correctly skipped for L2. It is the product-kernel continuity theorem, while L2 is compactness of a single kernel space under fixed base laws. 
ResearchGate

Radon-Nikodym sanity check

The correct density for τ-side transfer is

r
ω
τ
	​

=
dλ
dλ
ω
τ
	​

	​

,

not 
dλ
ω
τ
	​

dλ
	​

. It is even bounded by 1/μ
0
	​

(ω), since

λ=
η
∑
	​

μ
0
	​

(η)λ
η
τ
	​

≥μ
0
	​

(ω)λ
ω
τ
	​

.

The correct density for π-side transfer from λ
ω
τ
	​

 is

h
ω
	​

=
dτ
dπ(⋅∣ω)
	​

,λ
ω
π
	​

=h
ω
	​

λ
ω
τ
	​

,

not dτ/dπ(⋅∣ω). This h
ω
	​

 is also bounded by 1/μ
0
	​

(ω), because τ≥μ
0
	​

(ω)π(⋅∣ω).

For direct transfer from λ to λ
ω
π
	​

, use

dλ
dλ
ω
π
	​

	​

=
dτ
dπ(⋅∣ω)
	​

(m)
d
f
ˉ
	​

df(⋅∣ω)
	​

(θ).
Scope and Assumptions

New assumptions: None after the RN fix. As written, the inverse densities accidentally smuggle λ≪λ
ω
τ
	​

 and τ≪π(⋅∣ω). Delete that ghost baggage.

Scope drift: Minimal. The note about L7 is only a next-step pointer.

Dead-route machinery invoked: None.

Concrete Fixes or Hints for the Next Pass

Replace every occurrence of dλ/dλ
ω
τ
	​

 with dλ
ω
τ
	​

/dλ.

Replace h
ω
	​

=dτ/dπ(⋅∣ω) with h
ω
	​

=dπ(⋅∣ω)/dτ.

In the mixture-limit paragraph, add:

λ
ω
τ
	​

≤μ
0
	​

(ω)
−1
λ,

so any T
λ
	​

-admissible L
1
(λ)-dominating function is also L
1
(λ
ω
τ
	​

). That closes the L
1
-dominated test issue.

State the compactness citation as: “Balder (1988), §2, Theorem 2.3(a), applied to the finite base (X,B(X),λ) and compact metric target A.”

After the patch, mark L2 proved and send the next prover to L7.
