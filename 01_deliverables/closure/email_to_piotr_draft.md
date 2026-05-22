# Draft email to Piotr

*Save and paste into Gmail in HTML mode. The table is inline HTML so
it renders as a real table. The Claude block is offset with a
blockquote-style indent.*

---

Subject: Robust Trust Theorem 2 infinite extension — v9 results

Hi Piotr,

Quick update on the Theorem 2 infinite-extension project. I've been running this with Claude (Anthropic's assistant) orchestrating a pipeline of ChatGPT Extended Pro passes — formalizer, literature, searcher, breakdown, prover, reviewer, gatekeeper, and several rounds of verification. The headline is that **your suggestion to reformulate the agent's choice as a compact subset of the weak Pareto frontier W^P was the unlock**. Without it we'd still be stuck on the same message-space Hall duality that blocked v8 last quarter. The reformulation let us apply Clarke–Danskin stationarity to the finite-menu value functional, which produces calibration as a Lagrange multiplier rather than as an external Hall assumption. That mechanism is the technical core of all five theorems below.

I'm going to let Claude present the technical summary directly, since they ran the verification block and have the cleanest read on where we landed:

<blockquote style="border-left: 3px solid #ccc; padding-left: 12px; margin-left: 0;">

Hi Piotr, here's where we landed.

**Honest framing first**: this is **not** an unconditional proof of Theorem 2 under your paper's standing hypotheses alone. We ran a six-pass verification block before sending (general reviewer, objective conformance, gatekeeper, three math sanity-check chunks); both the objective-conformance pass and the gatekeeper independently returned **OBJECTIVE_NARROWED**. The proof requires meaningful primitive conditions beyond standing in every case other than the degenerate α = 0 corner. The substantive regime is α ∈ (0,1) and that's what all the results below address.

What you should take away: the deletion-compatible Hall duality the v8 closure memo flagged as the single most consequential open question is now **characterized** as a biconditional (Theorem 2 holds iff a cone-Hall dual inequality Ψ(y) ≤ 0 holds for every bounded Borel y), with several primitive sufficient classes that imply it, and an **explicit dual certificate** showing the WTA ternary witness fails it (Ψ = 2/9 > 0 under uniform τ, α = 1/2). The previous v8 framing — "Tier 2 conditional on menu-Hall" — has been replaced by "Theorem 2 either holds unconditionally in one of several primitive classes, or you check Ψ(y) ≤ 0 directly." That's the contribution.

<table style="border-collapse: collapse; border: 1px solid #888; font-size: 13px;">
  <thead>
    <tr style="background: #f0f0f0;">
      <th style="border: 1px solid #888; padding: 6px 10px; text-align: left;">Theorem / class</th>
      <th style="border: 1px solid #888; padding: 6px 10px; text-align: left;">α coverage</th>
      <th style="border: 1px solid #888; padding: 6px 10px; text-align: left;">Hypotheses beyond standing</th>
      <th style="border: 1px solid #888; padding: 6px 10px; text-align: left;">Status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">T1: finite-menu Pareto-Hall (Clarke–Danskin)</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">α ∈ [0,1]</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><em>None</em> (in payoff-label coordinates)</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Unconditional</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">T2: α=0 singleton strategy</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>α = 0 only (degenerate)</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">None</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Unconditional; not substantive</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">Binary capstone (|Ω| = 2)</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>α ∈ (0,1)</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Endpoint exposure, tie discipline (or tie-splitting), interior endpoint stationarity</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Unconditional for any measurable M, Θ</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">FBNF capstone (|Ω| ≥ 3, foliated)</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>α ∈ (0,1)</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Affine 1-d foliation of Δ(Ω); fiber-preserving TRS; fiber endpoint exposure / tie discipline; <strong>cross-fiber dominance</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Unconditional. Covers spherical, affine MLR, polyhedral-scalarizable</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">G3 cone-Hall biconditional (|Ω| ≥ 3, general)</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>α ∈ (0,1)</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Closed-graph rowwise minimizer + continuous Bayes-cone support function (the regularity package)</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Theorem 2 ⟺ Ψ(y) ≤ 0 (checkable)</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">P2* primitive class</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>α ∈ (0,1)</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Smooth strict-concave utility + atomless τ + <strong>uniform cone-margin η &gt; 0</strong> at active labels + sufficient aligned baseline</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Implies Ψ ≤ 0; unconditional</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">P3 / G4 polyhedral LP</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>α ∈ (0,1)</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Polyhedral W with finite active vertices + cone-margin</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Theorem 2 iff finite LP is feasible (explicit)</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">P4 radial / antipodal</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>α ∈ (0,1)</strong></td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Radial / antipodal τ-symmetry + equivariant u</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">Unconditional. Covers paper's spherical example</td>
    </tr>
    <tr>
      <td style="border: 1px solid #888; padding: 6px 10px;">WTA ternary failure</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">α = 1/2 (illustrative)</td>
      <td style="border: 1px solid #888; padding: 6px 10px;">τ uniform on Δ({0,1,2}); no aligned baseline</td>
      <td style="border: 1px solid #888; padding: 6px 10px;"><strong>Theorem 2 FAILS</strong> by explicit dual cert Ψ = 2/9; reopens once aligned baseline D ≥ 2(1−α)/(9α)</td>
    </tr>
  </tbody>
</table>

**Technique in two paragraphs.** The Pareto-frontier reformulation collapses the agent's strategy space from infinite-dimensional message-action kernels to compact subsets of W^P. At any finite-menu Pareto-completed ambient local maximizer C* = {w_1, ..., w_k}, the value functional F_k(w_1, ..., w_k) = ∫[α max_i s·w_i + (1−α) min_i s·w_i] τ(ds) has a Clarke subdifferential representable via measurable active-face weights λ_i^+(s), λ_i^-(s). Clarke's Fermat rule forces the subgradient components g_i to lie in the normal cones N_W(w_i); since N_W is a cone closed under positive rescaling, the normalized vectors p_i = g_i / q_i lie in B_W(w_i) ∩ Δ(Ω) — i.e., in the Bayes cone. The calibration emerges as a Lagrange multiplier rather than being assumed. Lifting from payoff labels back to original messages then becomes either a scalar transport (binary case, B1 lemma) or a fiberwise scalar transport with measurable pasting (FBNF case).

At the infinite-M level, the **cone-Hall biconditional** (Theorem G3) converts the existence question into a checkable inequality on a function space. Strong LP duality on compact M gives Theorem 2 ⟺ Ψ(y) ≤ 0 for every bounded Borel y, where Ψ is the aligned-baseline minus misaligned-rowwise-min cone-functional spelled out in the paper. The WTA ternary witness fails this with the simplest possible dual price y_j = 1 − 2e_j: support function h_{B_j}(y_j) = 1/3, expected rowwise minimum 𝔼[s_j | s ∈ K_j^-] = 1/9, and the integration yields Ψ = (1−α) · 4/9 = 2/9 > 0 at α = 1/2. Adding aligned-baseline mass D at the right messages flips the certificate to Ψ ≤ 0 exactly when D ≥ 2(1−α)/(9α) — a concrete threshold on a primitive quantity. All three avoidance-of-WTA stories (P2*, P3, P4) are different primitive ways of ensuring this threshold is automatically met.

**Strongest assumptions we added.** Three are doing real work and worth flagging:

1. **Cross-fiber dominance (FBNF-7)** — the condition that interior arc messages never beat in-fiber endpoint minimums across the foliation. Spherical and MLR satisfy it; WTA ternary fails it. This is the strongest structural condition in FBNF.
2. **Cone-margin η > 0** (uniform or variable) — the Bayes cone at each active payoff label has positive "width" in a precise sense. Smooth strict-concave utility + atomless τ + non-degenerate information value imply it generically; without it, the LP threshold can become arbitrarily tight.
3. **Regularity package (Reg-1, Reg-2)** — closed-graph rowwise minimizer + continuous Bayes-cone support function. Phase (b) of the project showed these are NOT automatic from compactness of M alone, but they ARE automatic under "globally continuous Bayes-optimal selection" — which is generic in smooth-utility models.

The remaining open case is the totally unstructured |Ω| ≥ 3 without regularity, without a primitive class, and without a verified Ψ(y) ≤ 0 certificate. We don't have an unconditional proof there, but we have shown that the question is ill-posed without some structure — WTA explicitly fails — so the gap is real, not just a missing argument.

</blockquote>

That's the math. A few notes from my side:

- **Lean formalization** is underway. It's substantial — the binary capstone alone has six lemmas, FBNF has around ten, and the cone-Hall biconditional is technically deep (LP duality + Aumann integral closedness + measurable selection on the rowwise-minimizer correspondence). I'm working through it but expect it to take a few weeks.
- I've attached three documents: the 2-page executive summary, the 14-page short-form exposition, and the 19-page paper-shaped LaTeX. The detailed 28k-character consolidated memo is also in the repo if you want depth on any specific proof.
- The verification block flagged six PATCH_SMALL issues during a fresh-chat audit pass — RN orientation, R-notation clash, threshold normalization, endpoint-fiber wording, FBNF-1 phrasing, and a few scope guards. All patched. But fresh eyes always catch more, so if anything looks weird, please push back — last time you correctly flagged the τ-AC restriction issue in the Phil Reny route, and that saved us a lot of wasted effort.

Best,
Pedro
