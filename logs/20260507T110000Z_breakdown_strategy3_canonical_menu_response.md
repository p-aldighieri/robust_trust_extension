
========
ROLE: user (id=e520583f-effc-411e-a3bb-9cb44e616210)
========
# Breakdown — Strategy 3: canonical/minimal menu route

You are the **Breakdown** role in the soft-scaffolding workflow. Your job is to decompose Strategy 3 (the canonical/minimal menu route) into a numbered sequence of concrete sub-questions and lemma candidates that a prover can attack one at a time. The breakdown must include explicit guardrails: a clear test for whether any candidate "primitive condition" actually bypasses menu-Hall or merely renames it.

## State of play

- **v8** is the current proof state (durable source). Tier 1a unconditional (existence + ε-adversaries). Tier 1b under (exact-contact). Tier 2 under (exact-contact) + (menu-Hall).
- **menu-Hall** is the calibration condition: ∃ kernel κ supported on rowwise minimizers $G(s)$ such that the disintegration posterior $P_{\gamma_\alpha}(\cdot\mid m)\in B(m)$ q-a.e.
- The gatekeeper's two-pass evaluation classified menu-Hall as **scope-changing**: weaker than deterministic TRE-gen-Hall, but still installs the equilibrium calibration that Definition 2 demands.
- v8's sharpness package (cone intersection lemma + no-free-dust theorem) shows menu-Hall is genuinely needed inside the menu engine. Classification (b) shows the witness is a menu-engine artefact, not a primitive counterexample.
- The gatekeeper's preferred non-narrowed route: **find a primitive, behaviorally minimal payoff-profile menu (not merely an $F$-optimal menu in $\mathcal K(W)$) and ask whether calibration follows from canonicality.**
- The gatekeeper's explicit risk warning: *"if the proof ever says 'choose κ satisfying posterior calibration,' it has looped back into the cave."*

## Your task

Produce a breakdown with the following structure. Be concrete. Every lemma candidate must have a precise statement, not a hand-wave.

### Step 1. Define candidate canonicality conditions

Propose 2–4 distinct candidate definitions of "canonical/minimal payoff-profile menu" that could plausibly imply calibration. Examples (you may use these or propose better ones):

- **(C1) Behavioral minimality:** $C^*$ is minimal among $F$-optimal menus, in the sense that no proper compact subset of $C^*$ is $F$-optimal.
- **(C2) Extreme-point canonicality:** $C^* = \overline{\mathrm{conv}}(\{w^*(m) : m\in M\})$ and the labeling $w^*$ is extreme-point-valued.
- **(C3) Trust-region induced:** $C^*$ arises as the image of the agent's primitive Bayes-action correspondence applied to a trust region $T$ that is minimal among Theorem-1-equivalent trust regions.
- **(C4) Algebraic / symmetry canonicality:** $C^*$ is invariant under any model symmetry (e.g., a transitive group action on $\Omega$ that preserves $u$, $\tau$).

For each candidate, state precisely what "canonical" means as a property of $C^*$ (or of the labeling $w^*$, or of the underlying primitives).

### Step 2. The renaming test

For each canonicality candidate from Step 1, decide whether a positive theorem of the form

> *Canonicality (Cn) implies menu-Hall*

would **bypass** or **rename** the calibration condition. The renaming test is:

- **Bypass** if (Cn) is checkable from primitives without reference to:
  - existence of a kernel κ supported on rowwise minimizers,
  - any disintegration posterior membership condition,
  - any direct Bayes-cone inclusion at messages.
- **Rename** if (Cn) implicitly involves the existence of any of the above.

This is the gatekeeper's hard test. State explicitly for each (Cn) whether it passes the bypass test, and if it does, what verifiable primitive condition it commits to.

### Step 3. Decompose into lemma candidates

For each canonicality candidate that passes the renaming test, propose a sequence of concrete lemmas a prover can attack. Each lemma needs:

- A precise statement.
- Stated dependencies on earlier lemmas.
- A technique hint (e.g., extreme-point analysis, Choquet, group orbits, primal-dual feasibility).
- A difficulty estimate (light / medium / heavy).

For each canonicality candidate that fails the renaming test, mark it dead and explain why succinctly.

### Step 4. Identify the critical lemma

Among all surviving lemma candidates, identify the **single critical lemma** — the one whose proof or disproof determines whether Strategy 3 is alive or dead. Justify the choice in one paragraph.

### Step 5. Test cases

For each surviving canonicality candidate, name a concrete test case where the candidate's prediction can be checked:

- Binary state $|\Om| = 2$: the paper's Appendix A.6 quantile transport. Does (Cn) hold? Does it imply menu-Hall?
- Spherical / radial: the paper's §5.2 + Appendix A.10. Does (Cn) hold? Does it imply menu-Hall?
- Ternary winner-takes-all (the v8 witness): does (Cn) FAIL here, consistent with menu-Hall failing? Or does (Cn) hold and we'd need to revisit?

A good canonicality candidate should pass on the binary and spherical positive cases and fail on the ternary witness, lining up with the calibration story.

## What you MUST do

- Be precise. No "morally similar" handwaves.
- Apply the renaming test honestly. If a candidate is just menu-Hall in a costume, say so.
- Keep the breakdown under 2000 words. Density over bulk.
- Output a numbered list of lemmas at the end so the orchestrator can route the next prover pass to one of them.

## What you MUST NOT do

- Do not propose proofs. That is the prover's job.
- Do not claim a candidate is bypass without explicit primitives.
- Do not silently extend the project's hypotheses; if your decomposition needs one, surface it as an ambiguity.

## Output Format


markdown
## Strategy 3 Breakdown

### Step 1. Canonicality Candidates
- (C1) ...
- (C2) ...
- (C3) ...
- (C4) ...

### Step 2. Renaming Test
- (C1): bypass / rename — justification
- (C2): ...
- ...

### Step 3. Lemma Candidates
For each surviving candidate:
- Lemma A.1 (statement, dependencies, technique, difficulty)
- Lemma A.2 ...
- Lemma B.1 ...

### Step 4. Critical Lemma
The single critical lemma is [number]. Justification: ...

### Step 5. Test Cases
- Binary: ...
- Spherical: ...
- Ternary witness: ...

### Numbered Action List for Prover
1. (Critical lemma to attack first.)
2. (Next.)
3. ...

### Honest Assessment
(One paragraph: is Strategy 3 a real route, or is it likely to dead-end at a renaming? If the latter, recommend stopping with v8.)


Length: 1200–1800 words.

Show more

========
ROLE: assistant (id=78864087-65dc-4df9-ae39-ec23f0916931)
========
Strategy 3 Breakdown

I treat v8 as the durable proof state: Tier 1a unconditional, Tier 1b under exact-contact, Tier 2 under exact-contact plus menu-Hall, with the ternary no-free-dust witness classified as a menu-engine artefact rather than a primitive counterexample. 

theorem_2_extension_proof_v8

 The binary and spherical tests below refer to the paper’s Appendix A.6 and §5.2/A.10 constructions. 

Robust_trust_Dworczak_Smolin

Step 1. Canonicality Candidates

(C1) Behavioral minimality.
A compact menu C
∗
⊆W is behaviorally minimal if

C
∗
∈arg
C∈K(W)
max
	​

F(C)andF(D)<F(C
∗
) for every nonempty compact D⊊C
∗
.

A labeling w
∗
:M→C
∗
 is canonical if w
∗
(m)∈argmax
w∈C
∗
	​

m⋅w and 
w
∗
(M)
	​

=C
∗
.

(C2) Exposed-extreme canonicality.
C
∗
 is exposed-extreme canonical if C
∗
∈argmaxF, there is a primitive tie-breaking rule selecting a Borel w
∗
(m)∈argmax
w∈C
∗
	​

m⋅w, and for τ-a.e. m,

w
∗
(m)∈Ext(W),C
∗
=
w
∗
(M
0
	​

)
	​


for some τ-full Borel set M
0
	​

. Ties must be broken by a fixed primitive rule, not by reference to adversarial posteriors.

(C3) Primitive trust-region minimality.
Let U(μ)=max
σ
^
	​

U(
σ
^
,μ), and let R(μ)⊆W be the primitive Bayes-profile correspondence. For compact connected non-hollow T⊆Δ(Ω), define

C
T
	​

:=
μ∈T
⋃
	​

R(μ)
	​

.

T
∗
 is primitive TR-minimal if F(C
T
∗
	​

) is maximal over this class and no proper compact connected non-hollow T
′
⊊T
∗
 satisfies F(C
T
′
	​

)=F(C
T
∗
	​

).
Ambiguity surfaced: useful versions may need differentiability or unique Bayes profiles; those are added regularity hypotheses, not standing assumptions.

(C4) Radial/orbit symmetry canonicality.
There is a compact group G acting continuously on Δ(Ω) and W, preserving pairings s⋅w, W, U, and τ. The quotient M/G is one-dimensional with primitive radius r∈[0,r
0
	​

]. Menus take the form

C
ρ
	​

=
{g⋅w
r
	​

:0≤r≤ρ, g∈G}
	​

,

and C
∗
=C
ρ
∗
	​

, where ρ
∗
 uniquely maximizes the scalar primitive objective ρ↦F(C
ρ
	​

). The selector is equivariant: w
∗
(gm)=gw
∗
(m).

Step 2. Renaming Test

(C1): bypass. It refers only to W,τ,α,F, compact subsets, and aligned labels. It commits to a primitive irredundance test: deleting any payoff profiles strictly lowers F. It does not mention κ, disintegration posteriors, or Bayes-cone membership at messages.

(C2): bypass, but weak. It is checkable from W, exposed faces, τ, and a primitive tie rule. It risks being too thin: extreme-point labels do not by themselves create calibrated transport.

(C3): bypass only in the primitive F(C
T
	​

) formulation above. The phrase “minimal among Theorem-1-equivalent trust regions” is dead if equivalence is defined using corresponding adversarial strategies, because that sneaks in rowwise minimizer kernels. The C
T
	​

-minimal version is primitive.

(C4): bypass. Group action, invariant radius, and one-parameter maximization are primitive. It would become a rename if the hypothesis included “there exists an equivariant kernel whose posterior is calibrated.” That sentence is the cave entrance.

Step 3. Lemma Candidates
Candidate C1: Behavioral minimality

Lemma A.1, irredundance of exposure.
If C
∗
 satisfies C1, then every nonempty relatively open O⊆C
∗
 has positive exposure:

τ{s:arg
C
∗
max
	​

s⋅w∩O

=∅}>0

or

τ{s:arg
C
∗
min
	​

s⋅w∩O

=∅}>0.

Dependencies: none. Technique: compact pruning in Hausdorff topology. Difficulty: medium.

Lemma A.2, uncalibrated minimal menu pruning.
Assume exact-contact. If C
∗
 satisfies C1 and menu-Hall fails for the canonical w
∗
, then there exists a nonempty compact D⊊C
∗
 with F(D)≥F(C
∗
).
Dependencies: A.1. Technique: Strassen/Kellerer duality plus translating a separating certificate into a menu deletion. Difficulty: heavy.

Lemma A.3, C1 calibration theorem.
Under exact-contact, C1 implies menu-Hall.
Dependencies: A.2. Technique: contradiction. Difficulty: heavy.

Candidate C2: Exposed-extreme canonicality

Lemma B.1, exact-contact from exposed closure.
If C
∗
 satisfies C2 and the selected graph m↦w
∗
(m) is closed on a τ-full Borel set, then the rowwise contact sets

G(s)={m:s⋅w
∗
(m)=
z∈C
∗
min
	​

s⋅z}

are nonempty and admit a measurable selector τ-a.e.
Dependencies: none. Technique: closed graph plus KRN/Jankov-von Neumann. Difficulty: medium.

Lemma B.2, finite normal-fan reduction.
If W is a polytope and C
∗
⊆Ext(W) satisfies C2, then menu-Hall is equivalent to feasibility of a finite system of measure inequalities indexed by max-cones and min-cones of the normal fan.
Dependencies: B.1. Technique: finite Strassen duality/LP feasibility. Difficulty: medium.

Lemma B.3, C2 falsification test.
In any polyhedral environment where the finite normal-fan system in B.2 is infeasible while C2 holds, C2 does not imply menu-Hall.
Dependencies: B.2. Technique: dual certificate. Difficulty: light once B.2 is done.

Candidate C3: Primitive TR-minimality

Lemma C.1, TR-minimality implies menu irredundance.
Suppose R(μ) is single-valued and continuous on T
∗
. If T
∗
 satisfies C3, then C
T
∗
	​

 satisfies C1.
Dependencies: none. Technique: continuous image and inverse-pruning. Difficulty: medium.
Added hypothesis: single-valued continuous Bayes profile on T
∗
.

Lemma C.2, shape first-order balance.
Suppose U is C
2
 and strictly convex, τ has full support density, and T
∗
 satisfies C3 with smooth boundary. For every smooth local deformation of ∂T
∗
, the first variation of F(C
T
	​

) at T
∗
 is zero or has the correct one-sided sign. This first-order condition is equivalent to boundary-source barycenter balance along Bregman-farthest contact sets.
Dependencies: C.1 optional. Technique: shape derivative, normal cones, envelope theorem. Difficulty: heavy.

Lemma C.3, TR balance to menu-Hall.
Under exact-contact and the balance conclusion of C.2, the Bregman-farthest correspondence admits a measurable kernel κ satisfying menu-Hall.
Dependencies: C.2. Technique: measurable selection plus transport disintegration. Difficulty: heavy.

Candidate C4: Radial/orbit symmetry

Lemma D.1, orbit reduction.
Under C4, F(C
ρ
	​

)=f(ρ) for a scalar continuous function f, and rowwise minimizer sets are equivariant:

G(gs)=gG(s).

Dependencies: none. Technique: Haar integration and quotient disintegration. Difficulty: medium.

Lemma D.2, equivariant calibration.
If ρ
∗
 is an interior maximizer of f, the Haar-averaged equivariant rowwise-minimizer kernel has disintegration posterior in the Bayes cone of w
∗
(m) for q-a.e. m.
Dependencies: D.1. Technique: orbit barycenters and representation symmetry. Difficulty: heavy.

Lemma D.3, finite-symmetry insufficiency.
Mere transitive finite symmetry on states does not imply D.2. In particular, if the orbit quotient is not one-dimensional radial, cone-intersection obstructions may survive.
Dependencies: B.2 or v8 cone lemma. Technique: normal-fan comparison. Difficulty: medium.

Step 4. Critical Lemma

The single critical lemma is Lemma A.2, uncalibrated minimal menu pruning. If failure of menu-Hall always produces a proper compact sub-menu with weakly higher F, then behavioral canonicality genuinely bypasses calibration: Hall is forced by primitive irredundance. If A.2 is false, then C1 and likely C2 collapse as real routes, and only special geometric islands such as C3/C4 remain. This is the trapdoor lemma: it decides whether “minimal menu” is substance or just a prettier lantern in the same cave.

Step 5. Test Cases

Binary state.
C1 should hold for the unique nontrivial trust interval when α>1/2, strict convexity holds, and τ has positive density; at α≤1/2, the singleton prior is minimal. C2 also holds under unique Bayes profiles. C3 holds for the primitive interval. C4 holds only in symmetric binary cases. Appendix A.6’s quantile transport is the positive calibration check.

Spherical/radial.
C4 is the clean fit: invariant balls C
ρ
	​

, antipodal minimizers, scalar radius equation. C3 should also hold when the optimal ball is primitive-minimal. C1 likely holds if radial density has full support and the maximizing radius is unique. Calibration is checked by the paper’s antipodal construction.

Ternary WTA v8 witness.
C3 fails for the halfspace T={μ:μ
0
	​

≤.4}: v8 classifies it as non-load-bearing, behaviorally equivalent to the full vertex menu. C4 radial symmetry fails; finite S
3
	​

 symmetry alone is not enough. C2 may hold for the full vertex normal fan, so if the primitive full-vertex menu is also optimal and menu-Hall fails, C2 is falsified rather than rescued. C1 is the dangerous test: if the full vertex menu is genuinely C1-minimal and still uncalibrated, Strategy 3 dies outside special geometry.

Numbered Action List for Prover

Prove or disprove Lemma A.2.

Run Lemma B.2 on the ternary WTA normal fan to see whether C2 is already dead.

Prove Lemma C.2 in the binary interval case as a warm-up.

Prove Lemma D.2 for the spherical model using orbit barycenters.

Check whether C3 reduces to C1 through Lemma C.1 under minimal extra regularity.

Honest Assessment

Strategy 3 is real, but its general form hangs by one iron thread: A.2. Behavioral minimality is the only broad candidate that could truly bypass menu-Hall. Exposed-extreme canonicality is probably too weak. Primitive trust-region minimality and radial symmetry are promising positive islands, especially because they match the binary and spherical constructions and exclude the ternary halfspace artefact. If A.2 fails in a primitive test case, the honest endpoint is v8: Tier 2 remains conditional on menu-Hall, with canonicality useful only in special geometries.
