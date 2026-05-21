# Math sanity-check chunk 2 — FBNF capstone

## Role

Fresh-chat independent broad math review. Read `consolidator_01_response.md`
(durable source) and check the **FBNF capstone** for soundness.

This covers:
- FBNF primitive class (FBNF-1...5 + FBNF-7; FBNF-6 derived).
- F1 (Conditional B1 + measurable pasting) under endpoint-fiber support.
- F2 (Endpoint-only fiber image) under primitive P.
- F3 (Localized stationarity → fiberwise total balance) via v9 T1.
- F4 (FBNF capstone assembly).
- Coverage corollaries: spherical/radial, affine MLR, polyhedral with
  scalarizable faces.

## What to check

- **Foliation structure**: FBNF-1's affine 1-d foliation. Is the
  Borel disintegration well-defined?
- **Cross-fiber claim**: FBNF-7 global fiber dominance — is the
  precise statement correct? Does it cover all fibers, not just one
  representative?
- **F1 patched form**: the kernel maps into endpoint FIBER, not
  singleton — verify all five lemma steps use this.
- **F3 derivation of FBNF-6**: localized two-sided perturbations +
  v9 T1 Clarke-Danskin Fermat. Are the boundary KKT cases handled?
- **Compatibility with v8 sharpness**: WTA ternary has |Ω|=3 + vertex
  W^P, which the consolidator says fails FBNF-1 (no 1-d foliation).
  Verify.

## Output

- Soundness verdict (SOUND / MINOR_FIXES_NEEDED / SUBSTANTIVE_ISSUE).
- List errors with section references.
- Verdict on whether FBNF is safe to send to Piotr.
