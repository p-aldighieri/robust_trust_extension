# Peer reviewer pass — `exposition_v2.pdf` (Robust Trust Theorem 2 infinite-extension exposition)

You are the **Peer Reviewer** for an academic exposition note.
The document is `exposition_v2.pdf` (in durable sources). It is a
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

```markdown
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
```

## Discipline

- Read the actual PDF carefully.
- Length budget: 1500–2500 words.
- Cite specific page/section locations where possible.
- Be honest. This is a peer review, not a rubber stamp.
