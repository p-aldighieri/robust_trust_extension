
========
ROLE: user (id=706098c6-543d-4283-a72c-380f137d60c4)
========
# Peer reviewer pass — exposition_v2.pdf (Robust Trust Theorem 2 infinite-extension exposition)

You are the **Peer Reviewer** for an academic exposition note.
The document is exposition_v2.pdf (in durable sources). It is a
short technical exposition addressed to **Piotr Dworczak** describing
a two-tier conditional infinite-dimensional extension of Theorem 2
of Dworczak \& Smolin (2026), \emph{Robust Trust}.

The editor pass has already been run and incorporated. This pass is
**substantive peer review** — focused on mathematical correctness,
completeness of the argument, citation accuracy, scope, and whether
the document would survive scrutiny from someone who knows the paper
and the relevant literature (Phil Reny, Balder transition kernels,
Mertens minmax, optimal transport).

## Your job

Audit the document on the following dimensions:

1. **Mathematical correctness.** Are the displayed theorem statements,
   lemma sketches, and proof outlines correct? Are the assumptions
   tight as claimed? In particular:
   - Does Branch A genuinely close under standing + (A5-thick) alone?
   - Does the rowwise-argmin selector $m^*$ (A8c-attain) genuinely
     deliver $\beta^* = \delta_{m^*(s)}$ adversarial against $\sigma^*$?
   - Does TRE-gen-Hall (the calibrated transport) genuinely deliver
     per-message Bayes-optimality? Is the support-function form
     equivalent to the disintegration form as claimed?
   - Are the L9 saddle-gap and the upper-saddle obstruction described
     correctly?

2. **Tightness of the three added hypotheses.** §6 claims (A5-thick),
   (A8c-attain), and (TRE-gen-Hall) are each tight, with explicit
   obstruction witnesses. Audit each:
   - Perfect-revelation counterexample for (A5-thick).
   - Upward-spike row $g(0)=1, g(m)=m$ for (A8c-attain). Note: §6.2's
     row-level argument is correct as a row-level abstract obstruction,
     but the document does NOT certify a Robust-Trust-compliant
     primitive realization — verify this is honestly stated.
   - Concrete ternary non-radial Hall-violation $E=\{t_0\}$,
     $\phi(\mu)=\mu_1-\mu_0$, LHS $= (1-\alpha)/9 > 0$ vs RHS $= 0$
     for (TRE-gen-Hall). Verify the arithmetic and the geometric
     interpretation.

3. **Citation accuracy.** Verify the references:
   - Dworczak \& Smolin (2026): Theorem 1 in Section 3.2 with proof in
     Appendix A.1; Theorem 2 in Section 3.3 with finite proof in
     Appendix A.2; Section 4 binary state; Section 5.2 spherical;
     Appendix A.6 binary quantile transport; Appendix A.10 radial
     Bregman.
   - Balder (1988): Theorem 2.2, p. 268 (constant-marginal continuity);
     Theorem 2.3(a) (compactness of transition kernels into compact
     metric).
   - Mertens (1986): Section 2 Corollary B, p. 238 (asymmetric minmax).
   - Aliprantis-Border (2006): Theorems 18.13 (KRN) and 18.19
     (measurable maximum).
   - Bogachev (2007), Villani (2008) — appropriately cited.

4. **Scope and completeness.** Does the document make any claim it
   doesn't substantiate? Is anything important omitted? Does the
   honest distinction between "abstract row-level negative" and
   "RT-compliant counterexample uncertified" come through clearly for
   (A8c-attain)?

5. **Notational and stylistic issues** that the editor may have
   missed.

## What you should NOT do

- Do not propose new theorems or prove anything yourself.
- Do not propose major restructuring (the editor pass handled
  structure).
- Do not mark the document down for being non-publishable in a
  journal — it's an exposition for a collaborator, not a journal
  submission.

## Output Format


markdown
## Overall Peer-Reviewer Assessment

(One paragraph: would you sign your name under this exposition? What
are the substantive concerns, if any?)

## Mathematical correctness

- Tier 1 theorem: ...
- Tier 2 theorem: ...
- Branch A capstone: ...
- L9 saddle gap: ...
- Each lemma sketch:

## Tightness of added hypotheses

- (A5-thick) tightness: ...
- (A8c-attain) tightness: ... (especially the row-level vs
  RT-compliance distinction)
- (TRE-gen-Hall) tightness: ... (especially the Hall arithmetic)

## Citation accuracy

(Table or per-reference verdict.)

## Scope and completeness

- Claims that need substantiation:
- Missing items:
- Honesty of conditional framing:

## Notational/stylistic

- ...

## Verdict

ACCEPT / ACCEPT-WITH-MINOR-PATCHES / MAJOR-REVISION-NEEDED.

## Top 3 must-fix items (if any)

1.
2.
3.


## Discipline

- Read the actual PDF carefully.
- Length budget: 1500–2500 words.
- Cite specific page/section locations where possible.
- Be honest. This is a peer review, not a rubber stamp.

Show more

========
ROLE: assistant (id=0d14112b-00a5-428d-b8f6-23bcd65389b9)
========
Overall Peer-Reviewer Assessment

I would sign my name under the exposition after minor patches. The mathematical architecture is honest and mostly correct: Branch A really is a value-securing theorem under standing assumptions plus (A5-thick); Tier 1 really gets adversary attainment from (A8c-attain); and Tier 2 correctly identifies that per-message Bayes-optimality is not a free saddle-point consequence but must be supplied by posterior calibration via (TRE-gen-Hall). The main concern is not a hidden mathematical collapse, but overstatement around “tightness”. The A8c obstruction is explicitly admitted to be row-level rather than certified as a full Robust-Trust-compliant primitive counterexample, and A5-thick’s perfect-revelation example shows failure of the Lusin-thickness mechanism, not failure of Theorem 2 itself. Those nuances should be pulled forward into the abstract and §6, so the note does not sound stronger than its evidence. The exposition’s own description of the theorem as “two-tier conditional” is the right frame. 

exposition_v2

Mathematical correctness

Tier 1 theorem: Correct as a conditional statement. Under (A5-thick), the restricted-game maximizer secures the unrestricted value; under (A8c-attain), the rowwise selector gives an exact adversarial $\beta^$. The proof chain on pp. 3-4 is mathematically coherent: $V^\ge U^$ because $F\hookrightarrow B$, and L6 gives $\inf_B U(\cdot,\sigma^)\ge V^*$, hence equality. The only patch is definitional: (A5-thick) is endogenous to the selected Branch-A maximizer, so the theorem should say “there exists a restricted-game maximizer satisfying (A5-thick)” or “assume the chosen Branch-A maximizer admits such a representative.” Otherwise the hypothesis reads slightly circular.

Tier 2 theorem: Correct, but nearly tautological in its current form. TRE-gen-Hall assumes the calibrated posterior lies in $C(m)$, and $C(m)$ is defined as the set of beliefs at which $\hat\sigma^*(m)$ is Bayes-optimal. So L10 does deliver per-message Bayes-optimality, but because the condition is doing the heavy lifting. That is fine, and the exposition says so on p. 5. 

exposition_v2

Branch A capstone: Yes, Branch A genuinely closes under standing + (A5-thick) alone. The Balder/Mertens restricted game and the Lusin smoothing lift are enough for value security. However, the Lemma 5 sketch on p. 3 omits one operational detail that appears in the proof record: how messages outside $K^$ are handled after modifying $\sigma^$ off $K^$. Since arbitrary $\beta$ can send off-core messages, the sketch should explicitly include the fixed $m_0\in K^$ replacement or smoothing rule for $y\notin K^*$.

Rowwise-argmin selector: Yes. Given A8c-attain, $m^(s)\in\arg\min_m\ell_{\sigma^}(m,s)$ $\tau$-a.e. and measurable, $\beta^(dm\mid s)=\delta_{m^(s)}(dm)$ is adversarial against $\sigma^*$. Lemma 7 plus Lemma 8 identify the integrated value with the rowwise essential infimum, and A8c-attain supplies exact pointwise minimizers. The direction of inequality is right: this is lower-saddle/adversary attainment only, not an upper saddle.

TRE-gen-Hall and support-function equivalence: The disintegration form and support-function form are equivalent, provided $C(m)$ is treated as a measurable closed convex correspondence and a countable separating family of affine tests is invoked. The exposition states the equivalence on p. 2, but should add one sentence explaining that finite-dimensional separation plus a countable dense family of affine functionals converts the integrated inequalities over all measurable $E$ into pointwise membership $P_{\gamma_\alpha}(\cdot\mid m)\in C(m)$ $q$-a.e. Without that sentence, a careful reader may wonder where the “for every $E$” condition becomes pointwise.

L9 saddle gap: Correct and important. The exposition accurately says Branch A + Lemma 9 give only $U(\beta^,\sigma^)=\inf_\beta U(\beta,\sigma^)=U^$ and do not imply $U(\beta^,\sigma)\le U(\beta^,\sigma^*)$ for all $\sigma$. This matches the paper’s finite proof, where Sion provides a full saddle under finite $M,\Theta$, and also matches Phil Reny’s warning that the sketch gives player-1 optimality but not player-2 existence or per-message rationalization. 

Robust_trust_Dworczak_Smolin

Each lemma sketch: L1-L4 are sound as sketches. L1 should mention the RN transfer from $T_\lambda$ to the $\pi_\omega\otimes f_\omega$ and $\tau\otimes f_\omega$ bases; L2’s common-kernel extraction is terse but correct; L3’s Mertens use is correctly asymmetric; L5 is assumed rather than proven; L6 needs the off-$K^*$ detail noted above; L7-L9 are correct conditional reductions.

Tightness of added hypotheses

(A5-thick) tightness: The perfect-revelation example is a valid witness that A5-thick is not implied by the standing hypotheses: any full-measure core must contain both $\delta_0,\delta_1$, and the relative open singleton has zero mass under the other state’s posterior law. But the exposition should not imply this refutes existence of a robustly rationalizable strategy, since finite perfect revelation is covered by the original finite Theorem 2. It is a tightness witness for the Lusin smoothing mechanism, not a full counterexample to the conclusion.

(A8c-attain) tightness: The row-level argument is correct. For $g(0)=1$, $g(m)=m$ on $(0,1]$, $\inf g=\operatorname{essinf}g=0$ but no probability measure attains value $0$. The exposition honestly states that an RT-compliant primitive realization “is more delicate to certify,” which is good. But the abstract and §6 opening say all three hypotheses are “tight” and “rule out removal in general.” For A8c, that should be softened to: “row-level obstruction; no RT-compliant primitive counterexample is certified here.” 

exposition_v2

(TRE-gen-Hall) tightness: The geometric interpretation is right: in binary state, calibration is scalar and quantile transport suffices; in dimension at least two, a collapsed fiber can have a barycenter pointing outside the Bayes cone. The displayed Hall arithmetic, LHS $=(1-\alpha)/9>0$ and RHS $=0$, is plausible but not independently checkable from the PDF because $t_0$, $\tau$, and the collapsing fiber are not specified. “See Q2 prover log” is too thin for a stand-alone exposition to Piotr. Add the coordinates or demote the statement to a logged witness summary. 

exposition_v2

Citation accuracy
Reference	Verdict
Dworczak & Smolin (2026)	Correct. Theorem 1 is in §3.2 with proof in Appendix A.1; Definition 2 and Theorem 2 are in §3.3, and Theorem 2 explicitly assumes finite $M,\Theta$ for existence and points to Appendix A.2. The paper itself flags Sion continuity difficulties in infinite cheap-talk-like spaces. 

Robust_trust_Dworczak_Smolin


D&S Section 4, Section 5.2, Appendix A.6, Appendix A.10	Correct. Section 4 is binary state; §5.2 is rich private strategies and the spherical example; Appendix A.6 contains the binary quantile transport construction; Appendix A.10 contains Lemma 9 on radial/spherical Bregman monotonicity. 

Robust_trust_Dworczak_Smolin

 

Robust_trust_Dworczak_Smolin


Balder (1988)	Correct in substance: L1’s citation to Theorem 2.2 p. 268 and L2’s use of Theorem 2.3(a) align with the proof record. Bibliographic details match the article listing. 

phil_reny_route_memo

 
CiNii

Mertens (1986)	Correct per the durable Phil/Reny source: §2 Corollary B, p. 238, is exactly the asymmetric minmax result needed. The exposition cites it accurately on p. 3. 

phil_reny_bundle


Aliprantis-Border (2006)	Correct: Theorem 18.13 for Kuratowski-Ryll-Nardzewski and Theorem 18.19 for measurable maximum. The extra reference to Theorem 15.11 in the bibliography is harmless. 
EconTheory
 
Springer

Bogachev, Villani	Appropriate but generic. Bogachev for Polish-valued Lusin and disintegration is fine; Villani for Hall/Strassen feasibility is acceptable background, though no precise theorem is cited.
Scope and completeness

Claims that need substantiation: The ternary Hall witness needs enough data to reproduce $(1-\alpha)/9$ and $0$. The “all three hypotheses are tight” sentence needs qualification, especially for A8c and A5-thick.

Missing items: Lemma 5 should include the off-$K^*$ smoothing/retraction case. TRE-gen-Hall’s support-function equivalence should mention measurability and countable separation. A5-thick’s endogenous nature should be stated more cleanly in the theorem.

Honesty of conditional framing: Strong overall. The note is unusually clear that Branch A is value security, that Tier 1 is not robust rationalizability, and that the upper saddle obstruction is real. The one plume of overstatement is “tightness” language in the abstract and §6.

Notational/stylistic

Replace “Under the hypotheses of Theorem ??” in Lemma 10.

Avoid writing both $U(\sigma)$ and $U(\beta,\sigma)$ without a reminder of the overload.

In §2, clarify that TRE-gen-Hall assumes convex $T$, which is stronger than Dworczak-Smolin Theorem 1’s connected trust region conclusion.

The proof sketches are appropriately compressed, but the “Q2 prover log” reference is too repository-local for a collaborator-facing note.

Page 1’s theorem statement is good, but the abstract should say “tight for the proof route / row-level or structural obstruction” rather than unqualified “rule out removal.”

Verdict

ACCEPT-WITH-MINOR-PATCHES.

Top 3 must-fix items

Qualify the “tightness” claim: A8c is only certified by a row-level obstruction, and A5-thick is a Lusin-mechanism obstruction, not a counterexample to finite Theorem 2.

Add the missing off-$K^*$ case in Lemma 5’s smoothing construction and clarify A5-thick as an endogenous condition on the selected restricted-game maximizer.

Fix “Theorem ??” and include enough coordinates/details for the ternary Hall witness to verify LHS $=(1-\alpha)/9$ and RHS $=0$ without opening private logs.
