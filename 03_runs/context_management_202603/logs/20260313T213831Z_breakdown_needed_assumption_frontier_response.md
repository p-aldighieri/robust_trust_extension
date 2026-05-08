## Verdict

The most honest general outcome is to keep the Needed assumption explicit. The current obstruction is exactly message-side exactness: the continuity-based raw lift only preserves the pushed-forward label kernel (\bar w^*_{#}\beta^*=\kappa^*), and that is strictly weaker than the existence of a posterior version (p_0) with zero Bayes gap (h_W(p_0(m))-p_0(m)\cdot \bar w^*(m)=0) (q^*)-a.e. The durable route memo and proof state already identify this as the live bottleneck, and the reviewer’s smallest viable repair is to state the Needed assumption explicitly rather than keep strengthening the present lift theorem.   

## Ranked next routes

1. **Bank the conditional theorem now.**
   Treat the Needed assumption as an explicit theorem hypothesis and close the exact version-and-patching saddle lemma conditionally. This is the narrow route already isolated in the consolidator note, and it does not reopen any dead unconditional branch.
   **First local lemma for this route:**
   **Conditional exact-patching lemma.** Assume the chosen raw lift (\beta^*) admits a Borel posterior version (p_0) such that
   [
   \bar w^*(m)\in \arg\max_{w\in W} p_0(m)\cdot w
   \qquad q^*\text{-a.e.}
   ]
   Then
   [
   N:={m: h_W(p_0(m)) - p_0(m)\cdot \bar w^*(m)>0}
   ]
   is Borel and (q^*(N)=0). Patching with the selector package ((D,\pi)) on (N) preserves the posterior version and the adviser-side saddle inequalities, hence yields a full reduced-game saddle. 

2. **Run one narrow strengthened-condition probe, but only as a yes/no test.**
   **Needed strengthened condition candidate:** a fiber-rigidity condition strong enough that, on the (q^*)-support, observing the raw message (m) carries no more information than observing the collapsed label (\bar w^*(m)). The cleanest surrogate is (q^*)-a.e. injectivity of (m\mapsto \bar w^*(m)), or any primitive hypothesis that implies the same one-message-per-label property.
   **Crux lemma if this route is pursued:** if (\bar w^*) is (q^*)-a.e. injective and the reduced saddle admits a Borel posterior label map (\hat p(w)) with
   [
   w\in \arg\max_{u\in W}\hat p(w)\cdot u,
   ]
   then (p_0(m):=\hat p(\bar w^*(m))) is a posterior version under the chosen raw lift.
   Honest assessment: this is strong, probably unnatural for trust-region clipping, and looks more like an outcome restriction than a primitive one. I would spend at most one short cycle on it.  

3. **If a stronger theorem is still required, leave the least-strengthened general route.**
   Move to a special-class branch where the messagewise posterior equations can be solved directly, such as the atomic branch already parked in the proof state. That can still produce theorems, but it is no longer the least-strengthened exact route.  

## Why Route 1 should dominate

The aligned adviser truthfully reveals the raw message (m). So whenever distinct raw messages survive inside the same (\bar w^*)-fiber, the raw posterior can vary within that fiber even though the pushed-forward label kernel is fixed. The two-message obstruction shows that adviser optimality against the fixed selector does not remove this within-fiber freedom. Any general strengthening that forces the Needed assumption must therefore rigidify those fibers in substance. I do not currently see a genuinely natural primitive condition that does that without coming very close to assuming the conclusion itself.  

**Suggested next local action:** bank Route 1, and set the first local lemma to the conditional exact-patching lemma above.
