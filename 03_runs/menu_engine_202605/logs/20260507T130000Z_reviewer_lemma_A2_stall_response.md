
========
ROLE: user (id=a680b336-6cfc-42ac-91ef-dd8619bf00ea)
========
# Reviewer pass — Lemma A.2 stall (transport-to-deletion gap)

You are the **Reviewer** in the soft-scaffolding workflow. Audit the prover's stall verdict on Lemma A.2 from logs/20260507T120000Z_prover_lemma_A2_trapdoor_response.md. The prover concluded STALLED with three named technical obstacles.

## Context

Lemma A.2 was the trapdoor lemma for Strategy 3 (canonical/minimal menu route). Its statement: assuming standing + (exact-contact), if $C^*$ is behaviorally minimal (C1) and menu-Hall fails, then there exists a proper compact $D \subsetneq C^*$ with $F(D) \ge F(C^*)$.

The prover's verdict: **STALLED**. Three named obstacles:

1. **Support saturation gap.** Deletion only raises $\ell_D$ if every $C^*$-minimizer for source $s$ is removed. Exact-contact gives existence in $G(s)$, not saturation $E \supseteq G(s)$ for the dual-relevant $E$. Without saturation, the transport certificate produces "phantom fuel" — burns in the dual inequality without raising actual $\ell_D$.

2. **Replacement-index mismatch.** The displayed dual inequality has the form
$$\alpha\!\int_E\!m\cdot(c(m) - z(m))\,\tau(dm) - (1-\alpha)\!\int_{M\times E}\!(s\cdot z(m) - \ell_C(s))\,\lambda(ds, dm) \ge 0$$
with $z(m)$ indexed by message. But $F(D) - F(C^*)$ involves $\ell_D(s) - \ell_C(s) = \min_{z \in D}\,s\cdot z - \ell_C(s)$, indexed by source. Even if $z(m) \in D$, only $\ell_D(s) \le s\cdot z(m)$ — wrong direction for the deletion improvement.

3. **Borel→compact gap.** $\overline{c(M\setminus E)} = C^*$ can hold even for large Borel $E$. Behavioral minimality gives $C^* = \overline{c(M)}$, not that deficient message sets correspond to removable compact label patches.

The prover's prescription:
- (Unblocker A) A deletion-compatible Hall duality theorem that builds saturation and sourcewise minimization into the dual.
- (Unblocker B) Stronger regularity (closed graph of $w^*$, u.h.c. of $G$, τ-a.e. uniqueness of minimizers, label-regularity ensuring deficient message sets remove compact patches).

## Items to audit

### 1. Are the three named obstacles real?

Verify each obstacle is a genuine technical gap, not a mis-step in the prover's algebra.

- **(1) Support saturation.** Verify the claim: if $E$ is dual-deficient and $\lambda$ sends source $s$ to $E \cap G(s) \ne \emptyset$ but $G(s) \not\subseteq E$, then deleting $c(E)$ does not raise $\ell$ at $s$. State precisely whether exact-contact (existence + measurable selector) implies any saturation property in general, or whether it is genuinely silent.
- **(2) Replacement-index.** Verify the algebra: the dual inequality's $z(m)$ is indeed message-indexed, the deletion-improvement is source-indexed, and the inequality $\ell_D(s) \le s\cdot z(m)$ for $z(m) \in D$ does not produce the needed direction. Sanity check: is there a way to read the dual differently that matches the deletion side?
- **(3) Borel→compact.** Verify the example space: under bare Borel measurability of $w^*$ and behavioral minimality, can we exhibit (or argue) a Borel $E$ with $\tau(E) > 0$ AND $\overline{c(M\setminus E)} = C^*$? If yes, the obstacle is real. If not, the obstacle may be a measurability slip.

### 2. Does the diagnosis actually block Strategy 3's general form?

The prover claims that obstacles (1)–(3) jointly block A.2 under standing + exact-contact alone, and that only Unblockers (A) or (B) would close the gap. Verify:

- Are there alternative proof techniques (not Strassen/Kellerer-based) that might bypass all three obstacles?
- Does the breakdown's proposed Unblocker (B) — closed graph + u.h.c. + uniqueness + label regularity — actually suffice? Or does it still leave a gap?
- Is there a softer A.2 (e.g., $F(D) \ge F(C^*) - \eps$ for some $\eps > 0$) that would still be useful and might be provable under standing alone?

### 3. Are the special-geometry candidates (C2/C3/C4) genuinely independent?

The prover claims C2/C3/C4 remain live "where uniqueness, symmetry, or closed-graph structure supplies the missing saturation." Verify:

- Do C2 (exposed-extreme), C3 (primitive TR-minimality), and C4 (radial/orbit symmetry) each automatically supply saturation, sourcewise-minimization, or compact deletion?
- Or do they each need their own analog of A.2 to bridge canonicality to menu-Hall?
- If the latter, the same transport-to-deletion gap may reappear; flag this if so.

## Verdict and downstream advice

### Verdict levels

- PASS: stall is correctly diagnosed. Strategy 3's general form (C1) is genuinely blocked. Project's terminal status under v8 is honest.
- PATCH_SMALL: the stall is real but a minor patch (e.g., a softer A.2) might still close the route under standing.
- PATCH_BIG: one of the three obstacles is overstated; the route may still live with a non-obvious technique.
- REDO: the prover missed an obvious proof.

### Downstream advice (one paragraph)

Given the verdict, what should the orchestrator do? Options:
- **Stop and gatekeeper (third pass).** Take v8 + sharpness + Strategy 3 stall to the gatekeeper for a final verdict on whether the project is at a publishable terminal state.
- **Special-geometry prover passes.** Run the breakdown's items 2–4 (B.2 normal-fan, C.2 binary interval, D.2 spherical orbit) one at a time, accepting that they only cover special cases.
- **Search for Unblocker (A).** Look for a deletion-compatible Hall duality theorem in the literature (martingale optimal transport, Strassen with cone constraints, Kellerer with disintegration constraints).
- **Stop with v8 as terminal**, treating the special-geometry routes as already covered by the paper's own constructions (Appendices A.6 and A.10).

## Output Format


\`\`\`review_control
verdict: PASS / PATCH_SMALL / PATCH_BIG / REDO
route_status: viable / blocked / dead
recommended_next_phase: GATEKEEPER / PROVER / BREAKDOWN / SEARCHER / CONSOLIDATOR / STOP_STALL
proof_status: complete / partial / broken
\`\`\`

## Verdict
VERDICT: ...
Reason: ...

## Detailed Audit
### 1. Three named obstacles
- (1) Support saturation: real / overstated. Reason: ...
- (2) Replacement-index: real / overstated. Reason: ...
- (3) Borel→compact: real / overstated. Reason: ...

### 2. Does the diagnosis block Strategy 3 general form?
...

### 3. Special-geometry candidates
- C2: ...
- C3: ...
- C4: ...

## Opinion and Next Move
(One paragraph. Strong recommendation on the next phase.)


Length: 1500–2000 words.

Show more

========
ROLE: assistant (id=24ea831d-b1c3-47c0-9c0f-a1ed5251506b)
========
review_control
verdict: PASS
route_status: blocked
recommended_next_phase: GATEKEEPER
proof_status: broken
Verdict

VERDICT: PASS

Reason: the prover’s stall is correctly diagnosed. The three obstacles are not cosmetic algebra slips. They are different faces of the same transport-to-deletion gap: menu-Hall is a messagewise calibration condition, while Lemma A.2 needs a sourcewise, compact, value-preserving deletion of payoff-profile labels. Under standing assumptions plus exact-contact, that conversion is not justified. This is consistent with v8’s tiering: value optimality is unconditional, exact adversary attainment needs exact-contact, and full robust rationalizability is only proved after adding menu-Hall. 

theorem_2_extension_proof_v8

 The original paper also proves Theorem 2 existence only for finite M,Θ, explicitly flagging infinite-dimensional cheap-talk continuity issues. 

Robust_trust_Dworczak_Smolin

Detailed Audit
1. Three named obstacles

(1) Support saturation: real, with one precision correction.
The real condition is label-saturation, not literally message-saturation. If D=C
∗
∖c(E), deletion raises

ℓ
D
	​

(s)=
z∈D
min
	​

s⋅z

above ℓ
C
∗
	​

(s) only if no retained label is an old C
∗
-minimizer for s. Equivalently,

Argmin
C
∗
	​

(s)∩D=∅.

The stronger condition G(s)⊆E is sufficient when labels are injective, but not necessary if a deleted label has several message names. Still, the prover’s obstacle is genuine. If λ sends s to some m∈E∩G(s), that only says one old minimizer was touched. If another m
′
∈G(s)∖E has a retained label c(m
′
)∈
/
c(E), then

ℓ
D
	​

(s)≤s⋅c(m
′
)=ℓ
C
∗
	​

(s),

hence ℓ
D
	​

(s)=ℓ
C
∗
	​

(s), since D⊆C
∗
 gives ℓ
D
	​

≥ℓ
C
∗
	​

. No adversarial-side gain occurs.

Exact-contact gives only nonemptiness of G(s) and a measurable selector. It does not imply uniqueness of minimizers, closure under all co-minimizers, or any statement of the form “if one contact lies in E, then all contact labels lie in E.” A two-label toy picture already shows this: let C={z
1
	​

,z
2
	​

}, take a source s with s⋅z
1
	​

=s⋅z
2
	​

=ℓ
C
	​

(s), and let E contain only a message labeled z
1
	​

. Exact-contact can select z
1
	​

, but deleting z
1
	​

 leaves z
2
	​

, so ℓ does not rise. The “phantom fuel” language is accurate: the dual can count a contact that deletion does not monetize.

(2) Replacement-index: real.
The displayed dual expression uses a replacement z(m) indexed by the message:

α∫
E
	​

m⋅(c(m)−z(m))τ(dm)−(1−α)∫
M×E
	​

(s⋅z(m)−ℓ
C
	​

(s))λ(ds,dm)≥0.

By contrast, deletion changes the adversarial term through

ℓ
D
	​

(s)−ℓ
C
	​

(s)=
z∈D
min
	​

s⋅z−ℓ
C
	​

(s),

which is indexed by the source s. If z(m)∈D, then

ℓ
D
	​

(s)≤s⋅z(m),

so

ℓ
D
	​

(s)−ℓ
C
	​

(s)≤s⋅z(m)−ℓ
C
	​

(s).

This is the wrong direction for a lower bound on the gain from deletion. The displayed term can upper-bound the possible replacement loss, but it cannot certify the actual deletion improvement.

There is no harmless reinterpretation that fixes this. The menu-Hall dual is naturally messagewise because Bayes calibration is imposed at each received message m. Deletion value is sourcewise because the misaligned adviser’s payoff at source s is determined by the best retained minimizer for that source. Unless the transport is essentially invertible, or all sources routed to a message share the same retained minimizer, z(m) cannot be read as argmin
D
	​

s⋅z. That is an additional structural theorem, not algebra hidden in the existing dual.

(3) Borel→compact: real.
Bare Borel measurability plus behavioral minimality does not let one turn a deficient Borel message set into a removable compact label patch. A simple example is enough. Let M=C
∗
=[0,1], τ be Lebesgue measure, and c(m)=m. Then C
∗
=
c(M)
	​

, so behavioral minimality holds in the closure sense. Take E to be a fat Cantor set of positive measure and empty interior. Then M∖E is dense, so

c(M∖E)
	​

=[0,1]=C
∗
,

even though τ(E)>0. Removing a positive-measure Borel set of messages need not remove any compact portion of the behavioral menu. An even harsher variant uses E=[0,1]∖Q, with full measure and dense complement.

Thus the issue is not a measurability slip. It persists even with continuous c. To get a compact deletion, one needs label regularity beyond behavioral minimality: closed images, nonredundant fibers, local thickness, or some primitive rule saying positive message defects correspond to positive label patches.

2. Does the diagnosis block Strategy 3 general form?

Yes. The diagnosis blocks the C1 canonical/minimal-menu route as a general proof under standing plus exact-contact.

The key point is that menu-Hall failure is a calibration failure over the joint law of sources and messages. Lemma A.2 wants to infer from that failure a proper compact D⊊C
∗
 with

F(D)≥F(C
∗
).

But F(D)−F(C
∗
) is governed by two concrete effects:

α∫(a
D
	​

−a
C
	​

)dτ+(1−α)∫(ℓ
D
	​

−ℓ
C
	​

)dτ.

The first term is an aligned loss from removing labels used as maximizers. The second term is a sourcewise gain only for sources whose entire old minimizer set is removed. The Hall dual does not automatically identify such sources, does not choose their true D-minimizers, and does not ensure the deficient message set removes a compact label subset. Any alternative proof, transport-based or not, must still manufacture those three ingredients. Renaming the argument as variational, normal-cone, or compactness-based does not remove the need for saturation, sourcewise lower bounds, and compact deletion.

Unblocker A is therefore the right kind of missing theorem: a deletion-compatible Hall duality would need to build the deletion event and sourcewise minimization directly into the dual. That would be a new theorem, not a patch to the current algebra.

Unblocker B is directionally right but not sufficient as stated. Closed graph of w
∗
, upper hemicontinuity of G, and τ-a.e. uniqueness of minimizers would help with exact-contact and saturation. If each source has a unique minimizing label, then touching that minimizer really does remove the old minimizer, provided the label itself is deleted. Label regularity could also help convert deficient Borel sets into compact patches. But the replacement-index problem remains unless B is strengthened further: one still needs the dual replacement to be sourcewise, or a structural reason why every message fiber has a common retained minimizer. Without that, s⋅z(m)−ℓ
C
	​

(s) is still only an upper bound on the deletion improvement.

A softer A.2 is unlikely to close the route. Statements like “there exists proper compact D with F(D)≥F(C
∗
)−ε” are either trivial by Hausdorff continuity when C
∗
 has removable non-isolated parts, or false/noninformative for finite or isolated essential menus. More importantly, approximate deletion does not imply exact menu-Hall, exact adversarial calibration, or robust rationalizability. v8 already has unconditional value optimality plus ε-adversaries; the missing object is exact per-message Bayes calibration. 

theorem_2_extension_proof_v8

 An approximate deletion lemma would not provide that unless coupled to a compactness-and-closed-graph limit theorem, which is exactly where the prior attempts repeatedly hit compactness and attainment obstructions. 

prior_attempts_digest

3. Special-geometry candidates

C2: exposed-extreme geometry.
Exposedness helps identify labels by supporting hyperplanes and can make normal-fan arguments sharper. It does not automatically supply saturation. A label may be exposed as a maximizer for some messages while sources minimizing it still have co-minimizers. Nor does exposedness prevent dense redundant labeling of the same compact menu. C2 therefore needs its own analog of A.2 or, better, a direct construction of a calibrated adversarial kernel.

C3: primitive TR-minimality.
This is useful because it attacks the representational artefact problem. v8’s ternary witness is explicitly classified as a menu-engine artefact rather than a primitive counterexample: the halfspace trust region induces the full vertex menu and is behaviorally equivalent to full trust. 

theorem_2_extension_proof_v8

 Primitive minimality may rule out such scenery. But it still does not, by itself, turn Hall failure into compact deletion or solve the message/source index mismatch. C3 also needs its own bridge from primitive minimality to menu-Hall.

C4: radial/orbit symmetry.
This is the most promising special case, but only when the symmetry is strong enough to give an explicit calibrated transport. The paper’s binary interval construction uses quantile transport to make posterior beliefs equal the interval endpoints, and the spherical example uses antipodal geometry to identify the adversary’s boundary report. 

Robust_trust_Dworczak_Smolin

 Those are direct TRE constructions, not automatic consequences of minimality. Generic orbit symmetry does not ensure saturation unless the group action aligns minimizer cones, Bayes cones, and the distribution τ in a balancing identity. So C4 can live, but as a special-geometry prover pass, not as a rescue of general Lemma A.2.

Opinion and Next Move

The orchestrator should stop and gatekeeper. The v8 terminal posture is honest: unconditional value optimality and ε-adversaries are in hand, exact-contact buys exact adversary attainment, and menu-Hall remains the missing calibration assumption for full robust rationalizability. The A.2 trapdoor was the last plausible general C1 mechanism for deriving menu-Hall from canonical/minimal menus, and this review confirms that it is blocked by real structural gaps. Special-geometry passes may still be worthwhile as separate islands, especially binary, exposed-normal-fan, or spherical/orbit cases, but they should not be treated as restoring the general route. Take v8 plus the sharpness package plus this stall to a third-pass gatekeeper for a final publishability/terminal-state verdict.
