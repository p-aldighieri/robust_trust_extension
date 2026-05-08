
========
ROLE: user (id=a17f72a0-d5cb-4ac1-ab18-49b0ae6ce97d)
========
# Editor pass — exposition.pdf (Robust Trust Theorem 2 infinite-extension exposition)

You are the **Editor** for an academic exposition note (NOT a research
paper for a journal). The audience is **Piotr Dworczak** (one of the
paper's authors), and the document is a short technical exposition of
what was proved over the past two days.

The PDF is exposition.pdf (in durable sources). The TeX source is
exposition.tex (also tracked in the proof repo). It is 7 pages and
mathematically substantive.

## Your job

Edit for **clarity, professionalism, tidiness, and exposition voice**
— NOT for academic-paper-style rigor or peer-review depth. That comes
in a separate later pass.

Specifically:

1. **Voice and audience.** The note is addressed to Piotr — a
   collaborator who knows the paper inside out. Edit out anything that
   over-explains the paper's setup, or that reads as if writing for an
   external reader who doesn't know the model. Keep the directness
   appropriate for a "here is what we found" memo.

2. **Section flow.** Are the seven sections (Setting / Main Theorem /
   Strategy paragraph / Branch A / Branch B / Tightness / Open
   directions) in the right order? Do any transitions need work?

3. **Mathematical density.** The note is dense by design (this is a
   technical exposition for a sophisticated reader), but flag any
   passage that could be tightened without sacrificing precision.

4. **Notation consistency.** Are all symbols introduced before use?
   Are any conventions silently changing mid-document?

5. **Tone.** Is it appropriately direct without being either too casual
   or too formal? Are there any places where the prose drifts toward
   self-promotion or padding?

6. **Concrete fixes.** List specific edit suggestions with section/
   paragraph anchors, not just general comments. For each, propose the
   replacement text.

## What you should NOT do

- Do not propose mathematical changes (those belong to peer review).
- Do not rewrite from scratch.
- Do not propose additional sections.
- Do not push toward a journal-paper voice — this is a memo, not a
  submission.

## Output Format


markdown
## Overall Editorial Assessment

(One paragraph: voice, structure, density, suitability for the audience.)

## Section-Level Notes

### §1 Setting
(Specific edit suggestions with replacement text.)

### §2 Main Theorem
(...)

### §3 Strategy in one paragraph
(...)

### §4 Branch A
(...)

### §5 Branch B
(...)

### §6 Tightness
(...)

### §7 Open directions
(...)

## Cross-Cutting Issues

- Notation:
- Voice:
- Length:
- Anything else:

## Top 5 Highest-Priority Edits

1.
2.
3.
4.
5.

## Recommendation

(Accept-with-edits / Revise-and-recheck / Major rewrite needed.)


## Discipline

- Length budget: 1500–2500 words.
- Read the actual PDF (in durable sources) carefully before editing.
- Distinguish editorial polish from mathematical content. If you spot
  a math issue, flag it briefly but don't dwell on it (peer review
  comes next).

Show more

========
ROLE: assistant (id=9e4612ba-ca97-49b6-8f7f-64e4c3172ed4)
========
Overall Editorial Assessment

The note is structurally sound and mostly pitched at the right level for Piotr: it gives the theorem, the proof route, the Branch A / Branch B fork, the tightness discussion, and the remaining openings in the natural order. The main editorial problem is not substance but finish: unresolved cross-references (??, [?]), doubled labels (“Assumption A1 (A5-thick)”), and a few provenance/model-credit phrases make the document feel more like a proof-log digest than a polished collaborator memo. The density is appropriate for this audience, but several paragraphs can be tightened by replacing explanatory throat-clearing with direct “what we proved / what is still conditional” language. The seven-section flow works; the biggest needed pass is a tidiness pass plus a voice pass that strips out self-promotion and keeps the note in “Piotr, here is the state of the proof” mode. 

exposition

Section-Level Notes
§1 Setting

The section over-explains the model slightly, but not badly. Since Piotr knows the primitives, the first paragraph can be shortened and made more memo-like. Also, Σ and B are used before being explicitly named.

Replace the first paragraph after the heading with:

We use the notation of Robust Trust. Thus Ω is finite with full-support prior μ
0
	​

; s∈Δ(Ω) has state-conditional law π(⋅∣ω) and unconditional law τ=∑
ω
	​

μ
0
	​

(ω)π(⋅∣ω); M=supp(τ); θ∈Θ is drawn from f(⋅∣ω), independently of s conditional on ω; A is compact metric; and u(a,ω,θ) is bounded and continuous in a. Let Σ denote the agent’s measurable strategies and B the misaligned adviser’s measurable kernels β:M→Δ(M).

The final sentence “The question we attacked” is a touch too casual. Replace with:

The question addressed here is whether the existence direction of Theorem 2 can be extended when M and Θ are infinite.

§2 Main Theorem

This section is in the right place, but it needs the most cleanup. The double labels “Assumption A1 (A5-thick), A2 (A8c-attain), A3 (TRE-gen-Hall)” are needlessly noisy. Since the internal names matter, drop A1/A2/A3.

Replace the assumption headings with:

Assumption A5-thick (endogenous Lusin-thickness).
Assumption A8c-attain (rowwise argmin attainment).
Assumption TRE-gen-Hall (calibrated worst-message transport).

The paragraph “Three additional hypotheses are introduced; each is tight (§??)” has an unresolved reference and overstates before the tightness section has done the work. Replace with:

Three additional hypotheses enter the extension. Section 6 explains the obstruction attached to each one.

The theorem numbering is confusing because the note’s “Theorem 1” and “Theorem 2” compete with Robust Trust Theorems 1 and 2. Replace with unnumbered theorem blocks:

Theorem (Tier 1: optimal σ
∗
 and adversarial β
∗
). Under the standing hypotheses and Assumptions A5-thick and A8c-attain, there exist σ
∗
∈Σ and β
∗
∈B such that

U(σ
∗
)=U
∗
=
σ∈Σ
sup
	​

U(σ),U(β
∗
,σ
∗
)=
β∈B
inf
	​

U(β,σ
∗
)=U
∗
.

Replace “Under the hypotheses of Theorem ?? and Assumption TRE-gen-Hall” with:

Theorem (Tier 2: robust rationalizability). Under the Tier 1 hypotheses plus TRE-gen-Hall, the pair (σ
∗
,β
∗
) can be chosen so that, when α>0,

Also clarify that A3’s m
∗
 is the same selector as in A8c-attain. Add to the TRE-gen-Hall assumption:

Here m
∗
 is the selector from A8c-attain, now interpreted as the worst-message map.

§3 Strategy in one paragraph

The section does exactly what it should, but it runs a little long for “one paragraph” and has unresolved references. Also, “a Polish topology where Σ is compact” should be made consistent with §4, which calls the space compact Hausdorff locally convex after quotienting.

Replace the first paragraph with:

The proof follows Phil Reny’s two-stage route. First restrict the misaligned adviser to τ-dominated kernels β
φ
	​

(dm∣s)=φ(m∣s)τ(dm), with φ in the convex set F of jointly measurable normalized densities. On this restricted game, Balder’s constant-marginal continuity makes U
F
	​

(σ,φ):=U(β
φ
	​

,σ) continuous in σ under the Balder weak topology, and Σ is compact after the usual Balder quotient. Mertens’s asymmetric minmax theorem then gives a restricted-game maximizer σ
∗
. Second, A5-thick lets us use Lusin regularization to smooth any unrestricted β∈B into a τ-dominated φ
ε
	​

∈F with only ε-loss at σ
∗
. Hence the restricted maximizer also secures the unrestricted value.

The second paragraph is useful and should stay, but tighten the final two sentences:

Branch A gives value security, not a full saddle. Adversary attainment needs A8c-attain. Per-message Bayes-optimality needs TRE-gen-Hall, because Branch A plus attainment does not imply the upper saddle inequality that finite Sion gives in the paper.

§4 Branch A

The mathematical structure is good. The main edits are notation cleanup and reference cleanup.

In §4.1, “Working modulo 
G
ˉ
-a.e. equality” introduces 
G
ˉ
, which is not defined in this note. Replace with:

Working modulo λ-a.e. equality, i.e., in the Balder quotient, makes Σ a compact convex Hausdorff locally convex space.

Lemma 4’s “Q
ω
τ
	​

” and “λ
ω
τ
	​

” appear too abruptly. Either define them or avoid them. Replacement:

Common-kernel extraction proceeds by taking the finite mixture of the ω-indexed limit laws, disintegrating it on the standard Borel space X×A, and recovering the relevant ω-marginals by Radon–Nikodym multiplication. All density directions are from the dominated measure to the dominating mixture.

Lemma 5 is overly compressed. Replace the opening sentence with:

With Σ compact Hausdorff in T
λ
	​

, F convex, U
F
	​

 bounded, and σ↦U
F
	​

(σ,φ) continuous for each φ, Mertens’s Corollary B applies.

In Theorem 8, state equality rather than “≥U
∗
,” since the proof gives equality:

there exists σ
∗
∈Σ with

U(σ
∗
)=U
∗
=V
∗
,
β∈B
inf
	​

U(β,σ
∗
)=U
∗
.
§5 Branch B

This section is effective: it clearly identifies the saddle gap, which is the conceptual hinge of the memo. The main issue is that ℓ is introduced as ℓ
σ
∗
	​

 in §2 but later used as ℓ. Add at the start of §5.1:

In this section write ℓ=ℓ
σ
∗
	​

.

Lemma 10 refers to “Lemma ?? plus Lemma ??”; replace the sentence with:

The Branch A bottom-density conclusion gives inf
B
	​

U(⋅,σ
∗
)=inf
F
	​

U
F
	​

(σ
∗
,⋅), hence ∫adτ=∫edτ. Since a≤e, equality holds τ-a.e.

The saddle-gap paragraph is one of the strongest parts of the note. Keep it, but remove the long quote or make it less performative. Replace:

Phil’s email itself acknowledges this: “If correct, this establishes the existence of an optimal strategy for player 1, but not for player 2.”

with:

This is exactly the limitation Phil flagged: the Lusin lift gives the agent’s value-securing strategy, not the adversary side of a saddle.

In Lemma 12, replace “Under the hypotheses of Theorem ??” with:

Under the Tier 1 hypotheses plus TRE-gen-Hall,

§6 Tightness

This section is well placed after Branch B. The tone, however, occasionally drifts from “memo to Piotr” into proof-log rhetoric.

In §6.1, replace “refuting any version of support-thickness” with the slightly more precise:

so the support-thickness clause cannot hold on any full-measure compact core.

In §6.2, the row-obstruction paragraph contains a sentence that is mathematically slippery: “the integral is bounded below by the essential inf of g on the support, which is positive.” A probability on (0,1] can have essential inf 0, though the integral is still strictly positive. Replace that part with:

If the measure gives no mass to {0}, then it is supported on (0,1], where g(m)=m>0; hence ∫gdβ>0. If it gives positive mass to {0}, the atom contributes g(0)=1. Thus no probability measure attains the value 0.

The “literature confirms” sentence is too sweeping for an exposition memo. Replace with:

This is the standard attainment obstruction for non-l.s.c. rowwise objectives: without some rowwise argmin condition, exact Borel-kernel attainment is not available.

In §6.3, “no scalar monotone transport hides in the curtains” is memorable but too casual. Replace with:

there is no one-dimensional monotone transport that can absorb the vector imbalance.

§7 Open directions

The section is useful and concise. The first two directions are exactly the right ones. The Lean item is less central for Piotr unless he asked about formalization; keep it, but demote the language.

Replace item 3 with:

Formalization. A faithful formalization would need to encode the constructive Balder/Mertens/Lusin route rather than the earlier abstract saddle-point stub.

Also consider changing the heading from “Remaining genuinely-open directions” to:

Remaining directions

“Genuinely-open” sounds a bit defensive; the content already makes clear what remains unresolved.

Cross-Cutting Issues

Notation: Define Σ and B explicitly in §1. Replace the stray 
G
ˉ
 in §4.1 with λ. Add “write ℓ=ℓ
σ
∗
	​

” in §5.1. Clarify that the m
∗
 in TRE-gen-Hall is the same selector introduced in A8c-attain.

Voice: Remove “orchestrated with Claude Opus” from the title block and strip model-credit language from Provenance. For Piotr, the useful provenance is “proof logs are in packets/ and logs/,” not which model reviewed which lemma.

Length: The note is short enough. Do not cut sections. The best compression target is §2’s theorem/assumption block and §3’s strategy paragraph.

References and cross-references: All ?? and [?] must be fixed before sending. This is the highest tidiness issue. The PDF currently has unresolved references in §2, §3, §4, §5, and §6.

Tone of tightness claims: “Tight” is fine if the proof repo supports it, but §6.2 currently hedges that the Robust-Trust-compliant primitive realization is delicate. Either soften the abstract’s “All three added hypotheses are tight” or make §6.2’s statement cleaner.

Top 5 Highest-Priority Edits

Resolve every ?? and [?]; currently the document looks unfinished despite being substantively polished.

Rename the note’s theorem blocks as “Theorem (Tier 1)” and “Theorem (Tier 2)” to avoid collision with Robust Trust Theorems 1 and 2.

Remove or compress the AI/provenance self-credit language: title-block “orchestrated with Claude Opus” and “independent passes of GPT-5 Pro” should go.

Fix notation slips: define Σ,B, replace 
G
ˉ
-a.e. with λ-a.e., and identify m
∗
 consistently.

Tighten §3 and §5.2 so the main message is unmistakable: Branch A proves value security; A8c-attain gives adversary attainment; TRE-gen-Hall substitutes for the missing upper saddle.

Recommendation

Accept-with-edits. The exposition is already in the right order and at the right mathematical level for Piotr. It needs a cleanup pass, not a rewrite: fix references, smooth notation, remove proof-log/provenance noise, and sharpen the Tier 1 / Tier 2 distinction.
