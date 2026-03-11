## Literature map for the extension of Theorem 2

The durable project sources already isolate the right split. Theorem 2 has a verification direction, “robustly rationalizable (\Rightarrow) optimal,” and a separate existence direction. In the paper, existence is proved only when (M) and (\Theta) are finite, by putting the zero-sum game on compact convex products of simplices and applying Sion’s minimax theorem. The project target is the stronger existence claim without those finiteness assumptions. ] 1. The direct minimax template is Sion/Fan, but only after a topology is chosen very carefully

Sion’s theorem is the canonical engine behind the paper’s finite proof: roughly, if one player’s set is compact convex, the other player’s set is convex, and the payoff is quasi-concave/quasi-convex with the relevant upper/lower semicontinuity, then (\sup\inf=\inf\sup). Sion explicitly highlights compactness and semicontinuity as the key hypotheses in the infinite-dimensional reduction. This is exactly the right abstract template for Robust Trust as well. The problem is not conceptual but topological: one needs a topology on adviser kernels (B) and agent strategies (\Sigma) under which these sets are compact/convex and the payoff (W(\beta,\sigma)) is separately semicontinuous. The project note is right that this is the point where cheap-talk-like endogeneity makes life hard. ([MSP][1]) the adjacent fixed-point theorem to keep in view. In modern language: if the strategy sets are compact in a convex Hausdorff topological vector-space setting and payoffs are continuous, then continuous games have equilibrium. It is often the cleanest route once strategies have been reformulated as probability measures or kernels. This matters here because several nearby papers first enlarge the strategy space to transition probabilities or distributional strategies and only then apply Glicksberg/Sion. ([RAND Corporation][2])Milgrom–Weber give a strong model for how to compactify incomplete-information strategy spaces

Milgrom and Weber’s 1985 paper is highly relevant as a template. They define a distributional strategy for player (i) as a probability measure on (T_i\times A_i) with the correct fixed type marginal, and they note the tight correspondence between behavioral strategies and regular conditional distributions. Under equicontinuous payoffs and absolutely continuous information, they prove that these strategy sets are compact convex metric spaces in the weak topology and that payoffs are continuous and linear, so Glicksberg yields equilibrium. That is a very close formal cousin of what one would like to do here with adviser and agent kernels. ([1.618034][3])lags from Milgrom–Weber matter for this project. First, their continuity assumptions are stronger than anything currently assumed in Robust Trust, especially the absolute-continuity condition on the information structure. Second, they give a simple bidding game with no Nash equilibrium and separately note an example where the information structure is not absolutely continuous. So the literature is already warning that “just move to infinite type spaces and hope for the best” is not a safe plan. ([1.618034][3]) also prove a denseness theorem: when a player’s type distribution is atomless, pure strategies are dense in distributional strategies, which yields nearby pure (\varepsilon)-equilibria once continuity is available. This is useful as purification background, but it is not enough for the exact Theorem 2 extension. It gives approximation, not exact saddle-point existence, and it does not solve the messagewise posterior-rationalizability requirement. ([1.618034][3])** As literature, Milgrom–Weber is very useful for the “reformulate strategies as measures with fixed marginals” move. As a direct theorem to apply, it looks too strong in the wrong places: it wants an absolute-continuity-style regularity that is not in the user assumptions.
**Needed assumption candidate, if one wants a direct Milgrom–Weber route:** an analogue of their absolute-continuity/equicontinuity package. ([1.618034][3])Balder is the closest retrieved analogue to the project’s target

Balder’s 1988 paper is the sharpest nearby result from the literature I retrieved. He works directly with behavioral strategies as transition probabilities, not merely with distributional strategies, and proves a two-player zero-sum saddle-point existence result. The crucial explicit hypothesis visible in the retrieved text is (C6): the joint type law must admit regular conditional probabilities with respect to each marginal, and Balder notes that a sufficient condition is that the type spaces are Suslin with Borel (\sigma)-fields. Under (C4), (C5), and (C6), Theorem 3.4 yields a saddle point in admissible behavioral strategies. The proof also establishes the right kind of weak upper/lower semicontinuity and affineness of the payoff in the two strategy arguments. ([ResearchGate][4]) for two reasons. First, Robust Trust is also a two-player zero-sum problem in behavioral kernels. Second, the current user assumptions already put (M\subseteq \Delta(\Omega)) and (\Theta) in compact metric spaces, hence standard Borel/Suslin territory, so the regular-conditional-probability side looks much less scary than it first appears. Balder even notes an alternative Ha-minimax route, but that would require stronger joint lower-semicontinuity and a more restrictive information assumption, so it looks less attractive here. ([ResearchGate][4])that Balder is still not plug-and-play. The retrieved lines do not reconstruct all of (C4) and (C5) in detail, and more importantly, Robust Trust has an endogenous posterior object (P_\beta(\cdot\mid m)) sitting in the definition of robust rationalizability. Balder gets you closest to a saddle point for the global payoff. It does not automatically solve the project-specific step from a global best response to messagewise Bayes-optimality at each (m). That step still looks novel here. ([ResearchGate][4])** This looks like the best off-the-shelf theorem family for the existence side.
**Difficulty.** High, but not hopeless. The literature suggests that the right language is weak convergence of transition probabilities plus Sion on an appropriately compactified strategy space.
**Needed lemma, not yet supplied by retrieval:** a bridge from “(\sigma^*) is a global best reply to (\beta^*)” to “for each message (m), (\hat\sigma_m^*) is Bayes-optimal for (P_{\beta^*}(\cdot\mid m)).”

### [LIT] 4. Strategic-measure topology gives the clearest warning about what can break

The stochastic-control/topology literature is directly relevant because the strategy spaces here are kernels. Saldi and Yüksel show a general existence theorem when the cost is lower semicontinuous in actions and the relevant strategic-measure set is compact under weak convergence. But they also prove the nasty part: conditional-independence constraints are generally **not** preserved under setwise or weak convergence. In their theorem, one can have (P_n(du_1\mid y,u_2)=P_n(du_1\mid y)) for every (n), yet this property can fail in the limit. They conclude that the relevant strategic-measure sets are in general not weakly closed. Under extra density/static-reduction conditions and compact actions, compactness can be restored. ([Yoksis Bilkent University][5])ect, that is a very serious warning. A naive proof that works directly on induced laws of ((s,m,\omega,\theta,a)) under weak convergence is likely to fail because the information structure is part of the object being optimized over. The literature strongly suggests working with a topology on kernels themselves, not just on induced joint laws. The same line of work points to Borkar/Young-style weak(^*) topologies on randomized policies as a natural candidate, precisely because they are designed to make policy spaces compact by Banach–Alaoglu. ([Yoksis Bilkent University][5])** This is more obstacle map than direct theorem, but it is probably the most important obstacle map in the survey.

### 5. What the literature suggests is genuinely new in Robust Trust

The most important project-specific issue is not simply “infinite-dimensional minimax.” It is the combination of:

1. a saddle point for the global payoff (W(\beta,\sigma)),
2. a posterior kernel (P_\beta(\cdot\mid m)) defined only as a regular conditional distribution, hence only unique almost surely, and
3. a definition of robust rationalizability that is messagewise. paper can infer messagewise optimality from global best response because every support point of (M) is genuinely on path with positive probability. Once (M) is infinite, that inference weakens: a saddle point typically gives only almost-everywhere optimality in the induced message distribution, not literal pointwise optimality at each message. In addition, the posterior (P_\beta(\cdot\mid m)) itself is only pinned down up to null sets. So even after saddle-point existence, one still needs a **version-and-patching lemma** to recover the exact robust-rationalizability conclusion. This is not something the retrieved literature settles.

That is why the existence problem seems to split into two subproblems:

* **Stage 1:** existence of a saddle point for the reduced zero-sum kernel game;
* **Stage 2:** measurable modification of the agent’s strategy and of the posterior version on message-null sets so that messagewise Bayes-optimality holds in the theorem’s sense.

The literature is strong on Stage 1, much weaker on Stage 2.

### 6. The most promising project-specific route suggested by the paper itself

Appendix A.1 of the paper may already contain the real escape hatch. The paper defines the compact convex set
[
W={w\in\mathbb R^{|\Omega|}: \exists \hat\sigma,; w(\omega)=\mathbb E_{\hat\sigma}[u(a,\omega,\theta)\mid \omega]},
]
and shows that conditional on adviser belief (s), a private strategy with payoff vector (w) yields payoff (s\cdot w). It also shows that one can replace non-Bayes-optimal private strategies by dominating Bayes-optimal ones. In other words, the infinite (\Theta)-side can be compressed to a finite-dimensional payoff set before doing minimax. ence problem as a zero-sum game between:

* the adviser kernel (\beta:M\to \Delta(M)), and
* a measurable selector (w(\cdot):M\to W),

with reduced payoff
[
\int_M \tau(ds)\Big[\alpha, s\cdot w(s)+(1-\alpha)\int_M s\cdot w(m),\beta(dm\mid s)\Big].
]

This formula is a project-side reduction, not a theorem from retrieval. But it is very attractive. It says that finiteness of (\Theta) is probably not the core obstruction once Appendix A.1 is used. The real obstruction becomes the kernel topology on (M) and the final conversion from a reduced saddle point back to a messagewise Bayes-rationalizable full strategy.

**Assessment.** This looks like the best proof route. It is not supplied by the literature alone, but the literature makes it plausible.

### [LIT] 7. Alternative proof approaches and difficulty

* **Balder-style behavioral-kernel minimax.**
  Best off-the-shelf route. Put a weak/stable/Borkar-type topology on (B) and on the reduced agent selectors, prove compactness and separate semicontinuity, then apply Sion/Balder.
  **Difficulty:** high.
  **Main crux:** the null-set/messagewise patching lemma. ([ResearchGate][4])strategy reformulation.**
  Conceptually elegant, and good for organizing the measurable-structure issues.
  **Difficulty:** high to very high.
  **Why:** direct application seems to want extra absolute-continuity-type assumptions not currently available. ([1.618034][3])ation without kernel topology.**
  Probably the wrong battlefield unless one proves closure of the exact information constraints first.
  **Difficulty:** very high.
  **Known failure:** conditional independence can disappear in the limit. ([Yoksis Bilkent University][5])ructured environments.**
  The paper already succeeds this way in the binary-state case and in the spherical example, by explicitly characterizing adversarial reports and solving balancing conditions.
  **Difficulty:** low to medium in symmetric/special cases, not a general existence theorem. ence machinery is **Balder (1988)**, not Milgrom–Weber. Milgrom–Weber is still very useful as a conceptual guide for enlarging the strategy spaces and for seeing exactly where equilibrium can fail. The most relevant negative result is the Saldi–Yüksel warning that information/conditional-independence constraints are not weakly closed in general. ([ResearchGate][4])ute is:

1. use the paper’s Appendix A.1 to compress the agent side to the finite-dimensional payoff set (W);
2. prove saddle-point existence for the reduced kernel game with a Balder/Borkar-style topology on kernels;
3. prove a new measurable version-and-patching lemma that upgrades almost-everywhere posterior optimality to the theorem’s messagewise robust-rationalizability statement.

The literature supports steps 1 and 2 in spirit. Step 3 is where the new work seems to live. No retrieved theorem by itself proves the full extension under only the current user assumptions.

[1]: https://msp.org/pjm/1958/8-1/pjm-v8-n1-p14-s.pdf "https://msp.org/pjm/1958/8-1/pjm-v8-n1-p14-s.pdf"
[2]: https://www.rand.org/pubs/papers/P193.html "https://www.rand.org/pubs/papers/P193.html"
[3]: https://1.618034.com/blog-data/pdfs/references/milgrom%2Bweber-mathematics-of-operations-research-1985A.pdf "https://1.618034.com/blog-data/pdfs/references/milgrom%2Bweber-mathematics-of-operations-research-1985A.pdf"
[4]: https://www.researchgate.net/publication/242930090_Generalized_Equilibrium_Results_for_Games_with_Incomplete_Information "https://www.researchgate.net/publication/242930090_Generalized_Equilibrium_Results_for_Games_with_Incomplete_Information"
[5]: https://yoksis.bilkent.edu.tr/pdf/files/16080.pdf "Geometry of information structures, strategic measures and associated stochastic control topologies"
