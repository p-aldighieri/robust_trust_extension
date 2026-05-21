# Searcher pass 06 — Doval-Smolin disintegrated duality (parallel attack)

## Role

You are the Searcher, running in PARALLEL with Prover 12 which is
attempting Attack G (cone-Hall theorem). The user has ordered the
pipeline to leave no stone unturned. Your job: develop **Attack B
(Doval-Smolin full duality)** independently, so we have a backup if
cone-Hall has trouble at the infinite-state extension.

The literature pass already identified Doval-Smolin "Persuasion and
Welfare" (2024) as the closest dual candidate. The full framework
gives dual price functions on beliefs. The missing step (per Searcher
05) is **messagewise disintegration**: Doval-Smolin's framework is
aggregate; Definition 2 needs $P_{\beta^*}(\cdot\mid m)\in B(m)$ for
$q$-a.e. messages.

## Your task

State the Doval-Smolin full duality precisely. Then attack the
disintegration question:

1. **What does Doval-Smolin actually give?** State the duality
   precisely (Pareto-frontier persuasion, Bayes welfare set
   characterization, dual prices on simplex).

2. **What is the analog of "Bayes-cone calibration" in the
   Doval-Smolin language?** Each $B_j$ is a Bayes-optimal cone for
   the agent's chosen action at message $m_j$. Express this in
   Doval-Smolin's primal welfare-frontier terms.

3. **The disintegration gap.** Doval-Smolin gives feasibility of
   welfare profiles (aggregate Bayes-plausibility). Robust Trust
   Definition 2 wants disintegrated posteriors. The gap is the
   **disintegration of the persuasion duality**.

4. **Candidate fix**: maybe a Borel/Polish-space lift of
   Doval-Smolin's persuasion-frontier characterization to a
   message-conditional version. Tools: Schrödinger disintegration,
   Beiglböck-Nutz martingale OT, Strassen 1965 with conditional
   marginals.

5. **WTA ternary as test case**: does Doval-Smolin's framework give
   a dual price function for WTA ternary? If yes, disintegrate.

## Output

Inline markdown. Be specific about which Doval-Smolin theorem(s)
apply. Identify the SINGLE most useful theorem from their framework.
Then evaluate whether disintegration gives us a calibrated kernel
for general |Ω|≥3 (or at least for the WTA witness).

End with:
- Verdict: B (Doval-Smolin) is competitive with G (cone-Hall) /
  weaker / stronger / orthogonal.
- First prover target for B-route (if B is competitive or orthogonal).
- Recommendation: pursue G only, pursue B only, or pursue both.

## Constraints

- Banned tools list applies.
- Doval-Smolin is the right vocabulary; check whether their results
  CAN BE LIFTED to messagewise disintegration without resurrecting
  the menu-Hall coupling problem.
- Per user: leave no stone unturned.
