Robust Trust Theorem 2 - infinite-$M$, $\Theta$ extension via the payoff-profile menu engine
1. The setting and the question

We keep the standing hypotheses of Dworczak-Smolin: finite $\Omega$, full-support prior $\mu_0$, compact metric $A$ and $\Theta$, bounded payoff $u(a,\omega,\theta)$ continuous in $a$, conditional independence of the adviser posterior $s$ and the private type $\theta$ given $\omega$, and Borel measurability throughout. The adviser posterior has law $\tau$ on $M=\operatorname{supp}\tau\subseteq\Delta(\Omega)$; the agent chooses a measurable strategy $\sigma:M\times\Theta\to\Delta(A)$; the misaligned adviser chooses a measurable kernel $\beta:M\to\Delta(M)$. The original Theorem 2 says that robust rationalizability implies optimality, and proves existence when $M$ and $\Theta$ are finite; the paper flags the infinite cheap-talk-like case as technically hard because messages affect payoffs endogenously. The question is whether the existence direction survives for infinite $M$ and compact metric $\Theta$. The Phase C answer is: Tier 1 survives under the paper’s standing hypotheses alone by moving from kernel compactness to the finite-dimensional payoff-profile menu; Tier 2 remains conditional, but the right condition is set-valued menu-Hall calibration, not the previous deterministic TRE-gen-Hall framing. 

objective_statement

 

objective_statement

2. Main theorem, two tiers, menu engine version

Theorem (Tier 1). Under the standing hypotheses of Dworczak-Smolin, there exist $\sigma^\in\Sigma$ and $\beta^\in B$ such that

U(σ
∗
)=U
∗
=
σ∈Σ
sup
	​

U(σ)

and

U(β
∗
,σ
∗
)=
β∈B
inf
	​

U(β,σ
∗
)=U
∗
.

No A5-thick, no A8c-attain, and no TRE-gen-Hall type hypothesis is needed for Tier 1.

Theorem (Tier 2). Under the standing hypotheses plus menu-Hall, there exists a coupling

γ
α
	​

(ds,dm)=α(id,id)
#
	​

τ(ds,dm)+(1−α)τ(ds)κ(dm∣s)

on $M\times M$, with $\kappa(\cdot\mid s)$ supported on the realized rowwise minimizer fiber

R
M
	​

(s):={m∈M:w
∗
(m)∈R(s)},R(s):=arg
w∈C
∗
min
	​

s⋅w,

such that the induced posterior

P
γ
α
	​

	​

(⋅∣m)=E
γ
α
	​

	​

[s∣m]

lies in the Bayes cone

B(m):={μ∈Δ(Ω):
σ
^
∗
(m)∈arg
σ
^
′
max
	​

U(
σ
^
′
,μ)}

for $q$-a.e. $m$, where $q=(\gamma_\alpha)_2$. Then $\sigma^*$ is robustly rationalizable in the paper’s a.e./on-path sense. This condition is strictly milder than deterministic TRE-gen-Hall because $\kappa$ may mix over all rowwise minimizer labels.

3. Why menu engine?

The previous Branch A machinery used Balder compactness, Mertens minmax, and Lusin lifting to domesticate infinite measurable kernels. That was a very large machine for the wrong object. Phase C’s pivot notices that the robust payoff depends only on state-contingent payoff profiles in the finite-dimensional set $W\subset\mathbb R^{|\Omega|}$, the same object used in Appendix A.1 of the paper’s proof of Theorem 1. Menus $C\subseteq W$ are compact finite-dimensional objects. The aligned adviser generates a support-function term $\max_{w\in C}s\cdot w$; the misaligned adviser generates an anti-support term $\min_{w\in C}s\cdot w$. Once the game is written at the menu level, existence and rowwise adversary attainment are compact-geometry facts, not infinite-dimensional kernel facts. The scary kernel jungle shrinks to a small polyhedral terrarium. 

Robust_trust_Dworczak_Smolin

4. Definitions and notation

Let

W:={w∈R
N
:∃
σ
^
:Θ→Δ(A) measurable with w(ω)=E
σ
^
	​

[u(a,ω,θ)∣ω]}.

By the paper’s Appendix A.1 argument, $W$ is convex and compact: convexity comes from randomizing private strategies, and compactness follows from boundedness, compactness of $A$, continuity in $a$, and the measurable maximum theorem.

Let $\mathcal K(W)$ be the hyperspace of nonempty compact subsets of $W$, equipped with Hausdorff distance $d_H$. For $C\in\mathcal K(W)$ define

F(C):=∫
M
	​

[α
w∈C
max
	​

s⋅w+(1−α)
w∈C
min
	​

s⋅w]τ(ds).

A compact menu $C$ is interpreted as the set of payoff profiles the agent makes available through her message-contingent private strategies. An aligned adviser with posterior $s$ is met by the profile in $C$ best for $s$; a misaligned adviser with posterior $s$ chooses the profile in $C$ worst for $s$.

Let $C^*$ be a maximizer of $F$. Define

A(m):=arg
w∈C
∗
max
	​

m⋅w,R(s):=arg
w∈C
∗
min
	​

s⋅w.

A Borel selector from $A(m)$ is denoted $w^(m)$. A Borel selector from $R(s)$ is denoted $\bar w(s)$. The private strategy realizing $w^(m)$ is $\hat\sigma^(m)$, and the induced full strategy is $\sigma^$. A message selector realizing $\bar w(s)$ is $m^*(s)$ when deterministic realization is used; in Tier 2, $\kappa(\cdot\mid s)$ may mix over the realized minimizer fiber.

The Bayes cone at message $m$ is

B(m)={μ∈Δ(Ω):μ⋅w
∗
(m)=
w∈W
max
	​

μ⋅w}.

Equivalently, $\mathsf B(m)$ is the normal-cone slice of $W$ at $w^*(m)$.

5. Proof - Tier 1 via the menu engine
Lemma: menu-value equivalence
U
∗
=
C∈K(W)
sup
	​

F(C),

modulo the profile-realization sub-lemma.

Sketch. Given an agent strategy $\sigma$, let $C_\sigma$ be the compact closure in $W$ of the payoff profiles generated by its message-indexed private strategies. For each truthful posterior $s$, the aligned payoff is bounded above by $\max_{w\in C_\sigma}s\cdot w$. For each misaligned source posterior $s$, the adversary can force at least the rowwise menu infimum $\min_{w\in C_\sigma}s\cdot w$, once the menu labels are realized. Thus $U(\sigma)\le F(C_\sigma)$ after replacing $\sigma$ by its menu-improving envelope.

Conversely, for each compact menu $C$, the profile-realization sub-lemma supplies a measurable labeling of messages by payoff profiles in $C$ that implements an argmax selector for aligned reports and makes rowwise minimizer profiles available to the adversary. Pulling the selected profiles back to measurable private strategies yields $\sigma_C$ with

U(σ
C
	​

)=F(C).

Taking suprema gives the equivalence. This is the Phase C equivalence lemma’s only internal hinge: the lift from payoff profiles back to measurable private strategies. It is not an extra economic hypothesis; it is a realization lemma for the $W$ representation.

Lemma: menu existence

$\mathcal K(W)$ is compact metrizable in the Hausdorff topology, because $W$ is compact metric. For $C,D\in\mathcal K(W)$ and $s\in\Delta(\Omega)$,

	​

w∈C
max
	​

s⋅w−
w∈D
max
	​

s⋅w
	​

≤∥s∥d
H
	​

(C,D),

and the same bound holds for the minima. Since $|s|$ is uniformly bounded on the simplex, $F$ is Lipschitz in $d_H$. Therefore $F$ is continuous, hence upper semicontinuous. Compactness gives an optimizer:

C
∗
∈arg
C∈K(W)
max
	​

F(C).
Lemma: measurable labeling

For each $m\in M$,

A(m)=arg
w∈C
∗
max
	​

m⋅w

is nonempty compact, and its graph is Borel, indeed closed, because $(m,w)\mapsto m\cdot w$ is continuous and $C^*$ is compact. Kuratowski-Ryll-Nardzewski, for example Aliprantis-Border Theorem 18.13, gives a Borel selector

w
∗
(m)∈A(m).

The profile-realization sub-lemma lifts $w^(m)$ to a measurable private strategy $\hat\sigma^(m)$ with payoff profile $w^(m)$. Thus $\sigma^\in\Sigma$ is well defined, and

U(σ
∗
)=F(C
∗
)=U
∗
.
Lemma: rowwise adversary attainment, A8c-attain automatic

For every $s\in M$,

R(s)=arg
w∈C
∗
min
	​

s⋅w

is nonempty compact because $C^*$ is compact and $w\mapsto s\cdot w$ is continuous. The graph of $R$ is closed, so Kuratowski-Ryll-Nardzewski gives a Borel selector

w
ˉ
(s)∈R(s).

The profile-realization sub-lemma then provides a measurable adversarial message selector $m^(s)$ with payoff profile $\bar w(s)$ under $\sigma^$. Define

β
∗
(dm∣s):=δ
m
∗
(s)
	​

(dm).

Then the misaligned payoff equals the rowwise minimum:

E
β
∗
,σ
∗
	​

[u]=∫
M
	​

w∈C
∗
min
	​

s⋅wτ(ds).

Combining with the aligned term,

U(β
∗
,σ
∗
)=F(C
∗
)=U
∗
.

Since no adversary can push below the menu minimum, $\beta^$ attains the infimum against $\sigma^$:

U(β
∗
,σ
∗
)=
β∈B
inf
	​

U(β,σ
∗
)=U
∗
.
Tier 1 capstone

The compact menu $C^$ delivers a measurable agent strategy $\sigma^$ and a rowwise minimizing adversary $\beta^*$. Therefore Tier 1 holds under the standing hypotheses alone. The previous value-existence and adversary-attainment assumptions were artifacts of working in the kernel space rather than in the finite-dimensional payoff-profile menu.

6. Proof - Tier 2 via menu-Hall
Lemma: Bayes cone $\mathsf B(m)$

The Bayes cone

B(m)={μ∈Δ(Ω):μ⋅w
∗
(m)=
w∈W
max
	​

μ⋅w}

is closed and convex. It is the intersection of $\Delta(\Omega)$ with the halfspaces

μ⋅(w−w
∗
(m))≤0,w∈W.

Thus $\mathsf B(m)$ is precisely the set of beliefs for which the private strategy realizing $w^*(m)$ is Bayes-optimal.

The L9 saddle gap, still real

Tier 1 gives the lower saddle inequality:

U(β
∗
,σ
∗
)=
β
inf
	​

U(β,σ
∗
).

It does not give the upper saddle inequality

U(β
∗
,σ)≤U(β
∗
,σ
∗
)∀σ.

The deterministic worst-message selector $\bar w$ achieves adversary attainment, but it need not make the agent’s message-contingent private strategies Bayes-optimal under the posteriors induced by $\beta^*$. The finite proof gets this upper saddle from Sion on finite-dimensional products of simplices. In the infinite extension, the missing object is posterior calibration.

Phase C abort test: sharpness witness for Tier 2

Bare menu structure plus set-valued minimizer mixing does not imply posterior calibration.

Take

Ω={0,1,2},A={a
0
	​

,a
1
	​

,a
2
	​

},

with winner-takes-all payoffs, uniform prior, atomless full-support $\tau$, and non-radial trust region

T={μ:μ(0)≤0.4}.

Let the optimal discrete profile menu be

C
∗
={v
0
	​

,v
1
	​

,v
2
	​

}.

At the boundary point

t
0
	​

=(0.4,0.3,0.3),

the rowwise minimizer correspondence is

R(t
0
	​

)={v
1
	​

,v
2
	​

},

while the Bayes cone for the action/profile $v_0$ is

B(t
0
	​

)={p:p
0
	​

≥p
1
	​

, p
0
	​

≥p
2
	​

}.

The misaligned source mass feeding $t_0$ comes from

K
0
−
	​

={s:s
0
	​

≤s
1
	​

, s
0
	​

≤s
2
	​

}.

On $K_0^-$,

s
1
	​

−s
0
	​

≥0,s
2
	​

−s
0
	​

≥0.

Any conditional mean $\bar s$ of source mass assigned to the boundary fiber inherits those inequalities. Forcing $\bar s\in\mathsf B(t_0)$ requires both reverse inequalities as well, hence equality:

s
ˉ
0
	​

=
s
ˉ
1
	​

=
s
ˉ
2
	​

=
3
1
	​

.

With atomless $\tau$, no positive source mass can be concentrated at that single point. Thus posterior calibration fails.

This is the sharpness witness: the obstruction is multi-dimensional vector balance. The deterministic-versus-set-valued distinction was a mirage. Allowing $\kappa$ to mix over $R(s)$ does not dissolve a two-coordinate barycenter obstruction.

Lemma: menu-Hall is the correct engineered hypothesis

Let $\kappa(\cdot\mid s)$ be a kernel supported on realized minimizer labels:

κ(R
M
	​

(s)∣s)=1.

Let

γ
α
	​

(ds,dm)=αδ
s
	​

(dm)τ(ds)+(1−α)κ(dm∣s)τ(ds),q=(γ
α
	​

)
2
	​

.

Disintegrating $\gamma_\alpha$ by the second coordinate gives the posterior

P
γ
α
	​

	​

(⋅∣m)=∫
M
	​

sγ
α
	​

(ds∣m).

The menu-Hall condition is

P
γ
α
	​

	​

(⋅∣m)∈B(m)q-a.e.

Equivalently, for every measurable $E\subseteq M$ and every continuous affine $\phi:\Delta(\Omega)\to\mathbb R$,

α∫
E
	​

ϕ(m)τ(dm)+(1−α)∫
M
	​

ϕ(s)κ(E∣s)τ(ds)≤∫
E
	​

h
B(m)
	​

(ϕ)q(dm),

where

h
B(m)
	​

(ϕ):=
μ∈B(m)
sup
	​

ϕ(μ).

The equivalence follows from finite-dimensional support-function duality and a countable separating family of affine tests. The left side is exactly

∫
M×E
	​

ϕ(s)γ
α
	​

(ds,dm)=∫
E
	​

ϕ(P
γ
α
	​

	​

(⋅∣m))q(dm).

Thus the inequality for all $E$ and $\phi$ is just pointwise membership in $\mathsf B(m)$, written in Hall/Strassen clothing.

This hypothesis is strictly milder than deterministic TRE-gen-Hall because the kernel $\kappa$ may split each source posterior across multiple rowwise minimizer labels. It is also sharp because the abort test shows that set-valued mixing alone is not sufficient; the mixing must satisfy vector calibration.

Tier 2 capstone

Under menu-Hall,

P
γ
α
	​

	​

(⋅∣m)∈B(m)q-a.e.

By the definition of $\mathsf B(m)$, $\hat\sigma^(m)$ is Bayes-optimal at the posterior induced by $\gamma_\alpha$, hence by the corresponding adversarial strategy. Tier 1 gives adversary attainment. Therefore $\sigma^$ is robustly rationalizable in the paper’s a.e./on-path sense. If $\alpha>0$, then $q\ge \alpha\tau$, so the statement also holds $\tau$-a.e. on the truthful on-path support.

7. What is tight, what is open
Tight

Set-valued mixing does not fix the Hall obstruction. Phase C’s ternary non-radial witness shows that the failure is not caused by choosing a deterministic selector from $R(s)$. It is caused by multi-dimensional vector balance: the conditional source mean assigned to a boundary message must land in the Bayes cone at that message, and in $|\Omega|\ge 3$ this is a real system of inequalities, not a scalar monotone-transport equation. This refines the previous v5 diagnosis, where TRE-gen-Hall was still framed around deterministic worst-message maps. 

exposition_v3

Open

Menu-Hall may become automatic under additional geometric structure on $C^*$ or on the induced trust region. The live candidates are radial symmetry, zonotopal alignment, separability of Bayes cones, and group-invariant trust regions. The paper’s binary-state construction verifies the one-dimensional calibration through quantile transport, while the spherical/radial case in Section 5.2 and Appendix A.10 verifies calibration through per-direction one-dimensional transports plus radial Bregman monotonicity. 

Robust_trust_Dworczak_Smolin

 

Robust_trust_Dworczak_Smolin

8. Comparison with the paper’s finite-case proof

In the finite proof of Theorem 2, $B$ and $\Sigma$ are products of finite-dimensional simplices, payoffs are continuous and affine in the relevant coordinates, and Sion gives a full saddle point. That saddle simultaneously delivers optimality, adversary attainment, and per-message Bayes-optimality. The menu-engine extension replaces the compact simplex saddle with compact finite-dimensional $W$-geometry. This is enough for Tier 1: a compact optimal menu exists, and rowwise minimizers exist by ordinary compactness. What finite Sion still gives for free, and the menu engine does not, is posterior calibration. Menu-Hall is exactly the missing infinite-dimensional analogue of that upper-saddle step. 

objective_statement

9. Comparison with the previous v5 proof

The v5 theorem required A5-thick and A8c-attain for Tier 1, and added TRE-gen-Hall for Tier 2. Phase C removes both Tier 1 assumptions. Value existence no longer comes from Balder/Mertens/Lusin; adversary attainment no longer comes from rowwise l.s.c. or an explicit attainment hypothesis. Both are consequences of compact menus in $W$. Tier 2 remains conditional, but the condition is now correctly stated as set-valued menu-Hall. The logical strength of Tier 2 is essentially the same, since calibration is still the missing saddle ingredient, but the statement is sharper and milder: $\kappa$ may mix over the entire minimizer correspondence, and the obstruction is identified as multi-dimensional vector balance rather than deterministic selector failure. 

theorem_2_extension_proof_v5

 

theorem_2_extension_proof_v5

10. References

Dworczak, P. and Smolin, A. (2026). Robust Trust. Main references: Theorem 1 and Appendix A.1 for the $W$ payoff-profile set and trust-region geometry; Theorem 2 and Appendix A.2 for robust rationalizability and the finite Sion proof; Section 5.2 and Appendix A.10 for the spherical/radial case.

Balder, E. J. (1988). “Generalized Equilibrium Results for Games with Incomplete Information.” Mathematics of Operations Research 13(2), 265-276. No longer load-bearing for Tier 1 menu existence, but still relevant if one proves the profile-realization sub-lemma through transition-probability compactness.

Mertens, J.-F. (1986). “The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions.” International Journal of Game Theory 15(4), 237-250. Superseded as the Tier 1 engine, but still part of the prior route and potentially useful for realization sublemmas.

Aliprantis, C. D. and Border, K. C. (2006). Infinite Dimensional Analysis. The key tool here is Kuratowski-Ryll-Nardzewski measurable selection, especially Theorem 18.13.

Bogachev, V. I. (2007). Measure Theory. Background reference for standard Borel disintegration and measurable selection infrastructure.
