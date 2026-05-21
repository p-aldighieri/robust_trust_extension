
========
ROLE: user (id=44e32b74-538d-4a2c-9654-414a67896714)
========
# Reviewer pass 19 — Verify P2*-VM variable-margin

## Role

Fresh-chat reviewer on Prover 22's P2*-VM lemma
(prover_22_response.md). The lemma replaces P2*'s uniform cone-margin
$\eta > 0$ with a Borel-positive variable margin $\eta(m): M\to(0,\infty)$,
under an integrable upper-capacity condition $b_\eta \le \Gamma_\eta$.

## Specific checks

1. **The variable-margin LP**: does the integrated aligned-baseline
   condition correctly replace the uniform-cone-margin lower bound?
2. **Upper-capacity condition** $b_\eta \le \Gamma_\eta$: is this a
   genuine primitive (not output-conditioned)?
3. **Tightness of approximating LPs**: verify the limit argument.
4. **WTA compatibility**: under P2*-VM, does WTA still fail (without
   baseline) the same way it failed under uniform P2*?

## Verdict

PASS / PATCH / DISPROVED / HOLD.

End with: extend v9.1 with P2*-VM or revert to uniform P2*.

Show more

========
ROLE: assistant (id=1daa94ee-fec9-47eb-bfcd-2782ed63760e)
========
I’ll audit Prover 22’s P2*-VM against the G3/P2* framework, focusing on whether the integrated variable-margin capacity is genuinely Borel-local rather than hidden pointwise calibration.

========
ROLE: assistant (id=0c60f1e5-4370-4da9-8256-a7459d281a41)
========
According to documents from 2026-05-21, verdict: PATCH. P2*-VM is a viable weakening, but Prover 22’s written proof has a load-bearing algebra/Radon-Nikodym orientation error and the “integrated” baseline condition must be stated as a local Borel capacity domination, not as a scalar average. This is a patchable theorem, not a disproof.

1. Variable-margin LP / cone-Hall condition

The conceptual move is right: P2*-VM should prove Ψ(y)≤0 by showing the mixture posterior stays inside the Bayes cone B(m), then invoking the G3 biconditional. v9 already records that G3 gives robust rationalizability exactly when Ψ
w
∗
	​

(y)≤0 for every bounded Borel price y, under Reg-1/Reg-2. 

v9_consolidated

But the proof’s posterior algebra is wrong as written. With target marginal ρ≪τ, the density must be

g(m)=
dτ
dρ
	​

(m),

and if ζ(E)=∫∫
E
	​

sκ
0
	​

(dm∣s)τ(ds), then

r(m)=
dρ
dζ
	​

(m)∈Δ(Ω).

The posterior is

p(m)=
dq
dn
	​

(m)=
α+(1−α)g(m)
αm+(1−α)g(m)r(m)
	​

.

So the correct pull identity is

p(m)−m=
α+(1−α)g(m)
(1−α)g(m)
	​

[r(m)−m],

not the reciprocal coefficient appearing in Prover 22. Prover 22 itself flags the needed orientation patch, saying the density needed is g=dρ/dτ, even though the displayed statement still contains the opposite notation in places. 

prover_22_response

Thus the correct local margin condition is

α+(1−α)g(m)
(1−α)g(m)
	​

D
Δ
	​

≤η(m).

Equivalently, when 0<η(m)<D
Δ
	​

,

g(m)≤Γ
η
	​

(m):=
(1−α)(D
Δ
	​

−η(m))
αη(m)
	​

.

If η(m)≥D
Δ
	​

, no density cap is needed at that point. Prover 22’s Γ
η
	​

 formula is inverted, so v9.1 must fix the coefficient before accepting the lemma.

2. Upper-capacity condition b
η
	​

≤Γ
η
	​


The right replacement for the uniform cone-margin bound is not a single average like ∫ηdτ. Prover 22 correctly says a global average is too weak because Borel dual prices can concentrate on any positive-measure bad set where the posterior leaves B(m). 

prover_22_response

The valid condition is the setwise capacity condition

ρ(E)≤∫
E
	​

b
η
	​

(m)τ(dm)≤∫
E
	​

Γ
η
	​

(m)τ(dm)for every Borel E⊆M,

equivalently

dτ
dρ
	​

(m)≤b
η
	​

(m)≤Γ
η
	​

(m)τ-a.e.

This is “integrated” in the measure-capacity sense, not in the “one big scalar integral” sense. The latter would be a velvet curtain hiding a local Hall failure.

Is b
η
	​

≤Γ
η
	​

 a genuine primitive? Only if stated carefully. The envelope b
η
	​

 can be a primitive traffic-capacity bound if it is specified from model-side data and not chosen after solving the calibration problem. But the condition “there exists κ
0
	​

 supported on G(s) with dρ/dτ≤b
η
	​

” still references the optimal labeling through G(s). That makes it a G3 fixed-label certificate unless the paper also gives a primitive construction of such a kernel. v9 already distinguishes exact cone-Hall feasibility Ψ≤0 as a classification condition from genuinely primitive sufficient classes. 

v9_consolidated

So the patch is: present P2*-VM as a primitive sufficient class only when the upper-capacity envelope is model-side and the rowwise-minimizer traffic bound is supplied by a primitive construction or LP certificate. Otherwise, place it under the G3 “regular fixed-label sufficient certificate” ledger.

3. Tightness of approximating LPs

The limit argument works after the density-orientation and Γ
η
	​

 fixes, under the same no-escape regularity already required by G2c/G3.

The needed condition is:

0≤
dτ
dρ
n
	​

	​

≤b
η
	​

,b
η
	​

∈L
1
(τ).

Then the densities are uniformly integrable, so Dunford-Pettis gives weak L
1
 compactness. Since M⊆Δ(Ω) is compact in the Robust Trust setting and G has closed graph under Reg-1, the joint laws π
n
	​

(ds,dm)=τ(ds)κ
n
	​

(dm∣s) are tight, weak limits stay supported on GrG, and disintegration gives a Borel kernel supported on G(s). This is exactly the G2c style: work directly with measures on the graph, not compact-patch deletion or cell-flow lifting. 

prover_13_response

No η
−1
∈L
1
 assumption is needed. But an integrable upper envelope b
η
	​

 is needed for the LP-limit version, and feasibility also implicitly requires enough capacity, for instance ∫b
η
	​

dτ≥1 if ρ is a probability target marginal.

4. WTA compatibility

P2*-VM does not disturb the WTA diagnosis. The no-baseline full-vertex WTA ternary instance still fails the corrected cone-Hall condition by an explicit positive dual certificate; Prover 12 computes Ψ(y)>0, while the theorem requires Ψ(y)≤0. 

prover_12_response

That is exactly as it should be. Variable margin does not conjure aligned mass where none exists. It only says: where the cone margin is small, adversarial traffic into that message must be correspondingly small. If WTA is baseline-augmented enough to satisfy the finite-facet LP or the corrected local-capacity inequality, it can pass; without that baseline/capacity, it fails in the same way as under uniform P2*. v9’s current table already treats WTA as failing without aligned baseline and potentially passing under a baseline threshold. 

v9_consolidated

Required v9.1 edits

Replace all g=dτ/dρ appearances in P2* and P2*-VM with g=dρ/dτ.

Replace the posterior pull coefficient by

α+(1−α)g
(1−α)g
	​

.

Replace Prover 22’s Γ
η
	​

 by

Γ
η
	​

(m)=
(1−α)(D
Δ
	​

−η(m))
αη(m)
	​

for 0<η(m)<D
Δ
	​

.

State the aligned-baseline condition as the every-Borel-set capacity bound

ρ(E)≤∫
E
	​

b
η
	​

dτ,b
η
	​

≤Γ
η
	​

,

not as a global integrated surplus.

Put a ledger note: P2*-VM is primitive only when b
η
	​

 and the dominated rowwise-minimizer traffic mechanism are supplied from primitives; otherwise it is a G3 fixed-label certificate.

Verdict: PATCH. The theorem survives, but Prover 22’s current text cannot be marked PASS until the density orientation and capacity formula are corrected.

extend v9.1 with P2*-VM
