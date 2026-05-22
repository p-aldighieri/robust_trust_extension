Build status: PASS for the exact byte-concatenated `v8_main.lean + v9_appendix.lean` via `lake env lean`. The requested copy into `C:/Users/Public/.../V9Main.lean` was blocked by filesystem ACL, so I did not count the stale `lake build` replay as verification.

Sorry count: 0 new in `lean/v9_appendix.lean`; combined file still has the 3 pre-existing v8 sorries.

New axioms: 1, `Inventory.V9.clarke_product_normal_cone_projection_bridge`, cited to Clarke 1990 §6.2 and Aubin-Frankowska, *Set-Valued Analysis*, Ch. 6. This is only for the product normal-cone projection bridge over opaque `ClarkeNormalCone`.

Three target fields:
- `g_nonneg`: removed from `ParetoMenuPrimitives`, derived from `gOf`, lambda nonnegativity, belief nonnegativity, and `integral_nonneg`.
- `mass_balance`: removed from `ParetoMenuPrimitives`, derived from `gOf/qOf`, finite sum-integral exchange, and belief sum-one.
- `normal_cone_inequality`: removed from `ParetoMenuPrimitives`, derived through `clarke_fermat_normal_cone` plus the cited product projection bridge.

Downstream typecheck: binary `L_B5` and `FBNF-F3` typechecked as part of the full concatenated file.

Files edited: `lean/v9_appendix.lean` only.