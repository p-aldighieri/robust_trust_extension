I’m comparing the obstruction note, the follow-up proofs, and the durable route memo to rank only theorem-producing continuations that still survive the new counterexamples.The focus is now the strongest surviving theorem that does not smuggle in extra assumptions, while avoiding routes the new obstruction has already killed.

Best: promote the fixed-γ\gammaγ split theorem to the new local endpoint.
Under the standing assumptions, the adviser-side compactification survives exactly at the level of values and fails exactly at the level of strategies. For every fixed relaxed reduced-agent kernel γ\gammaγ, the correct local theorem is
min⁡Λ∈CγLγ(Λ)=α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)inf⁡β∫M∫MΦ(s,Γγ(m)) β(dm∣s) τ(ds),\min_{\Lambda\in\mathcal C_\gamma} L_\gamma(\Lambda)
=
\alpha\int_M \Phi(s,\Gamma_\gamma(s))\,\tau(ds)
+
(1-\alpha)\inf_{\beta}
\int_M\int_M \Phi(s,\Gamma_\gamma(m))\,\beta(dm\mid s)\,\tau(ds),Λ∈Cγ​min​Lγ​(Λ)=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)βinf​∫M​∫M​Φ(s,Γγ​(m))β(dm∣s)τ(ds),
hence also
min⁡Λ∈CγLγ(Λ)=α∫MΦ(s,Γγ(s)) τ(ds)+(1−α)∫Minf⁡m∈MΦ(s,Γγ(m)) τ(ds).\min_{\Lambda\in\mathcal C_\gamma} L_\gamma(\Lambda)
=
\alpha\int_M \Phi(s,\Gamma_\gamma(s))\,\tau(ds)
+
(1-\alpha)\int_M \inf_{m\in M}\Phi(s,\Gamma_\gamma(m))\,\tau(ds).Λ∈Cγ​min​Lγ​(Λ)=α∫M​Φ(s,Γγ​(s))τ(ds)+(1−α)∫M​m∈Minf​Φ(s,Γγ​(m))τ(ds).
But there need not exist any raw measurable adviser kernel attaining that infimum, so compactified minimizers need not lift. This is now the reviewer-cleared replacement for the false bottleneck still recorded in proof_state.md and exact_route1_strategy.md. It is the best continuation because it is already theorem-producing, uses no new assumptions, and respects all three hard constraints. It does not settle the existence side of Theorem 2 beyond finite MMM, so it should be written as a weaker local theorem, not as a hidden step toward the full saddle result.       
First local decision: delete the “exact version-and-patching saddle lemma” as an active target and replace it by the lemma pair
fixed-γ raw-vs-compactified no-gap + exact raw attainment can fail.   


Second: rescue exactness only after adding one explicit regularity assumption.
Needed assumption (sufficient, not in the standing hypotheses): for each admissible reduced-agent kernel γ\gammaγ, the barycentric image map m↦wˉγ(m)m\mapsto \bar w_\gamma(m)m↦wˉγ​(m) is continuous on MMM. Since M⊆Δ(Ω)M\subseteq \Delta(\Omega)M⊆Δ(Ω) is compact, this makes wˉγ(M)\bar w_\gamma(M)wˉγ​(M) compact, so each pointwise problem min⁡m∈Ms⋅wˉγ(m)\min_{m\in M} s\cdot \bar w_\gamma(m)minm∈M​s⋅wˉγ​(m) is attained; the argmin correspondence has nonempty compact values and closed graph, hence a Borel selector. Under that added assumption, the fixed-γ\gammaγ compactified minimizer lifts exactly to a raw measurable adviser kernel, so the adviser-side compactification becomes exact at the strategy level again. This is the cleanest way to reopen an exact theorem, but only for a strengthened statement.  


Third: strongest trustworthy stopping point.
If the project must keep the original standing assumptions, the honest frontier is now: exact existence for finite MMM; fixed-γ\gammaγ exact value compactification; explicit counterexample to exact raw lifting; and no current trustworthy route to robustly rationalizable existence beyond finite MMM. The atomic truncation-limit fallback is also off the table under the accepted obstruction, so further prover effort on exact patching is more likely to burn time than produce a theorem.     


Suggested next local action: update proof_state.md so the active beyond-finite-M branch is Route 1 above, and request a clean standalone writeup of the fixed-γ\gammaγ value theorem together with the nonattainment counterexample.
