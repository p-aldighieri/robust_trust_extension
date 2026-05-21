
========
ROLE: user (id=feb54651-d750-492e-bc3d-59ba379e838b)
========
# Math sanity-check chunk 2 — FBNF capstone

## Role

Fresh-chat independent broad math review. Read consolidator_01_response.md
(durable source) and check the **FBNF capstone** for soundness.

This covers:
- FBNF primitive class (FBNF-1...5 + FBNF-7; FBNF-6 derived).
- F1 (Conditional B1 + measurable pasting) under endpoint-fiber support.
- F2 (Endpoint-only fiber image) under primitive P.
- F3 (Localized stationarity → fiberwise total balance) via v9 T1.
- F4 (FBNF capstone assembly).
- Coverage corollaries: spherical/radial, affine MLR, polyhedral with
  scalarizable faces.

## What to check

- **Foliation structure**: FBNF-1's affine 1-d foliation. Is the
  Borel disintegration well-defined?
- **Cross-fiber claim**: FBNF-7 global fiber dominance — is the
  precise statement correct? Does it cover all fibers, not just one
  representative?
- **F1 patched form**: the kernel maps into endpoint FIBER, not
  singleton — verify all five lemma steps use this.
- **F3 derivation of FBNF-6**: localized two-sided perturbations +
  v9 T1 Clarke-Danskin Fermat. Are the boundary KKT cases handled?
- **Compatibility with v8 sharpness**: WTA ternary has |Ω|=3 + vertex
  W^P, which the consolidator says fails FBNF-1 (no 1-d foliation).
  Verify.

## Output

- Soundness verdict (SOUND / MINOR_FIXES_NEEDED / SUBSTANTIVE_ISSUE).
- List errors with section references.
- Verdict on whether FBNF is safe to send to Piotr.

Show more

========
ROLE: assistant (id=ed03f5c6-7426-438c-9bba-6d62557a4263)
========
I’ll audit the FBNF capstone against the consolidated source and underlying F1–F4 proof chain, focusing on foliation/disintegration, endpoint-fiber support, global fiber dominance, stationarity, and sharpness compatibility.

========
ROLE: assistant (id=96c67be0-2ab5-41d5-a93f-ea800b3975d3)
========
The main issue is narrowing: coherence depends on the patched endpoint-fiber support plus a true Borel chart or quotient-consistency assumption, and FBNF-1 is currently too terse.

========
ROLE: assistant (id=6419a7ba-8fcd-4765-a259-aa09741c67f6)
========
Soundness verdict: MINOR_FIXES_NEEDED

The FBNF capstone is mathematically sound in its corrected endpoint-fiber form, but the consolidated text needs a few wording and hypothesis-ledger fixes before sending to Piotr. No fatal gap jumped out. The little gremlins are mostly “say endpoint fiber, not endpoint point,” “state Borel chart/quotient consistency,” and “include local two-sided perturbability in the numbered ledger.”

Errors / fixes by section
1. Foliation structure: FBNF-1 needs a Borel chart, not just a cover

The capstone is sound only under the strengthened FBNF-1 reading used in F1: the coordinate map

Φ(z,t)=ℓ
z
	​

(t)

must be a 
τ
ˉ
-a.e. Borel chart, or overlaps must be quotient-consistent. F1 explicitly warns that a mere Borel surjection can make the pasted posterior multi-valued at the same message. 

prover_08_response

So the fix is to state FBNF-1 as:

There is a standard Borel coordinate space E={(z,t):t∈[a
z
	​

,b
z
	​

]}, a probability 
τ
ˉ
(dz,dt)=λ(dz)τ
z
	​

(dt), and a jointly Borel affine map Φ(z,t)=ℓ
z
	​

(t) with Φ
#
	​

τ
ˉ
=τ, such that either Φ is injective on a full-measure Borel subset or all overlaps prescribe the same endpoint posterior and TRS label.

Without that, the disintegration/pasting step is a pumpkin coach after midnight.

2. FBNF-7 is the right cross-fiber condition, but state it on coordinates

The cross-fiber claim is correct and load-bearing. Reviewer 08 explicitly says F2 is only fiber-local, and F4 must add global fiber dominance because the original adversary can choose any message in T, not just messages in the same fiber. 

reviewer_08_response

 The capstone’s FBNF-7 does exactly this:

μ∈T
min
	​

s⋅w
∗
(μ)=
μ∈T
z
	​

min
	​

s⋅w
∗
(μ)

for τ-a.e. s=ℓ
z
	​

(t). 

prover_11_response

The wording fix: write it as a 
τ
ˉ
-a.e. coordinate statement:

μ∈T
min
	​

ℓ
z
	​

(t)⋅w
∗
(μ)=
μ∈T
z
	​

min
	​

ℓ
z
	​

(t)⋅w
∗
(μ)for 
τ
ˉ
-a.e. (z,t).

That covers all fibers a.e., not one representative fiber. It also removes ambiguity if fibers overlap.

3. F1 patched form is correct, but the capstone still has stale “endpoint” wording

F1 is correctly patched: the adversary’s literal message support is in endpoint fibers

ℓ
z
	​

([a
z
	​

,L(z)])∪ℓ
z
	​

([R(z),b
z
	​

]),

not just the singleton messages ℓ
z
	​

(L(z)),ℓ
z
	​

(R(z)). The projected payoff image is endpoint-only. 

prover_11_response

The F1 proof then verifies the right three cases: left endpoint-fiber messages have posterior ℓ
z
	​

(L(z)), right endpoint-fiber messages have posterior ℓ
z
	​

(R(z)), and interior messages have posterior m; Bayes-optimality follows q-a.e. 

prover_08_response

Minor text fix: in F4 Step 2, replace “the adversary’s true best response sends mass only to fiber endpoints” with:

the adversary’s projected payoff image is endpoint-only, while the literal message kernel may spread over endpoint fibers for calibration.

The current consolidated proof chain already says the corrected F1 uses endpoint-fiber support and not literal singleton support, so this is a consistency edit, not a new proof demand. 

consolidator_01_response

4. F2 is sound in endpoint-supported form, not strict argmin-subset form

Reviewer 08 passes F2 in the endpoint-supported, fiber-local form. The proof uses the affine-fiber support-function reduction: V(r)=U(ℓ(r)) is convex, g
r
	​

=d⋅w
r
	​

∈∂V(r), and subgradient monotonicity gives endpoint domination. 

reviewer_08_response

If the theorem statement says

arg
μ∈T
z
	​

min
	​

s⋅w
∗
(μ)⊆{ℓ
z
	​

(L),ℓ
z
	​

(R)},

that is too strong unless one adds strict no-interior-flatness, e.g. strict convexity of U∘ℓ
z
	​

. For the capstone, the weaker endpoint-supported selector is enough. 

reviewer_08_response

5. F3 / FBNF-6 derivation is sound, but local two-sided perturbability must be in the ledger

F3 does derive the fiberwise total-balance equations from localized stationarity using the Clarke-Danskin/Fermat mechanism, with Borel patch testing to get λ-a.e. identities rather than only an integrated identity. 

prover_10_response

But the derivation needs local two-sided endpoint perturbability. If endpoints hit a
z
	​

 or b
z
	​

, or if two-sided perturbations are unavailable on a positive-measure patch, the correct conclusion is a one-sided KKT inequality, not equality. 

prover_10_response

So the theorem statement “FBNF-1..5 + FBNF-7, FBNF-6 derived” should be amended to:

FBNF-1..5 + FBNF-7 + local two-sided perturbability; then FBNF-6 is derived.

This is important but not fatal because the proof sources already include the caveat. It just needs to be made visible in the capstone theorem.

6. Compatibility with v8 sharpness / WTA ternary: safe, but phrase carefully

The capstone does not contradict the v8 sharpness package. The WTA ternary obstruction is a genuinely two-dimensional vector-balance problem with three vertex labels; FBNF scalarizes along one-dimensional affine fibers. 

prover_08_response

One nuance: saying WTA “fails FBNF-1 because no 1-d foliation exists” is too blunt. A 2-simplex can be foliated by line segments in a bare geometric sense. The correct statement is:

WTA ternary is not fibered-binary in the FBNF sense: its active normal-fan / vertex-label geometry does not decompose into one-dimensional scalar B1 transports, and if one tries to force such a decomposition, FBNF-7/cross-fiber dominance fails.

The F4 source itself says WTA fails FBNF-7, and the coverage section says polyhedral finite vertices need scalarizable faces, not just a finite vertex menu. 

prover_11_response

Safe to send to Piotr?

Yes, after the minor edits above.

I would send it as a conditional theorem with this exact hypothesis line:

Standing Robust Trust assumptions, ∣Ω∣≥3, α∈(0,1), FBNF-1 through FBNF-5, local two-sided endpoint perturbability, and FBNF-7 global fiber dominance, where FBNF-1 is understood as a 
τ
ˉ
-a.e. Borel affine chart or quotient-consistent foliation.

Then emphasize:

The constructed adversarial kernel has endpoint-fiber support, not singleton endpoint support; its projected payoff image is endpoint-only.

With those edits, the capstone is safe for Piotr.
