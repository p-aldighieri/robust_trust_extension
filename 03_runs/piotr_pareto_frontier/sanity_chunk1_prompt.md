# Math sanity-check chunk 1 — T1 + T2 + Binary capstone

## Role

Fresh-chat independent broad math review. Read `consolidator_01_response.md`
(durable source) and check the following three theorems for soundness:

1. **(T1) Finite-menu Pareto-Hall via Clarke-Danskin** (paper §3.3, v9 §3).
2. **(T2) α=0 singleton-strategy infinite extension** (v9 §4).
3. **Binary capstone** (|Ω|=2 under R-EE+R-TD+R-IES, v9 §5).

## What to check

- **Arithmetic and signs**: every computation in the proofs. Look
  especially for sign errors in Clarke subgradient sums, Bregman
  projection geometry, and the binary endpoint balance equations.
- **Measurability**: every selection theorem citation is correct
  (KRN, Castaing, Jankov-von Neumann). Verify on tie sets without
  atomlessness assumption.
- **Tool citations**: Clarke 1983, Aumann 1965, Hildenbrand 1974,
  Kallenberg 1997 — cite numbers correctly?
- **Overclaiming**: does the proof claim more than is stated?
- **WTA compatibility**: where applicable, check the proof doesn't
  contradict v8 Lemma 7 / Theorem 8 on the WTA witness.

## Output

For each theorem, state:
- Soundness verdict (SOUND / MINOR_FIXES_NEEDED / SUBSTANTIVE_ISSUE).
- List any errors found.
- Recommend whether this theorem is safe to send to Piotr.

## Constraints

- Banned tools list applies.
- Be skeptical; don't trust the prover.
- If you find a real error, name it precisely with section/equation reference.
