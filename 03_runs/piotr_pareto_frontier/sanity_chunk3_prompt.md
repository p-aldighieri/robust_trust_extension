# Math sanity-check chunk 3 — Hall biconditional + P2*/P3/P4 + G4 LP

## Role

Fresh-chat independent broad math review. Read `consolidator_01_response.md`
(durable source) and check the most technical theorem block for
soundness:

1. **G1 finite cone-Hall theorem** — Farkas/LP duality with cone-valued
   constraints. Sign convention to ≤0 form. WTA dual certificate
   $\Psi(y) = 2/9 > 0$.
2. **G2c compact-closed Borel extension** — conic separation; avoids
   v8 obstacles O1/O2/O3.
3. **G3 Robust Trust Hall biconditional** — Theorem 2 ⟺ Ψ(y) ≤ 0 under
   regularity (Reg-1) + (Reg-2).
4. **P2*/P3/P4 primitive sufficient classes** — cone-margin, polyhedral
   with cone-margin, radial symmetry.
5. **G4 finite-facet polyhedral LP threshold** — finite LP feasibility
   check.
6. **Worked examples** (WTA ternary, plurality, finite-experiment).
7. **Phase (b) verdict** — regularity not eliminable, automatic under
   smooth-frontier primitives.

## What to check

### G1 (cone-Hall LP duality)
- Farkas / LP-dual derivation: is the sign convention correct?
- Support function $h_{B_j}(y) = \sup_{\mu\in B_j} y\cdot \mu$ orientation.
- WTA computation:
  - $y_j = 1 - 2e_j$ extreme dual price.
  - $h_{B_j}(y_j) = 1/3$ at $\mu_0 = (1/3,1/3,1/3)$.
  - $\E[s_j | s\in K_j^-] = 1/9$ under uniform τ.
  - $\int_{K_j^-}(2/3 - 2s_j)d\tau = (1/3)(2/3 - 2/9) = 4/27$. Per-vertex.
  - Sum × 3 = 4/9. Times $(1-\alpha) = 1/2$: $\Psi = 2/9$.
  Verify EVERY step.

### G2c (Borel extension)
- Conic separation argument: any LP-duality gap?
- v8 obstacle avoidance: O1 (Borel→compact), O2 (cell-flow), O3 (slack
  discipline). Verify each.

### G3 (biconditional)
- Forward direction (Theorem 2 ⇒ Ψ ≤ 0).
- Reverse direction (Ψ ≤ 0 ⇒ Theorem 2).
- Regularity package (Reg-1)+(Reg-2) usage.

### P2*/P3/P4
- (P1) HOLD: WTA is a counterexample. Verify.
- (P2*) bounded-jamming cone-margin: is this a genuine primitive?
- (P3) polyhedral with cone-margin: is the cone-margin condition
  meaningful?
- (P4) radial: spherical models — does symmetry-averaging close cleanly?

### G4 (LP threshold)
- Finite-cell tie-discipline: necessary?
- WTA recovery: G4 reduces to G1's threshold $D \ge 2(1-\alpha)/(9\alpha)$.
- Plurality + finite-experiment: extrapolation correct?

### Phase (b)
- "Regularity not eliminable from standing alone" — counterexample
  argument under compact M? Or just absence of a derivation?
- "Smooth-frontier primitives": precise statement of what's needed.

## Output

- Soundness verdict for each block.
- Critical: the WTA dual computation arithmetic. If $\Psi \ne 2/9$
  for the stated dual price, everything downstream breaks.
- End with: safe to send to Piotr?

## Constraints

- Banned tools list applies.
- This is the most technical chunk. Be the most skeptical here.
