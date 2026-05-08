## Exact clause set used

I use the original banked **CTR** package exactly as stated in the attached CTR source. It requires existence of:

* a finite anchor set (A\subset \mathbb N),
* an infinite moved tail (S:=\mathbb N\setminus A) with (1\in S),
* a target point (\bar w\in W),
* and (\varepsilon>0),

such that, for
[
v_j(t)=
\begin{cases}
w_j^*, & j\in A,\
(1-t)w_j^*+t\bar w, & j\in S,
\end{cases}
\qquad t\in[0,\varepsilon],
]
the following hold:

* **(CTR1) Admissibility:** (v(t)\in W^{\mathbb N}) for every (t\in[0,\varepsilon]).
* **(CTR2) Witness compatibility at column (1):** (e_1\cdot(\bar w-w_1^*)>0).
* **(CTR3) Obstructing-row floor supported on the moved tail and lifted by the target:**
  [
  \inf_{j\in S} m_{i^*}!\cdot w_j^* = c_{i^*}(w^*)
  < \inf_{j\in A} m_{i^*}!\cdot w_j^*,
  \qquad
  m_{i^*}!\cdot \bar w > c_{i^*}(w^*).
  ]
* **(CTR4) No floor spillovers on other rows:** for every (i\neq i^*),
  [
  m_i\cdot \bar w \ge c_i(w^*).
  ]
* **(CTR5) No aggregate aligned loss:**
  [
  \sum_{j\in S}\tau_j\big(m_j\cdot \bar w-m_j\cdot w_j^*\big)\ge 0.
  ]

The reviewer-cleared CTR pass confirms that this is only a **conditional** export lemma, (CTR\Rightarrow) local no-embedding, and also notes that (1\in S) and CTR2 are bookkeeping rather than the logical engine of the contradiction. I keep them here because the task is to audit against the **exact source clause set**, not a cleaned-up rewrite.   

## Clause audit for (S_{\mathrm{ray}})

The canonical set under audit is
[
S_{\mathrm{ray}}
:=
{,j\neq i^*:\text{$j$ is moved at }w^*\text{ and lies in the same }(d_1=e_1)\text{-obstruction class as }i^*,}.
]
That definition is banked. The same reviewer-cleared note also states that what is **not** bankable is any claim that (S_{\mathrm{ray}}) is already an admissible infinite moved tail; only conditional bookkeeping results are available under the **provisional assumption** that (S_{\mathrm{ray}}) is admissible. 

1. **Definition of (S_{\mathrm{ray}}).**
   **Status:** proved.
   This is the banked definition above. 

2. **Source-level setup clause:** there exists a **finite** anchor set (A\subset\mathbb N) such that (S_{\mathrm{ray}}=\mathbb N\setminus A), hence (S_{\mathrm{ray}}) is the required source-level infinite moved tail for the common-target path.
   **Status:** unproved on the current record.
   Reason: the current record gives the set definition of (S_{\mathrm{ray}}), and it gives bookkeeping continuity/concavity facts only **under the provisional assumption** that (S_{\mathrm{ray}}) is admissible. It explicitly does **not** bank that (S_{\mathrm{ray}}) is already an admissible infinite moved tail. So the finite-anchor / infinite-tail realization required by the original CTR source is not yet proved. This is the **first unmet clause**, so the audit stops here.  

Sub-remark. I am not stopping on the bookkeeping subclause (1\in S). The stronger upstream failure is earlier: the record does not yet prove the finite-anchor / infinite-tail realization itself. The reviewer-cleared CTR note says (1\in S) is bookkeeping anyway. 

## What is bankable now

* The exact source-level CTR clause set above.
* The reviewer-cleared fact that CTR yields only a **conditional** no-embedding lemma, not a derivation of CTR from the obstruction.
* The definition of (S_{\mathrm{ray}}).
* Conditional on a **fixed admissible** infinite moved tail (S), the fixed-tail reduction is valid; and conditional on the **provisional assumption** that (S_{\mathrm{ray}}) is admissible, the countable-atomic bookkeeping patch gives the continuity/concavity facts needed for later slice work.  

## What is only diagnostic

* Any claim that (S_{\mathrm{ray}}) already satisfies the source-level CTR setup.
* Any claim that there already exist (\bar w\in W) and (\varepsilon>0) for (S_{\mathrm{ray}}).
* Any test of (K_{S_{\mathrm{ray}},\varepsilon}) or any support-gap inequality. Those remain downstream until the missing tail/admissibility gate is actually proved. 

Exact crux lemma: prove or refute that (S_{\mathrm{ray}}) can be realized as the cofinite admissible moved tail in the original CTR package. Without that bridge, neither the existence of (\bar w,\varepsilon) nor CTR1 to CTR5 is live for (S_{\mathrm{ray}}) on the current record.

Suggested next local action: prove or refute the first unmet setup clause, namely that (S_{\mathrm{ray}}) is the source-level infinite moved tail (S=\mathbb N\setminus A) with (A) finite for a genuine common-target comparison path; only if that is banked should the audit proceed to (\bar w), (\varepsilon), and then CTR1.
