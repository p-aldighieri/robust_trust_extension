I’m reading the request packet alongside the three supporting notes, then I’ll either give a clean proof of the U-side lemma or isolate the first exact obstruction.I’m now keeping strictly to the U-side hinge, testing whether the finiteness reduction can turn infinitely many unmoved coordinates into an admissible tail-comparison contradiction, or whether the gap appears even earlier.Local verdict
On the current banked record, the eventual-movement lemma U<∞U<\inftyU<∞ is still not forced. The first exact irreducible obstruction is the absence of a route-compatible uniformization/common-direction lemma that turns infinitely many unmoved coordinates into one admissible tail direction. That is exactly the crux identified by the current prompt packet and the reviewer-cleared breakdown: from UUU infinite, one wants an admissible infinite-support comparison path that contradicts the banked tail-lifting restriction, but the missing bridge is the passage from local unmoved-coordinate information to a common tail direction.   
Proof attempt up to the obstruction
Assume, for contradiction, that UUU is infinite.
To use the banked maximizer-level tail-lifting restriction, one would need to produce a comparison path
wt=w∗+tdw_t = w^* + t dwt​=w∗+td
for small t>0t>0t>0 such that all of the following hold:


ddd is an admissible infinite-support perturbation at w∗w^*w∗.


The aligned first-order term along ddd is zero.


The relevant floor/tail quantity is strictly improved for small t>0t>0t>0.


Only after such a ddd is built can the tail-lifting restriction fire.
The natural way to build ddd is to aggregate local perturbations attached to unmoved coordinates j∈Uj\in Uj∈U. This is also the exact route prescribed in the breakdown note: extract from infinitely many unmoved coordinates an admissible infinite-support comparison path with zero first-order aligned cost and positive tail lift. 
Where the proof actually stops
The stop is earlier than any later admissibility refinement or CTR clause.
What is banked is only that the finiteness hinge is open, that U<∞U<\inftyU<∞ is not yet implied by any current lemma, and that the earlier prover pass already located the missing bridge as the jump from the local (d1=e1)(d_1=e_1)(d1​=e1​) obstruction witness to an eventual-tail statement. The reviewer also cleared that CTR gives only a conditional export from an already supplied finite-anchor/infinite-tail decomposition, so CTR cannot manufacture the needed tail path from the present cone data.  
Concretely, from UUU infinite the current banked inputs do not yield:
∃J⊆U, ∣J∣=∞, ∃{δ(j)}j∈J\exists J\subseteq U,\ |J|=\infty,\ \exists \{\delta^{(j)}\}_{j\in J}∃J⊆U, ∣J∣=∞, ∃{δ(j)}j∈J​
such that the δ(j)\delta^{(j)}δ(j) are local admissible witnesses of a common type on an infinite subset, in a sense strong enough that they can be summed with positive coefficients into one admissible global ddd.
That missing statement has two parts, and the first missing part is already fatal:
First missing part: common witness class / common cone
There is no banked lemma saying that infinitely many unmoved coordinates admit local witnesses lying in one common admissible cone, one common obstruction ray, or even one finite family of local geometric types.
Countability of UUU alone does not solve this. A countably infinite set can still support infinitely many different local witness geometries. Without a banked finite classification, compactness, or monotonicity statement, there is no infinite-pigeonhole step available. So one cannot currently pass from
j∈U individuallyj\in U \text{ individually}j∈U individually
to
j∈J⊆U infinitely many with compatible local perturbations.j\in J\subseteq U \text{ infinitely many with compatible local perturbations.}j∈J⊆U infinitely many with compatible local perturbations.
This is the first exact obstruction.
Downstream issues, not the first obstruction
Even if one had such a compatible infinite subset, one would still need a second lemma showing that suitably scaled coefficients aj>0a_j>0aj​>0 produce
d=∑j∈Jajδ(j)d=\sum_{j\in J} a_j \delta^{(j)}d=j∈J∑​aj​δ(j)
with admissibility preserved, zero aligned first-order effect, and strictly positive tail lift.
I am not claiming this second aggregation step is automatic. I am only saying it is downstream. The proof already fails before reaching it, because the current banked inputs do not give the prerequisite common-direction extraction.
Precise crux lemma that would unlock the U-side
The minimal new ingredient is a lemma of the following form:
Needed assumption / crux lemma.
If UUU is infinite, then there exists an infinite subset J⊆UJ\subseteq UJ⊆U such that the unmoved coordinates in JJJ admit compatible local admissible perturbations of one common type, strong enough to be combined into a single infinite-support admissible direction.
A stronger, fully usable version would be:
Needed assumption / stronger crux lemma.
If UUU is infinite, then there exist an infinite J⊆UJ\subseteq UJ⊆U, local perturbations δ(j)\delta^{(j)}δ(j) for j∈Jj\in Jj∈J, and coefficients aj>0a_j>0aj​>0 with ∑jaj<∞\sum_j a_j<\infty∑j​aj​<∞ such that
d=∑j∈Jajδ(j)d=\sum_{j\in J} a_j \delta^{(j)}d=j∈J∑​aj​δ(j)
is admissible at w∗w^*w∗, has zero aligned first-order effect, and strictly lifts the relevant floor/tail functional.
Under such a lemma, the eventual-movement contradiction would become plausible. Without it, the current banked inputs do not force U<∞U<\inftyU<∞.
So the honest branch verdict is:


the eventual-movement lemma is not proved on the current record;


the first exact reason is the missing U-side uniformization step from infinitely many unmoved coordinates to one common admissible tail direction;


nothing later in CTR/admissibility/support geometry should be reopened before that exact bridge is settled.


Suggested next local action: prove a U-side common-direction extraction lemma, namely that UUU infinite yields an infinite subset of unmoved coordinates sharing one compatible local witness class/cone; only after that attempt the summable aggregation into an admissible infinite-support comparison path.
