According to a document from 2026-05-22, I cannot complete the requested line-cited final sweep of v9_appendix.lean because the actual target file was not available in the uploaded workspace or in the project sources I could access. I therefore cannot honestly certify the final Lean surface, and I cannot cite line numbers in v9_appendix.lean.

The accessible project documents describe the v9 source-proof package and intended Lean scope, but they are source/proof/decomposition memos, not the final v9_appendix.lean file. The source proof pointer identifies the authoritative memo/LaTeX sources and formalization scope, not a compiled final Lean appendix. 

source_proof

 The Lean state document also says the v9 work was in “scaffolding,” with the theorem ledger still to be populated after decomposition. 

lean_state

OVERALL verdict

Clean: NO, not certifiable from available sources.
This is not a substantive finding that v9_appendix.lean is dirty. It is a blocker finding: the requested file was not available for inspection.

Cert-verifier eliminated: NOT VERIFIED, therefore NO for merge-gating.
The surrounding docs show that cert-verifier patterns were explicitly found in the earlier decomposition and then patched in a later refinement memo, but I cannot verify that the patch landed in v9_appendix.lean.

All axioms paper-cited: NOT VERIFIED.
The source-proof brief requires each new Inventory axiom to have a precise Lean statement, citation, and Mathlib-coverage justification. 

source_proof

 The patch memo provides better concrete versions for several axioms, but without the final Lean file I cannot confirm the final axiom inventory or docstrings.

Honest sorry count + scope: UNKNOWN for v9_appendix.lean.
The decomposition and patch memos contain sorry placeholders, but those are not the final Lean appendix.

Severity: HIGH, procedural merge blocker.
No ghost file, no ghost verdict. The audit cannot be line-certified.

Mergeable as a v9 ledger with documented external dependencies: NO.
Not until v9_appendix.lean itself is supplied or made accessible, followed by grep/line audit and theorem-body inspection.

A. Axiom inventory

Status: blocked. I cannot list ^axiom, ^opaque, or ^constant entries inside namespace Inventory.V9 because I could not inspect v9_appendix.lean.

What the surrounding documents say:

The v9 scope expects reused v8 Inventory stubs plus new v9 external dependencies, including Clarke-Danskin, Strassen, Farkas/conic LP, Hausdorff-Alexandroff, and Clarke-Fermat style results. 

source_proof

 The initial decomposition used an Inventory namespace, not necessarily Inventory.V9, and included broad axiom scaffolding. The decomposition review flagged those old versions as too abstract: ConicFarkasInstance, StrassenMarginalDominance, and ClarkeDanskinHyp had arbitrary Prop fields and were described as theorem-shaped trapdoors. 

decomposition_review_response

A later refinement memo patched this by making the Inventory assumptions concrete and cited, for example Clarke 1990 for Clarke-Danskin/Clarke-Fermat and Strassen 1965 for marginal couplings. 

decomposition_review_response

 It also removed the proposed BergeMaximumHyp / berge_maximum_set_valued axiom as unnecessary and too vague. 

source_proof

Audit classification: not inspectable in final Lean. The available memo evidence is encouraging after the patch, but not enough to certify.

B. Cert-verifier / projection sweep

Status: blocked. I cannot classify the actual theorem bodies in v9_appendix.lean.

The pre-patch decomposition definitely had CERTIFICATE_VERIFIER-shaped issues. The review explicitly says several structures carried proof obligations or conclusions as bare fields, including capstoneConclusion, calibratedKernelExists, and robustRationalizableLabeling; it also says some corollaries were vacuous, for example assuming hF4 : pkg.capstoneConclusion and returning it. 

decomposition_review_response

The later patch memo says those conclusion-as-field structures must be removed and theorem conclusions must state the target directly. It introduces HasRobustRationalizableStrategy as a target proposition rather than a data-field conclusion. 

source_proof

Requested theorem-by-theorem body classification: unavailable. I cannot honestly mark T1, T2, Binary, FBNF, Hall, WTA, G4, P2/P3/P4, or addenda as REAL_DERIVATION/HONEST_SORRY/SMUGGLED_CERTIFICATE without the final source lines. The pre-patch decomposition is not the final file; the patch memo is not proof that the final file is clean.

C. Hypothesis structure sweep

Status: blocked for final Lean.

What can be said from surrounding docs:

The refinement memo shows the intended patched design: BinaryCapstoneData no longer has a capstoneConclusion field, and its fields are framed as hypotheses or intermediate lemmas such as endpoint exposure, tie discipline, endpoint fiber lift, TRS interval reduction, projected image, interior calibration, and endpoint balance. 

source_proof

 The same patch treats FBNF fields as structural hypotheses, including Borel chart/quotient consistency, endpoint-supported image, two-sided perturbability, and global fiber dominance. 

decomposition

But several fields remain bare Prop in the patch memo. Some of those are honest high-level hypotheses, but only the actual final Lean file can show whether any remaining Prop field is conclusion-shaped or merely a named assumption.

Audit classification: not certifiable. No final structure definitions, no line-cited pass.

D. sorry count + scope

Status: unknown for v9_appendix.lean.

The accessible non-final decomposition contains many sorry placeholders. For example, the decomposition’s theorem surfaces use sorry in Hall and binary capstone statements. 

decomposition

 The later patch memo also still contains sorry placeholders inside instantiation lemmas, which is fine for a patch plan but not for a mergeable final appendix. 

decomposition_review_response

Final v9_appendix.lean sorry count: not available.

E. Other smuggling

Status: blocked. I cannot inspect Classical.choice, noncomputable section, tactic suppressions, haveI, local instance fabrication, hidden exact?, broad first | exact, or projection bodies in the final file.

One extra caution: the v9 docs themselves emphasize that this is a conditional/classification package, not an unrestricted standing-assumptions proof of Theorem 2. 

v9_consolidated

 Any final Lean headline theorem that silently states unrestricted existence would be scope smuggling, even if no certificate field is present.

Final gate

Clean: NO, not auditable.
Cert-verifier eliminated: NOT VERIFIED.
All axioms paper-cited: NOT VERIFIED.
Honest sorry count + scope: UNKNOWN.
Severity: HIGH.
Mergeable: NO.

The next audit needs the actual v9_appendix.lean blob. Once that file is available, the sweep should be mechanical: grep ^axiom, ^opaque, ^constant, grep sorry, inspect every structure field whose type mentions HasRobustRationalizableStrategy or theorem-conclusion aliases, and grep theorem bodies for exact .*\\. projection patterns.