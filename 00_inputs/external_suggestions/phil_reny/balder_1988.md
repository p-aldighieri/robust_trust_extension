MATHEMATICS OF OPERATIONS RESEARCH Vol. 13, No 2, May 1988 Printed in U.S.A.

# GENERALIZED EQUILIBRIUM RESULTS FOR GAMES WITH INCOMPLETE INFORMATION*

ERIK J. BALDER

University of Utrecht

Milgrom and Weber (1985) gave an existence result for a Nash equilibrium in a game with incomplete information, using their notion of a distributional strategy. Here we obtain a substantial improvement of their existence result in terms of the more traditional concept of a behavioral strategy. This improvement is reached very naturally as an application of a theory of weak convergence for transition probabilities, which is recapitulated extensively in this paper. Also, a new result on the weak convergence of product transition probabilities is included.

1. Introduction. The following noncooperative one-stage game with incomplete information was recently studied by Milgrom and Weber (1985). The game has $n$ players. Each player $i$, $i = 1, \ldots, n$, obtains his private information from a so-called set of types $T_i$, which is equipped with a $\sigma$-algebra $\mathcal{T}_i$; cf. Harsanyi (1967-68), Mertens-Zamir (1985). We abbreviate by $T := \prod_{i=1}^{n} T_i$, $\mathcal{T} := \otimes_{i=1}^{n} \mathcal{T}_i$. Let $\eta$ be a probability on the product space $(T, \mathcal{T})$, which governs the random behavior of the information. Each player $i$ has only access to his private, marginally realized information type, which is, of course, governed by $\eta_i$, the marginal on $(T_i, \mathcal{T}_i)$ of $\eta$. Upon learning this information he has to take an action from a topological action space $A_i$. In this setting Milgrom and Weber define a distributional strategy for player $i$ to be a probability measure on the product space $(T_i \times A_i, \mathcal{T}_i \otimes \mathcal{R}(A_i))$, such that $\eta_i$ is its marginal on $T_i$. For player $i$ the consequence of all players $1, \ldots, n$ choosing their respective strategies is then measured by the expected value under $\eta$ of his payoff function $U_i: T \times A \to \mathbb{R}$, where we abbreviate by $A := \prod_{i=1}^{n} A_i$. To obtain the topological properties for strategies and expected payoffs which guarantee the existence of a Nash equilibrium, Milgrom and Weber use the classical weak topology for probability measures (Billingsley 1968, Ash 1972).

In this paper we propose to use the more conventional and natural concept of a behavioral strategy for each player $i$, i.e., a transition probability with respect to $(T_i, \mathcal{T}_i)$ and $(A_i, \mathcal{R}(A_i))$. In itself, this constitutes only a minor variation on the distributional strategy theme of Milgrom-Weber (1985) (the usual product measure on $(T_i \times A_i, \mathcal{T}_i \otimes \mathcal{R}(A_i))$, induced by $\eta_i$ and any behavioral strategy, is a distributional strategy). However, what makes our approach much more powerful is the use of a less known theory of weak convergence for transition probabilities, which extends its classical counterpart. This theory does not impose any topological restrictions on the type spaces $T_i$ or on the behavior on $T$ of the functions $U_i(\cdot, a)$, $a \in A$. Given the abstract nature of Harsanyi's notion of type, such an approach is definitely more natural than the one followed by Milgrom and Weber (see also the comments in §6 of their paper). Other improvements associated with this approach are as follows: (i)

*Received February 3, 1986; revised November 25, 1986.

AMS 1980 subject classification. Primary: 90D99; Secondary: 60F99.

IAOR 1973 subject classification. Main: Games; Cross References: Probability.

OR/MS Index 1978 subject classification. Primary: 239 Games.

Key words. Nash equilibrium, Incomplete information, Behavioral strategy.

0364-765X/88/1302/0265$01.25

Copyright © 1988, The Institute of Management Sciences/Operations Research Society of America

---

266
ERIK J. BALDER

There is no need for an equicontinuity condition for the functions $U_{i}(t,\cdot)$, $t \in T$ (cf. condition $R1$ of Milgrom–Weber 1985). (ii) Less restrictive bounds can be imposed on the payoff functions $U_{i}$. (iii) An extension to the case with noncompact action spaces is readily available.

Our improved approach applies also to Mamer–Schilling (1986), where two-person zero-sum games with incomplete information are studied, using distributional strategies and the classical weak convergence topology.

The organization of this paper is as follows. In §2 we recapitulate relevant parts of the weak convergence theory for transition probabilities. We present a technically very useful embedding result (Theorem 2.1), an analogue of the well-known “portmanteau theorem” of classical weak convergence theory (Theorem 2.2), a generalization of Prohorov’s theorem (Theorem 2.3) and a new result on the weak convergence of product transition probabilities (Theorem 2.5), which generalizes Billingsley (1968, Theorem 3.2). The weak convergence theory is applied in §3. We obtain two Nash equilibrium results (Theorems 3.1, 3.3) for the $n$-person game described above, one of which uses noncompact action spaces, and a saddle point equilibrium result (Theorem 3.4) for the two-person game of Mamer–Schilling (1986). In both cases substantial improvements are obtained.

## 2. Weak convergence of transition probabilities.

The classical theory of weak convergence for probability measures, as presented, for instance, in Billingsley (1968), Ash (1972) and Dellacherie–Meyer (1975), has as its counterpart a theory of weak convergence for transition probabilities which is less known, but more general than its ancestor. Its origins lie in the work of Wald (1950), LeCam (1955, 1957) and Renyi (1963) in the domain of statistics (see also Jacod–Memin 1981 for a more recent account), and in the work of Young (1969), McShane (1940) and Warga (1962, 1972) on relaxed control theory.

Recently, the present author brought together and improved a number of results in this theory, and gave applications to existence problems in optimal control theory (Balder 1979, 1984a, 1985), to Fatou’s lemma in several dimensions and related problems (Balder 1984a-b, 1986b), as well as to some other problems in analysis (e.g., Balder 1986a). In this section we shall recapitulate this theory rather extensively, but only insofar as it is of use for the applications appearing in §3. For more information on the subject the reader is referred to the papers mentioned above.

Let $S$ be a metrizable Lusin space, i.e., $S$ is a topological space which is homeomorphic to a Borel-measurable subset of some compact metric space $(\hat{S},\rho)$; see Dellacherie–Meyer (1975, III.16, III.79). Let us remark that any Borel subset of a Polish (i.e. complete separable and metric) space is a metrizable Lusin space; cf. Dellacherie–Meyer (1975, III.17) or Ash (1972, Problem 4.48). The definition above implies that for all topological purposes we can identify $S$ with the subset of $\hat{S}$ to which it is homeomorphic. Therefore we shall assume from now on that $S$ is a Borel-measurable subset of $\hat{S}$, equipped with the relative $\hat{S}$-topology. In the sequel many definitions, results, etc. apply equally to $S$ and $\hat{S}$. In such cases the symbol $Z$ will be used, which stands at the same time for both $S$ and $\hat{S}$.

Let $(T, \mathcal{T}, \mu)$ be a fixed finite measure space. A *transition probability* with respect to $(T, \mathcal{T})$ and $(Z, \mathcal{B}(Z))$ is a function $\delta: T \times \mathcal{B}(Z) \to [0,1]$ such that

(i) $\delta(t; \cdot)$ is a probability measure on $(Z, \mathcal{B}(Z))$ for every $t \in T$.

(ii) $\delta(\cdot; B)$ is a $\mathcal{F}$-measurable function on $T$ for every $B \in \mathcal{B}(Z)$.

See Neveu (1964, III.2) or Ash (1972, 2.6) for more information. The set of all transition probabilities with respect to $(T, \mathcal{T})$ and $(Z, \mathcal{B}(Z))$ is denoted by $\mathcal{R}_Z$. Note that $\mathcal{R}_S$ can be regarded as a subset of $\mathcal{R}_{\hat{\mathcal{S}}}$ by identifying any $\delta \in \mathcal{R}_S$ with $\hat{\delta} \in \mathcal{R}_{\hat{\mathcal{S}}}$,

---

GAMES WITH INCOMPLETE INFORMATION

given by

$$
\hat {\delta} (t; \hat {B}) := \delta (t; \hat {B} \cap S), \quad t \in T, \hat {B} \in \mathcal {B} (\hat {S}).
$$

It should be remarked here that  $\mathcal{B}(S)$  equals the set of all intersections  $\hat{B} \cap S$ ,  $\hat{B} \in \mathcal{B}(\hat{S})$ , since  $S$  is endowed with the relative  $\hat{S}$ -topology. A uniformly finite transition measure with respect to  $(T, \mathcal{T})$  and  $(\hat{S}, \mathcal{B}(\hat{S}))$  is a function  $\hat{\sigma}: T \times \mathcal{B}(\hat{S}) \to \mathbb{R}$  such that

(i)  $\hat{\sigma}(t; \cdot)$  is a signed bounded measure on  $(\hat{S}, \mathcal{B}(\hat{S}))$  for every  $t \in T$ .
(ii)  $\sup_{t\in T}|\hat{\sigma} (t;\cdot)|(\hat{S}) &lt;   + \infty .$
(iii)  $\hat{\sigma} (\cdot ;\hat{B})$  is a  $\mathcal{F}$  measurable function on  $T$  for every  $\hat{B}\in \mathcal{B}(\hat{S})$

Here  $|\hat{\sigma}(t; \cdot)|(\hat{S})$  denotes the usual total variation of the signed measure  $\hat{\sigma}(t; \cdot)$  (corresponding to the Hahn-Jordan decomposition of  $\hat{\sigma}(t; \cdot)$ ; cf. Ash 1972, 2.1.4). The set of all uniformly finite transition measures with respect to  $(T, \mathcal{T})$  and  $(\hat{S}, \mathcal{B}(\hat{S}))$  is denoted by  $\hat{\mathcal{L}}$ . It is evident that  $\mathcal{R}_S$  and  $\mathcal{R}_{\hat{S}}$  are subsets of  $\hat{\mathcal{L}}$  and that  $\hat{\mathcal{L}}$  is a linear space for the usual addition and scalar multiplication of transition measures.

A normal integrand on  $T \times Z$  is a function  $g \colon T \times Z \to (-\infty, +\infty]$  such that

(i)  $g(t,\cdot)$  is lower semicontinuous on  $Z$  for every  $t\in T$
(ii)  $g$  is  $\mathcal{T} \otimes \mathcal{B}(Z)$ -measurable on  $T \times Z$ .

A normal integrand  $g$  on  $T \times Z$  is said to be integrably bounded from below if there exists  $\varphi \in \mathcal{L}_1(T) \coloneqq \mathcal{L}_1(T, \mathcal{T}, \mu)$  such that

(iii)  $g(t,z)\geqslant \varphi (t)$  for all  $t\in T$ $z\in Z$

The set of all normal integrands on  $T \times Z$  that are integrably bounded from below is denoted by  $\mathcal{G}_Z^{bb}$ . A Carathéodory integrand on  $T \times Z$  is a function  $g \colon T \times Z \to \mathbb{R}$  such that

(i)  $g(t,\cdot)$  is continuous on  $Z$  for every  $t\in T$
(ii)  $g$  is  $\mathcal{T} \otimes \mathcal{B}(Z)$ -measurable on  $T \times Z$ .
(iii)  $|g| \leqslant \varphi$  on  $T \times Z$  for some  $\varphi \in \mathcal{L}_1(T)$ .

The set of all Carathéodory integrands on  $T \times Z$  is denoted by  $\mathcal{G}_Z^C$ . Note that  $\mathcal{G}_Z^C$  is precisely the intersection of the sets  $\mathcal{G}_Z^{bb}$  and  $-\mathcal{G}_Z^{bb}$ . For  $\hat{g} \in \mathcal{G}_S^{bb}$  the functional  $I_{\hat{g}}: \hat{\mathcal{L}} \to (-\infty, +\infty]$  is defined by

$$
I _ {\hat {g}} (\delta) := \int_ {T} \left[ \int_ {\hat {S}} \hat {g} (t, s) \sigma (t; d s) \right] \mu (d t).
$$

Similarly, for  $g \in \mathcal{G}_S^{bb}$  the functional  $I_g \colon \mathcal{R}_S \to (-\infty, +\infty]$  is defined by

$$
I _ {\hat {g}} (\delta) := \int_ {T} \left[ \int_ {S} g (t, s) \delta (t; d s) \right] \mu (d t).
$$

The above integrals make sense by Ash (1972, 2.6.7) and Neveu (1964, III.2.1). The weak topology on  $\mathcal{R}_Z$  is defined as the coarsest topology for which all functionals  $I_g\colon \mathcal{R}_Z\to \mathbb{R}$ ,  $g\in \mathcal{G}_Z^C$ , are continuous. Also, the weak topology on  $\hat{\mathcal{L}}$  is defined as the coarsest topology for which all functionals  $I_{\hat{g}}\colon \hat{\mathcal{L}}\to \mathbb{R}$ ,  $g\in \mathcal{G}_{\hat{g}}^{C}$ , are continuous. Note that the weak topology on  $\mathcal{R}_Z$  coincides with the classical weak topology if  $T$  is trivial (i.e. a singleton). Then, namely,  $\mathcal{G}_Z^C$  coincides with the set  $\mathcal{C}_b(Z)$  of all bounded continuous functions on  $Z$ , and  $\mathcal{R}_Z$  with the set of all probability measures on  $(Z,\mathcal{B}(Z))$ . Let  $\hat{\mathcal{N}}$  be the subset of  $\hat{\mathcal{L}}$  defined by

$$
\hat {\mathcal {N}} := \left\{\hat {\sigma} \in \hat {\mathcal {L}} \colon I _ {\hat {g}} (\hat {\sigma}) = 0 \text { for all } \hat {g} \in \mathcal {G} _ {\hat {S}} ^ {C} \right\}.
$$

Clearly  $\hat{\mathcal{N}}$  is a weakly closed linear subspace of  $\hat{\mathcal{L}}$  which consists precisely of all

---

268
ERIK J. BALDER

$\hat{\sigma} \in \hat{\mathcal{L}}$ such that $|\hat{\sigma}(t; \cdot)|(\hat{S}) = 0$ for almost every $t$ in $T$ (to see this, consider all $\hat{g}(t, s) := 1_D(t)\hat{c}(s)$, with $D \in \mathcal{T}$ and $\hat{c} \in \mathcal{C}(\hat{S}) := \mathcal{C}_b(\hat{S})$, and recall that $\mathcal{C}(\hat{S})$ is separable for the supremum norm). The usual quotient mapping $\pi: \hat{\mathcal{L}} \to \hat{\mathcal{L}} / \hat{\mathcal{N}}$ (Choquet 1969, 15.5) is given by

$$
\pi(\hat{\sigma}) := \hat{\sigma} + \hat{\mathcal{N}} := \left\{ \hat{\sigma} + \hat{\sigma}' : \hat{\sigma}' \in \hat{\mathcal{N}} \right\}. \tag{2.1}
$$

By weak closedness of $\hat{\mathcal{N}}$, the quotient space $\hat{\mathcal{L}} / \hat{\mathcal{N}}$ is a Hausdorff topological vector space (Choquet 1969, 15.7), which is easily seen to be locally convex. Here $\hat{\mathcal{L}} / \hat{\mathcal{N}}$ is of course equipped with the weak quotient topology, which can also be characterised as the coarsest topology on $\hat{\mathcal{L}} / \hat{\mathcal{N}}$ for which all functionals $J_{\hat{g}}: \hat{\mathcal{L}} / \hat{\mathcal{N}} \to \mathbb{R}$, $\hat{g} \in \mathcal{G}_S^C$, are continuous. Here we define $J_{\hat{g}}(\pi(\hat{\sigma})) := I_{\hat{g}}(\hat{\sigma})$, which makes sense by the nature of $\hat{\mathcal{N}}$.

**THEOREM 2.1.** The weak topology on $R_S$ is the relative weak $R_{\hat{S}}$-topology.

**PROOF.** The restriction to $T \times S$ of any function in $\mathcal{G}_S^C$ clearly belongs to $\mathcal{G}_C^C$. Hence the weak topology on $\mathcal{R}_S$ is certainly not coarser than the relative weak $\mathcal{R}_{\hat{S}}$-topology. Conversely, let $g \in \mathcal{G}_S^C$ be arbitrary. It is enough to prove that $I_g$ is the restriction to $\mathcal{R}_S$ of a weakly lower semicontinuous functional on $\hat{\mathcal{R}}_S$ (because if this fact has been proven, the same argument can be applied to $-g$, which also belongs to $\mathcal{G}_S^C$). For $n \in \mathbb{N}$ we define $\hat{g}_n \colon T \times \hat{S} \to \mathbb{R}$ by

$$
\hat{g}_n(t, \hat{s}) := \inf_{s \in S} \left[ n \rho(\hat{s}, s) + g(t, s) \right]. \tag{2.2}
$$

This gives trivially that $\hat{g}_n \leqslant \hat{g}_{n+1}$ on $T \times \hat{S}$ and $\hat{g}_n \leqslant g$ on $T \times S$ for all $n \in \mathbb{N}$. We claim that

$$
g(t, s) = \lim_{n \to \infty} \uparrow \hat{g}_n(t, s) \quad \text{for every } t \in T, s \in S. \tag{2.3}
$$

Let $t \in T$ and $s_0 \in S$ be arbitrary. For any $\epsilon &gt; 0$ there exists, by lower semicontinuity of the function $g(t, \cdot)$ on $S$, a number $\beta &gt; 0$ such that $\rho(s, s_0) &lt; \beta$ implies $g(t, s) \geqslant g(t, s_0) - \epsilon$ for every $s \in S$. Now let $n$ be so large that $n\beta + \inf_S g(t, \cdot) \geqslant g(t, s_0)$. Then the infimum in (2.2) can obviously be restricted to the set of all $s \in S$ with $\rho(s, s_0) &lt; \beta$. This gives $\hat{g}_n(t, s_0) \geqslant g(t, s_0) - \epsilon$. Hence, (2.3) follows. This implies, by an application of the monotone convergence theorem

$$
I_g(\delta) = \lim_{n \to \infty} \uparrow I_{\hat{g}_n}(\delta) = \sup_n I_{\hat{g}_n}(\delta) \quad \text{for all } \delta \in \mathcal{R}_S. \tag{2.4}
$$

It remains therefore to prove that $\hat{g}_n$ belongs to $\mathcal{G}_S^C$. Note that $S$ is separable (since $\hat{S}$ is so). Denote by $\{s_j\}$ a countable dense subset of $S$. Then (2.2) can be rewritten as $\hat{g}_n(t, \hat{s}) = \inf_j [n\rho(\hat{s}, s_j) + g(t, s_j)]$, since $g(t, \cdot)$ is continuous on $S$. Hence $\hat{g}_n$ is $\mathcal{T} \times \mathcal{B}(\hat{S})$-measurable. Also, by the triangle inequality it follows immediately from (2.2) that $\hat{g}_n(t, \cdot)$ is continuous—and even $\rho$-Lipschitz continuous—on $\hat{S}$. Since also $\sup_S |\hat{g}_n(t, \cdot)| \leqslant \sup_S |g(t, \cdot)|$ for every $t \in T$, we may conclude $\hat{g}_n \in \mathcal{G}_S^C$. QED

For any $D \in \mathcal{T}$, $c \in \mathcal{C}_b(Z)$ the function $g \colon T \times Z \to \mathbb{R}$, defined by $g(t, z) := 1_D(t)c(z)$ belongs to $\mathcal{G}_S^C$. The corresponding functional $I_g$ will also be denoted by $I_{D,c}$. Thus, for $\hat{\sigma}$ in $\hat{\mathcal{L}}$ or $\mathcal{R}_{\hat{S}}$, and $\delta$ in $\mathcal{R}_S$

$$
I_{D, \hat{s}}(\hat{\sigma}) := \int_D \left[ \int_{\hat{S}} \hat{c}(s) \hat{\sigma}(t; ds) \right] \mu(dt), \quad I_{D, c}(\delta) := \int_D \left[ \int_S c(s) \delta(t; ds) \right] \mu(dt).
$$

---

GAMES WITH INCOMPLETE INFORMATION 269

THEOREM 2.2. The weak topology on $\mathcal{R}_Z$ is the coarsest topology such that any one of the following holds:

(a) All functionals $I_g$, $g \in G_Z^{bb}$, are lower semicontinuous.
(b) All functionals $I_g$, $g \in G_Z^c$, are continuous.
(c) All functionals $I_{D,c}$, $D \in \mathcal{T}$, $c \in \mathcal{C}_b(Z)$, are continuous.
(d) All functionals $I_{D,c}$, $D \in \mathcal{T}_0$, $c \in \mathcal{C}_b(Z)$, are continuous.

Here $\mathcal{T}_0$ may stand for any subalgebra of $\mathcal{T}$ which generates $\mathcal{T}$.

PROOF. Observe that (b) holds by definition of the weak topology. Denote by $\tau_{a}, \tau_{b}, \tau_{c}, \tau_{d}$ the topologies generated on $\mathcal{R}_{Z}$ by the respective classes mentioned in a, b, c, d. Trivially, we have $\tau_{a} \supset \tau_{b} \supset \tau_{c} \supset \tau_{d}$. Thus, it is now enough to prove (i) $\tau_{d} \supset \tau_{c}$ and (ii) $\tau_{c} \supset \tau_{a}$.

(i) For arbitrary $D \in \mathcal{T}$, $c \in \mathcal{C}_b(Z)$ there exists for any $\epsilon &gt; 0$ a set $D_\epsilon$ in $\mathcal{T}_0$ such that $\int_T |1_D - 1_{D_\epsilon}| \, d\mu \leqslant \epsilon$, by Ash (1972, 1.3.11). Since $|I_{D,c}(\delta) - I_{D,c}(\delta)| \leqslant \|c\|_\infty \epsilon$ for all $\delta \in \mathcal{R}_Z$, this proves that on $\mathcal{R}_Z$, $I_{D,c}$ is the uniform limit of $\tau_d$-continuous functionals. Hence, $I_{D,c}$ is $\tau_d$-continuous.

(ii) Consider first the case $Z = S$. For arbitrary $g \in \mathcal{G}_S^{bb}$ we define $\{\hat{g}_n\}$ by (2.2). Since only lower semicontinuity of $g(t, \cdot)$ was used in proving (2.3), (2.3) still holds. Of course, this again implies (2.4). We can show that $I_{\hat{g}_n}$ is $\tau_c$-continuous on $\mathcal{R}(T, \hat{S})$. This goes as follows. As in the proof of Theorem 2.1 we find that $\hat{g}_n(t, \cdot)$ is continuous for every $t \in T$ and that $|\hat{g}_n|$ is integrably bounded. Also, for any $\hat{s} \in \hat{S}$, $\beta \in \mathbb{R}$ the set of all $t \in T$ such that $\hat{g}_n(t, \hat{s}) &lt; \beta$, is $\mathcal{T}_0$-measurable, since it is the projection of a $\mathcal{T} \otimes \mathcal{B}(S)$-measurable set on $T$ (apply Castaing-Valadier 1977, III.21 and observe that $S$ is certainly a Suslin space). Hence, by Castaing-Valadier (1977, III.14) $\hat{g}_n$ is $\mathcal{T}_\mu \otimes \mathcal{B}(\hat{S})$-measurable. Here $\mathcal{T}_\mu$ stands for the $\mu$-completion of $\mathcal{T}$. We shall now produce a sequence $\{\hat{g}_{n,m}\}$ in $G_S^C$ which approximates $\hat{g}_n$ in a suitable way. Let $\{\hat{c}_i\}$ be a countable dense subset of $\mathcal{C}(\hat{S})$ for the supremum norm $\|\cdot\|_\infty$, and set $\hat{c}_0$ equal to the null function on $\hat{S}$. Fix $m \in \mathbb{N}$; for $j = 0, \ldots, m$ let $D_{j,m}$ be the set of all $t \in T$ for which $j$ is the first index among $0, \ldots, m$ with $\|\hat{g}_n(t, \cdot) - \hat{c}_j\|_\infty = \min_{0 \leqslant i \leqslant m} \|\hat{g}_n(t, \cdot) - \hat{c}_i\|_\infty$. Note that the sets $D_{j,m}, 0 \leqslant j \leqslant m$, are mutually disjoint and have $T$ as their union. Each set $D_{j,m}$ is seen to belong to $\mathcal{T}_\mu$ by applying the projection theorem of Castaing-Valadier (1977, III.21), completely similar to the proof of $\mathcal{T}_\mu$-measurability of $\hat{g}_n(\cdot, \hat{s})$ above. Hence, there correspond to each $D_{j,m}$ two disjoint sets $D_{j,m}'$ and $N_{j,m}$ in $\mathcal{T}$, with $N_{j,m}$ a $\mu$-null set and $D_{j,m}' \subset D_{j,m} \subset D_{j,m}' \cup N_{j,m}$. Now take $N$ to be the union of all sets $N_{j,m}$, $m \in \mathbb{N}$, $0 \leqslant j \leqslant m$. Then $N$ is a $\mu$-null set. Define $\hat{g}_{n,m} := \sum_{j=1}^{m} |1_{D_{j,m}'} \hat{c}_j|$. Then for every $t \notin N$, $\|\hat{g}_n(t, \cdot) - \hat{g}_{n,m}(t, \cdot)\|_\infty \to 0$ as $m \to \infty$, by denseness of $\{\hat{c}_i\}$ in $\mathcal{C}(\hat{S})$. Also, since $\hat{c}_0 = 0$, $\|\hat{g}_{n,m}(t, \cdot)\|_\infty \leqslant 2\|\hat{g}_n(t, \cdot)\|_\infty$ for every $t \in T$. By the dominated convergence theorem this implies that $\sup_{\delta \in \mathcal{R}(T; \hat{S})} |I_{\hat{g}_n}(\delta) - I_{\hat{g}_{n,m}}(\delta)| \to 0$ as $m \to \infty$. Since we consider the case $Z = S$ here, we conclude that $I_{\hat{g}_n}$ restricted to $\mathcal{R}_S$, is $\tau_c$-continuous, since the restrictions of $\hat{g}_{n,m}$ to $T \times S$ are clearly finite sums of integrands of the type $1_D(t)c(s)$ with $D \in \mathcal{T}$, $c \in \mathcal{C}_b(S)$. Now by (2.4) it follows that $I_g$ is $\tau_c$-lower semicontinuous. Hence $\tau_c \supset \tau_a$.

(ii) Consider now the case $Z = \hat{S}$. For arbitrary $g \in \mathcal{G}_S^{bb}$ define $\{\hat{g}_n\}$ as in (2.2), replacing $S$ by $\hat{S}$. Then (2.3)-(2.4) continue to hold, with $S$ replaced by $\hat{S}$. Now repeat the above construction of $\hat{g}_{n,m}$ and note that they are finite sums of integrands of the type $1_D(t)\hat{c}(s)$, with $D \in \mathcal{T}$, $\hat{c} \in \mathcal{C}(\hat{S})$. Then finish as above. QED

Theorem 2.2 lists only a few of several alternative characterizations of the weak topology. Its analogue in classical weak convergence theory is well known under the name “portmanteau theorem” (Billingsley 1968, Theorem 2.1).

Let $\mathcal{H}_Z^{bb}$ be the set of all functions $h: T \times Z \to (-\infty, +\infty]$ such that

(i) $h(t, \cdot)$ is inf-compact on $Z$ for every $t \in T$ (i.e. for every $\beta \in \mathbb{R}$ $\{z \in Z: h(t, z) \leqslant \beta\}$ is compact).

---

270
ERIK J. BALDER

(ii) $h$ is $\mathcal{T} \otimes \mathcal{B}(Z)$-measurable on $T \times Z$.

(iii) $h \geqslant \varphi$ on $T \times Z$ for some $\varphi \in \mathcal{L}_1(T)$.

Clearly $\mathcal{H}_{\hat{S}}^{,bb}$ is contained in $\mathcal{G}_Z^{bb}$. For $Z = \hat{S}$, $\mathcal{H}_S^{,bb}$ and $\mathcal{G}_S^{bb}$ in fact coincide, so only the set $\mathcal{H}_S^{,bb}$ is new.

**THEOREM 2.3.** (a) $\mathcal{R}_{\hat{S}}$ is a weakly compact subset of $\hat{\mathcal{L}}$. (b) For every $h \in \mathcal{H}_S^{bb}$ the functional $I_h$ is weakly inf-compact on $\mathcal{R}_S$.

**PROOF.** (a) Any $\hat{g}$ in $\mathcal{G}_{\hat{S}}^{C}$ can be identified with the function $t \to \hat{g}(t, \cdot)$ from $T$ into $\mathcal{C}(\hat{S})$. This function is measurable from $(T, \mathcal{T})$ into $(\mathcal{C}(\hat{S}), \mathcal{B}(\mathcal{C}(\hat{S})))$, where $\mathcal{C}(\hat{S})$ has been equipped with the supremum norm $\|\cdot\|_{\infty}$. This fact is evident from part (ii) of the proof of Theorem 2.2. Also, it follows from that proof that $t \to \|\hat{g}(t, \cdot)\|_{\infty}$ is $\mathcal{T}$-measurable and $\mu$-integrable. We define a seminorm $\|\cdot\|_1$ on $\mathcal{G}_{\hat{S}}^{C}$ by $\|\hat{g}\|_1 := \int_{T} \|\hat{g}(t, \cdot)\|_{\infty} \mu(dt)$. By Ionescu-Tulcea (1969, VII.7) the quotient space $\hat{\mathcal{L}}/\hat{\mathcal{N}}$ is the topological dual of $(\mathcal{G}_{\hat{S}}^{C}, \|\cdot\|_1)$. That is to say, all continuous linear functionals on $\mathcal{G}_{\hat{S}}^{C}$ are of the form $\hat{g} \mapsto J_{\hat{g}}(\pi(\delta))$, $\delta \in \hat{\mathcal{L}}$. We should point out that the result referred to above is formulated with (ii) in the definition of the elements $\delta$ of $\hat{\mathcal{L}}$ replaced by $(\mathrm{ii}')$, $t \mapsto \int_{\hat{S}} c(s) \delta(t; ds)$ is $\mathcal{T}$-measurable for every $\hat{c} \in \mathcal{C}(\hat{S})$. Now (ii) and $(\mathrm{ii}')$ are equivalent: (ii) implies trivially $(\mathrm{ii}')$; $(\mathrm{ii}')$ also implies (ii), first for $\hat{B} \subset \hat{S}$ open in (ii) (apply Ash 1972, A6.6) and then for general $\hat{B} \in \mathcal{B}(\hat{S})$ (apply Ash 1972, 4.1.2). Now $\pi(\mathcal{R}_{\hat{S}}) \subset \hat{\mathcal{L}}/\hat{\mathcal{N}}$ consists precisely of all $\pi(\delta)$, $\delta \in \hat{\mathcal{L}}$, satisfying the following:

$$
J_{D, \hat{c}}(\pi(\delta)) \geqslant 0 \quad \text{for all } D \in \mathcal{T}, \hat{c} \in \mathcal{C}(\hat{S}) \text{ with } \hat{c} \geqslant 0,
$$

$$
J_{D, 1}(\pi(\delta)) = \mu(D) \quad \text{for all } D \in \mathcal{T}.
$$

Here 1 stands for $1_{\hat{S}}$. Hence $\pi(\mathcal{R}_{\hat{S}})$ is closed for the quotient topology on $\hat{\mathcal{L}}/\hat{\mathcal{N}}$. Also for every $\delta \in \mathcal{R}_{\hat{S}}$

$$
\left| J_{\hat{g}}(\pi(\delta)) \right| \leqslant \|g\|_1 \quad \text{for all } g \in G_{\hat{S}}^{C}.
$$

This demonstrates that $\pi(\mathcal{R}_{\hat{S}})$ is a subset of the unit ball of $\hat{\mathcal{L}}/\hat{\mathcal{N}}$, the topological dual of $(\mathcal{G}_{\hat{S}}^{C}, \|\cdot\|_1)$. By the Alaoglu-Bourbaki theorem (Holmes 1975, 12D) the above properties imply that $\pi(\mathcal{R}_{\hat{S}})$ is compact for the quotient topology. Since $\pi: \hat{\mathcal{L}} \to \hat{\mathcal{L}}/\hat{\mathcal{N}}$ is surjective, this proves that $\mathcal{R}_{\hat{S}}$ is weakly compact in $\hat{\mathcal{L}}$.

(b) Let $h \in \mathcal{H}_S^{bb}$ be arbitrary, with $h \geqslant \varphi$, $\varphi \in \mathcal{L}_1(T)$. Then define $\hat{h}: T \times \hat{S} \to (-\infty, +\infty]$ by

$$
\hat{h}(t, \hat{s}) := \begin{cases}
h(t, \hat{s}) &amp; \text{if } \hat{s} \in S, \\
+\infty &amp; \text{if } \hat{s} \in \hat{S} \setminus S.
\end{cases}
$$

Since $S$ belongs to $\mathcal{B}(\hat{S})$, $\hat{h}$ is $\mathcal{T} \otimes \mathcal{B}(\hat{S})$-measurable. Also, compact subsets of $S$ remain compact after embedding $S$ in $\hat{S}$ (the image of any compact set under the original homeomorphism is compact). Hence for every $t \in T$, $\beta \in \mathbb{R}$ the set $\{\hat{s} \in \hat{S}: \hat{h}(t, \hat{s}) \leqslant \beta\}$, which is equal to $\{s \in S: h(t, s) \leqslant \beta\}$, is compact in $\hat{S}$ (and in $S$). Also, $\hat{h}$ belongs to $\mathcal{G}_{\hat{S}}^{bb}$ ($= \mathcal{H}_{\hat{S}}^{bb}$). By Theorem 2.2(a), for $Z = \hat{S}$, $I_{\hat{h}}$ is weakly lower semicontinuous on $\mathcal{R}_{\hat{S}}$. By part (a) of this theorem it then follows that $I_{\hat{h}}$ is weakly inf-compact on $\mathcal{R}_{\hat{S}}$. Let $\beta \in \mathbb{R}$ be arbitrary. Define $K$ to be the set of all $\delta \in \mathcal{R}_S$ with $I_h(\delta) \leqslant \beta$, and $K$ the set of all $\pi(\hat{\delta})$, $\delta \in \mathcal{R}_{\hat{S}}$, with $J_{\hat{h}}(\pi(\hat{\delta})) \leqslant \beta$. Then by the above

---

GAMES WITH INCOMPLETE INFORMATION

$\hat{\mathcal{K}}$ is compact for the quotient topology. For any $\hat{\delta} \in \mathcal{R}_{\hat{\mathcal{G}}}$ with $\pi(\hat{\delta}) \in \hat{\mathcal{K}}$ we must have $\hat{\delta}(t; S) = 1$ for $\mu$-almost every $t \in T$, by definition of $\hat{h}$. Hence we conclude that $\pi(K) = \hat{\mathcal{K}}$. Since $\pi$ is a surjection, weak $\mathcal{R}_{\hat{\mathcal{G}}}$-compactness of $K$ follows. By Theorem 2.1 this also implies the weak compactness of $K$ (that is, as a subset of $\mathcal{R}_S$). QED

REMARK 2.4. Theorem 2.3(a) is well known in statistical decision theory and relaxed control theory (Warga 1972, IV.2.1, Castaing-Valadier 1977, V.2). Theorem 2.3(b) generalizes Prohorov's theorem in classical weak convergence theory; see Balder (1984, Remark 2.6). Theorem 2.3 continues to hold if weak compactness is replaced by sequential weak compactness; cf. Balder (1984, Theorem I). An extension of Theorem 2.3 to a nonmetrizable space $S$ can be found in Balder (1985, Theorem 2.1 and 1986b, Theorem A.7).

We now present a simple consequence of Theorem 2.2 which has not yet been included in the literature on the theory of weak convergence for transition probabilities. The analogue of this result in classical weak convergence theory is well known (Billingsley 1968, Theorem 3.2). Suppose that for $i = 1, 2$ ($T_i, \mathcal{T}_i, \mu_i$) is a finite measure space and $S_i$ a metrizable Lusin space. Anything said before about the pairs $(T, \mathcal{T}, \mu)$ and $S$ also holds for $(T_i, \mathcal{T}_i, \mu_i)$ and $S_i$. Denote by $\mathcal{R}_{Z_i}(T_i)$ the set of all transition probabilities with respect to $(T_i, \mathcal{T}_i)$ and $(Z_i, \mathcal{B}(Z_i))$, where $Z_i$ can stand for either $S_i$ or $\hat{S}_i$, $i = 1, 2$. A product mapping $(\delta_1, \delta_2) \mapsto \delta_1 \times \delta_2$ is defined by setting $(\delta_1 \times \delta_2)(t_1, t_2; B_2 \times B_2) := \delta_1(t_1; B_1)\delta_2(t_2; B_2)$.

This defines a unique probability measure $(\delta_1 \times \delta_2)(t_1, t_2; \cdot)$ on $\mathcal{B}(Z_1 \times Z_2)$ for every $(t_1, t_2) \in T_1 \times T_2$ by Ash (1972, 4.1.2). Also, by this same result $(\delta_1 \times \delta_2)(\cdot, \cdot; B)$ is seen to be $\mathcal{T}_1 \otimes \mathcal{T}_2$-measurable on $T_1 \times T_2$ for every $B \in \mathcal{B}(Z_1 \times Z_2)$. Hence $\delta_1 \times \delta_2$ belongs to the set $\mathcal{R}_{Z_1 \times Z_2}(T_1 \times T_2)$ of all transition probabilities with respect to $(T_1 \times T_2, \mathcal{T}_1 \otimes \mathcal{T}_2)$ and $(Z_1 \times Z_2, \mathcal{B}(Z_1 \times Z_2))$.

THEOREM 2.5. The product mapping $(\delta_1, \delta_2) \mapsto \delta_1 \times \delta_2$ from $\mathcal{R}_{Z_1}(T_1) \times \mathcal{R}_{Z_2}(T_2)$ into $\mathcal{R}_{Z_1 \times Z_2}(T_1 \times T_2)$ is continuous with respect to the weak topologies.

LEMMA 2.6. The linear subspace of $\mathcal{C}(\hat{S}_1 \times \hat{S}_2)$ consisting of all finite sums of pointwise products $\hat{c}_1\hat{c}_2$, $\hat{c}_i \in \mathcal{C}(\hat{S}_i)$, $i = 1, 2$, is dense in $\mathcal{C}(\hat{S}_1 \times \hat{S}_2)$ for the supremum norm.

Proof. Said subspace is obviously an algebra which contains the constant functions and separates the points of $\hat{S}_1 \times \hat{S}_2$. Since $\hat{S}_1 \times \hat{S}_2$ is compact and Hausdorff for the product topology, the result follows by the Stone-Weierstrass theorem (Choquet 1969, p. 27, Holmes 1975, 22E). QED

PROOF OF THEOREM 2.5. We first consider the case $Z_{i} = \hat{S}_{i}$, $i = 1,2$. Let $\mathcal{T}_0$ be the algebra of all finite disjoint unions of sets $D_{1}\times D_{2}$, $D_{i}\in \mathcal{T}_{i}$, $i = 1,2$. By Theorem 2.2(d) it is enough to prove that for any $D_{i}\in \mathcal{T}_{i}$, $i = 1,2$, and $\hat{c}\in \mathcal{C}(\hat{S}_1\times \hat{S}_2)$ the functional $(\hat{\delta}_1,\hat{\delta}_2)\mapsto I_{D_1\times D_2,\hat{c}}(\hat{\delta}_1\times \hat{\delta}_2)$ is weakly continuous. If $\hat{c}$ is of the product form $\hat{c}_1\hat{c}_2$, this is trivial, since we then can factorize:

$$
I _ {D _ {1} \times D _ {2}, \hat {c} _ {1} \hat {c} _ {2}} \left(\hat {\delta} _ {1} \times \hat {\delta} _ {2}\right) = I _ {D _ {1}, \hat {c} _ {1}} \left(\hat {\delta} _ {1}\right) I _ {D _ {2}, \hat {c} _ {2}} \left(\hat {\delta} _ {2}\right).
$$

Here $\hat{c}_i\in \mathcal{C}(\hat{S}_i)$, $i = 1,2$. By Lemma 2.6 there exists for any $\epsilon &gt;0$ a finite sum of pointwise products $\hat{c}_{\epsilon}$ in $\mathcal{C}(\hat{S}_1\times \hat{S}_2)$ such that $\| \hat{c} -\hat{c}_{\epsilon}\|_{\infty}\leqslant \epsilon$. Now

$$
\left| I _ {D _ {1} \times D _ {2}, \hat {c}} \left(\hat {\delta} _ {1} \times \delta_ {2}\right) - I _ {D _ {1} \times D _ {2}, \hat {c} _ {\epsilon}} \left(\hat {\delta} _ {1} \times \hat {\delta} _ {2}\right) \right| \leqslant \epsilon \mu_ {1} (D _ {1}) \mu_ {2} (D _ {2}).
$$

Since $I_{D_1 \times D_2, \hat{c}_\epsilon}(\cdot \times \cdot)$, $\epsilon &gt; 0$, is weakly continuous on $\mathcal{R}_{\hat{S}_1}(T_1) \times \mathcal{R}_{\hat{S}_2}(T_2)$ by the above, it follows that $I_{D_1 \times D_2, \hat{c}}(\cdot \times \cdot)$ which is the uniform limit as $\epsilon \to 0$ of such functionals,

---

ERIK J. BALDER

is also weakly continuous. Thus, we have proper that the product mapping is continuous form $\mathcal{R}_{\hat{S}_1}(T_1) \times \mathcal{R}_{\hat{S}_2}(T_2)$ into $\mathcal{R}_{\hat{S}_1 \times \hat{S}_2}(T_1 \times T_2)$. But then, by Theorem 2.1, it is a fortiori continuous as a function from $\mathcal{R}_{S_1}(T_1) \times \mathcal{R}_{S_2}(T_2)$ into $\mathcal{R}_{S_1 \times S_2}(T_1 \times T_2)$. This proves the theorem for the remaining case $Z_i = S_i$, $i = 1, 2$. QED

Theorem 2.5 generalizes the corresponding result of Billingsley (1968, Theorem 3.2) mentioned above. Although the result there is formulated for spaces $S_1, S_2$ that are merely separable and metric, our result still applies, since in the presence of trivial spaces $T_1, T_2$ (i.e. singletons), to which the classical weak convergence theory conforms, there is no need to suppose anything more about $S_1, S_2$ in this paper.

As was done in an earlier version of this paper, it is possible to emphasize the role of the $\rho$-uniformly continuous functions on $S$, first by including them in the characterization given in Theorem 2.2 and, secondly, by extending Lemma 2.6 to similar functions on $S_1 \times S_2$. To do so, one must require the functions on $S$ to be $\rho$-uniformly continuous, i.e. uniformly continuous with respect to the uniformity on $\hat{S}$ (one can then extend such functions to $\hat{S}$ by applying Choquet 1969, 5.20 and 6.1).

The following example shows that Theorem 2.5 may fail to hold if the measure $\mu_1 \times \mu_2$ on $T_1 \times T_2$ is replaced by a measure $\mu$ which is not absolutely continuous with respect to the product $\mu_1 \times \mu_2$ of its marginals on $T_1$ and $T_2$.

EXAMPLE 2.6. Suppose that $T_{i} = [0,1]$, $\mathcal{T}_{i} = \mathcal{R}([0,1])$, $S_{i} = \{-1,1\}$, $i = 1,2$. Let $\mu$ be the uniform measure concentrated on the diagonal of $T_{1} \times T_{2}$. Of course, the marginal $\mu_{i}$ of $\mu$ on $T_{i}$ is the uniform (Lebesgue) measure on $[0,1]$. Let $u_{1}:[0,1] \to \{-1,1\}$ be given by $u_{1}(t) := 1$ if $t \leqslant \frac{1}{2}$, $u_{1}(t) := -1$ if $t &gt; \frac{1}{2}$. We extend $u_{1}$ to $\mathbb{R}$ by periodicity with period 1, and define $u_{k}:[0,1] \to \{-1,1\}$ by $u_{k}(t) := u_{1}(kt)$. Define $\delta_{k} \in \mathcal{R}_{\{-1,1\}}([0,1])$ by setting $\delta_{k}(t; B) := 1_{B}(u_{k}(t))$; that is to say, $\delta_{k}(t; \cdot)$ is the Dirac measure concentrated at the point $u_{k}(t)$. By Theorem 2.2(d) (taking for $\mathcal{T}_0$ the usual algebra of finite disjoint unions of right-semiclosed intervals of $[0,1]$; cf. Ash 1972, 1.2.2), it is easy to verify that $\{\delta_k\}$ converges weakly in $\mathcal{R}_{\{-1,1\}}([0,1])$ to the transition probability $\delta_0$, defined by $\delta_0(t; \{-1\}) = \delta_0(t; \{1\}) = \frac{1}{2}$. However, the sequence of products $\{\delta_k \times \delta_k\}$ does not converge in $\mathcal{R}_{S_1 \times S_2}(T_1 \times T_2)$ to $\delta_0 \times \delta_0$. For instance, for $c \in \mathcal{C}(S_1 \times S_2)$ defined by $c(s_1, s_2) := s_1 s_2$ we have $I_{T_1 \times T_2, c}(\delta_k, \delta_k) = 1$ for all $k \geqslant 1$, but $I_{T_1 \times T_2, c}(\delta_0, \delta_0) = 0$.

For similar considerations in connection with differential games we refer to Warga (1972, Chapters IX, X).

3. Equilibrium results. First, we present an equilibrium result for the game with incomplete information introduced in §1. Denote by $\mathcal{R}_i$ the set of all transition probabilities with respect to $(T_i, \mathcal{T}_i)$ and $(A_i, \mathcal{B}(A_i))$, $i = 1, \ldots, n$. We suppose that each payoff function $U_i$ satisfies

$(\mathbf{C}_1^r)$ $U_{i}$ is $\mathcal{T} \otimes \mathcal{B}(A)$-measurable on $T \times A$,

$(\mathbf{C}_1^{rr})$ $U_{i}(t,\cdot)$ is continuous on $A$ for every $t\in T$,

$(\mathbf{C}_1^{rr})$ $|U_i|\leqslant \varphi_i$ on $T\times A$ for some $\varphi_{i}\in \mathcal{L}_{1}(T,\mathcal{T},\eta)$

We can then define the expected payoff functional $E_{i}\colon \mathcal{R}_{1}\times \dots \mathcal{R}_{n}\to \mathbb{R}$ for player $i$ by

$$
E _ {i} \left(\delta_ {1}, \dots , \delta_ {n}\right) := \int_ {T} \left[ \int_ {A _ {1}} \dots \int_ {A _ {n}} U _ {i} (t, a) \delta_ {1} \left(t _ {1}; d a _ {1}\right) \dots \delta_ {n} \left(t _ {n}; d a _ {n}\right) \right] \eta (d t),
$$

$i = 1,\ldots ,n$. Here we abbreviate $(t_1,\dots ,t_n)$ by $t$ and $(a_{1},\ldots ,a_{n})$ by $a$. We further impose the following condition upon the probability measure $\eta$:

$(\mathbf{C}_2)$ $\eta$ is absolutely continuous with respect to $\eta_1\times \dots \times \eta_n$

---

GAMES WITH INCOMPLETE INFORMATION

THEOREM 3.1. Suppose that $(\mathbf{C}_1) - (\mathbf{C}_2)$ hold and that for $i = 1, \ldots, n$:

$(\mathbf{C}_3)$ $A_{i}$ is a compact metric space.

Then there exists a Nash equilibrium in the behavioral strategies, i.e., there exist $\delta_i^* \in \mathcal{R}_i$ such that for $i = 1, \ldots, n$:

$$
E _ {i} \left(\delta_ {1} ^ {*}, \dots , \delta_ {n} ^ {*}\right) \geqslant E _ {i} \left(\delta_ {1} ^ {*}, \dots , \delta_ {i - 1} ^ {*}, \delta_ {i}, \delta_ {i + 1} ^ {*}, \dots , \delta_ {n} ^ {*}\right) \quad \text{for all } \delta_ {i} \in \mathcal {R} _ {i}. \tag {3.1}
$$

LEMMA 3.2 (Glicksberg 1952). Suppose that $R_{i}$ is a compact convex subset of a Hausdorff locally convex topological vector space $L_{i}$, $i = 1, \ldots, n$. Suppose also that $e_{i} \colon R_{1} \times \dots \times R_{n} \to \mathbf{R}$ is continuous and quasiconcave in each variable, $i = 1, \ldots, n$. Then there exist $r_{i}^{*} \in R_{i}$ such that for $i = 1, \ldots, n$

$$
e _ {i} \left(r _ {1} ^ {*}, \dots , r _ {n} ^ {*}\right) \geqslant e _ {i} \left(r _ {1} ^ {*}, \dots , r _ {i - 1} ^ {*}, r _ {i}, r _ {i + 1} ^ {*}, \dots , r _ {n} ^ {*}\right) \quad \text{for all } r _ {i} \in R _ {i}. \tag {3.2}
$$

Glicksberg's lemma follows immediately from the Schauder fixed point theorem for upper semicontinuous multifunctions from $R_{1} \times \dots \times R_{n}$ into itself.

PROOF OF THEOREM 3.1. Condition $(\mathbf{C}_2)$ implies, by the Radon-Nikodym theorem, that $\eta$ has a density $\psi$ with respect to $\mu \coloneqq \eta_1 \times \dots \times \eta_n$. Define $g_i(t, a) \coloneqq \psi(t) U_i(t, a)$; then $g_i$ belongs, by $(\mathbf{C}_1)$, to the set $\mathcal{G}_A^C = \mathcal{G}_A^C(T, \mathcal{T}, \mu)$ of all Carathéodory integrands on $T \times A$, and $E_i(\delta_1, \ldots, \delta_n) = I_{g_i}(\delta_1 \times \dots \times \delta_n)$, where we use the product mapping from $\mathcal{R}_1 \times \dots \times \mathcal{R}_n$ into $\mathcal{R}_A = \mathcal{R}_A(T, \mathcal{T}, \mu)$ defined in §2. For $i = 1, \ldots, n$ we define $\hat{\mathcal{L}}_i, \hat{\mathcal{N}}_i$ and $\pi_i: \hat{\mathcal{L}}_i \to \hat{\mathcal{L}}_i / \hat{\mathcal{N}}_i$ with respect to $(T_i, \mathcal{T}_i, \eta_i)$ and $(A_i, \mathcal{B}(A_i))$ as in §2. Note that in the setting of §2 one can take $S = \hat{S} = A_i$, in view of condition $(\mathbf{C}_3)$. From what was said in §2 it follows that $L_i := \hat{\mathcal{L}}_i / \hat{\mathcal{N}}_i$ is a Hausdorff locally convex topological vector space for the quotient topology, and that $R_i := \pi_i(\mathcal{R}_i)$ is a compact convex subset of $L_i$ (Theorem 2.3(a)). Now we define $e_i: R_1 \times \dots \times R_n \to \mathbf{R}$ by

$$
e _ {i} \left(\pi_ {1} \left(\delta_ {1}\right), \dots , \pi_ {n} \left(\delta_ {n}\right)\right) := E _ {i} \left(\delta_ {1}, \dots , \delta_ {n}\right) = I _ {g _ {i}} \left(\delta_ {1} \times \dots \times \delta_ {n}\right); \tag {3.3}
$$

we observe that this definition makes sense. Define $\pi \colon \mathcal{R}_1 \times \dots \times \mathcal{R}_n \to R_1 \times \dots \times R_n$ by

$$
\pi \left(\delta_ {1}, \dots , \delta_ {n}\right) := \left(\pi_ {1} \left(\delta_ {1}\right), \dots , \pi_ {n} \left(\delta_ {n}\right)\right).
$$

Since each quotient mapping $\pi_i$ is trivially open (Choquet 1969, 15.7), it is simple to see that $\pi$ is also open ($\pi(G)$ is open for any $G = G_1 \times \dots \times G_n$ with $G_i$ open in $\mathcal{R}_i$; since such $G$'s form a base for the product topology, the result follows). Also, by Theorem 2.5 and the fact that $g_i$ belongs to $\mathcal{G}_A^C$, it follows that $E_i$ is continuous on $\mathcal{R}_1 \times \dots \times \mathcal{R}_n$. From these two facts it easily follows that $e_i$ is continuous on $R_1 \times \dots \times R_n$. Finally, we note that $e_i$ is trivially affine in each of its variables. Hence, all conditions of Lemma 3.2 have been met. Now substituting (3.3) in (3.2) gives (3.1). QED

Note that we had to prove Theorem 3.1 by way of the quotient topologies, since Lemma 3.2 requires the spaces $L_{i}$ to be Hausdorff. We now present an extension of Theorem 3.1 for noncompact action spaces $A_{i}$, $i = 1,\dots ,n$. Let $\Gamma_i\colon T_i\to A_i$ be a multifunction which restricts player $i$'s behavioral strategies in the following sense: $\delta \in \mathcal{R}_i$ is said to be $\Gamma$-admissible if $\delta (t_i,\Gamma_i(t_j)) = 1$ for all $t_i\in T_i$. The set of all such $\Gamma$-admissible strategies will be denoted by $\mathcal{R}_i^\Gamma$.

THEOREM 3.3. Suppose that $(\mathbf{C}_1) - (\mathbf{C}_2)$ hold and that for $i = 1, \ldots, n$:

$(\mathbf{C}_4^{\prime})$ $A_{i}$ is a metrizable Lusin space,

$(\mathbf{C}_4^{\prime \prime})$ $\{(t_i,a_i)\in T_i\times A_i\colon a_i\in \Gamma_i(t_i)\}$ is $\mathcal{T}_i\otimes \mathcal{B}(A_i)$-measurable,

$(\mathbf{C}_4^{\prime \prime \prime})$ $\Gamma_i(t_i)$ is a compact subset of $A_{i}$ for every $t_i\in T_i$.

---

ERIK J. BALDER

Then there exists a Nash equilibrium in the $\Gamma$-admissible behavior strategies, i.e., there exist $\delta_i^* \in \mathcal{R}_i^\Gamma$ such that for $i = 1, \ldots, n$:

$$
E_i(\delta_1^*, \dots, \delta_n^*) \geq E_i(\delta_1^*, \dots, \delta_{i-1}^*, \delta_i, \delta_{i+1}^*, \dots, \delta_n^*) \quad \text{for all } \delta_i \in \mathcal{R}_i^\Gamma.
$$

PROOF. In view of the proof of Theorem 3.1 it is enough to prove that each set $\pi_i(\mathcal{R}_i^\Gamma)$ is compact (its convexity is trivial); $i = 1, \ldots, n$. Define $h_i: T_i \times A_i \to [0, +\infty]$ by

$$
h_i(t_i, a_i) := \begin{cases}
0 &amp; \text{if } a_i \in \Gamma(t_i), \\
+\infty &amp; \text{if } a_i \notin \Gamma(t_i).
\end{cases}
$$

Then $(\mathbf{C}_6^{\prime \prime})$ trivially implies that $h_i$ is $\mathcal{T}_i \otimes \mathcal{B}(A_i)$-measurable, and $(\mathbf{C}_4^{\prime \prime \prime})$ trivially implies that $h_i(t_i, \cdot)$ is inf-compact on $A_i$ for every $t_i \in T_i$. Hence, $h_i$ belongs to the class $\mathcal{H}_A^{hh} (= \mathcal{H}_A^{hh}(T_i, \mathcal{T}_i, \eta_i))$. By Theorem 2.3(b) the functional $I_{h_i}$ is weakly inf-compact on $\mathcal{R}_i$. Now for any $\delta \in \mathcal{R}_i$ we have $I_{h_i}(\delta) \leqslant 0$ if and only if $\delta_i(t_i, \Gamma(t_i)) = 1$ for $\eta_i$—almost every $t_i \in T_i$. Hence $\pi_i(\mathcal{R}_i^\Gamma) = \pi_i\{\delta \in \mathcal{R}_i: I_{h_i}(\delta) \leqslant 0\}$, which shows that $\pi_i(\mathcal{R}_i^\Gamma)$ is a compact subset of $L_i := \hat{\mathcal{L}}_i / \hat{\mathcal{N}}_i$. (Here $\hat{\mathcal{L}}_i, \hat{\mathcal{N}}_i$ and $\pi_i: \hat{\mathcal{L}}_i \to \hat{\mathcal{L}}_i / \hat{\mathcal{N}}_i$ correspond to $S = A_i$, $\hat{S} = \hat{A}_i$ as in §2.) QED

Theorem 3.3 generalizes Theorem 3.1 (to regain the latter one has to take $\Gamma_i(t_i) \coloneqq A_i$ for all $t_i \in T_i$, and impose $(\mathbf{C}_3)$). The way in which these results improve upon Theorem 1 of Milgrom and Weber (1985) has already been discussed in §1. We wish to observe that similar improvements are possible for their Theorems 2 and 4, using the theory developed in §2 as well as parts of the theory not given here (see Balder 1984a-c—for instance Milgrom-Weber 1985, Theorem 3 is considerably generalized there). We refer to Meister (1984) for an improvement of the purification result of Milgrom-Weber (1985, Theorem 4); see also Radner-Rosenthal (1982).

Next consider an extension of the saddle point equilibrium result of Mamer-Schilling (1985) (this is the main result of their paper). In the context of Theorem 3.3 we shall now work with $n = 2$ and consider a simple payoff function $U: T_1 \times T_2 \times A_1 \times A_2 \to \mathbb{R}$, for which we suppose

$(\mathbf{C}_5^{\prime})$ $U$ is $\mathcal{T}_1\otimes \mathcal{T}_2\otimes \mathcal{B}(A_1)\otimes \mathcal{B}(A_2)$-measurable,

$(\mathbf{C}_5^{\prime \prime})$ $U(t_{1},t_{2},\cdot ,a_{2})$ is upper semicontinuous on $A_{1}$ for every $t_1\in T_1$, $t_2\in T_2$, $a_2\in A_2$,

$(\mathbf{C}_5^{\prime \prime \prime})$ $U(t_{1},t_{2},a_{1},\cdot)$ is lower semicontinuous on $A_{2}$ for every $t_1\in T_1$, $t_2\in T_2$, $a_1\in A_1$,

$(\mathbf{C}_5^{\prime \prime \prime \prime})$ $|U|\leqslant \varphi$ on $T\times A$ for some $\varphi \in \mathcal{L}_1(T,\mathcal{T},\eta)$

We can define the expected utility functional $E\colon \mathcal{R}_1\times \mathcal{R}_2\to \mathbb{R}$ by

$$
E(\delta_1, \delta_2) := \int_T \left[ \int_{A_1} \int_{A_2} U(t, a) \delta_1(t_1; da_1) \delta_2(t_2; da_2) \right] \eta(dt)
$$

Here $t \coloneqq (t_1, t_2)$, $a \coloneqq (a_1, a_2)$. Instead of requiring that $\eta$ be absolutely continuous with respect to the product $\eta_1 \times \eta_2$ of its marginals, as in $(\mathbf{C}_2)$, we shall only require here

$(\mathbf{C}_6)$ $\eta$ has regular conditional probabilities with respect to each of its marginals.

Thus, $(\mathbf{C}_6)$ requires the existence of a transition probability $\eta_2^1$ with respect to $(T_1,\mathcal{T}_1)$ and $(T_{2},\mathcal{T}_{2})$ and a transition probability $\eta_1^2$ with respect to $(T_{2},\mathcal{T}_{2})$ and $(T_{1},\mathcal{T}_{1})$ such that for every $D_{i}\in \mathcal{T}_{i}$, $i = 1,2$

$$
\eta(D_1 \times D_2) = \int_{D_1} \eta_2^1(t_1; D_2) \eta_1(dt_1) = \int_{D_2} \eta_1^2(t_2; D_1) \eta_2(dt_2).
$$

---

GAMES WITH INCOMPLETE INFORMATION

A well-known sufficient condition for $(\mathbf{C}_6)$ is the following (see Dellacherie-Meyer 1975, III.69-73)

$(\mathbf{C}_7)$ $T_{i}$ is a Suslin space and $\mathcal{T}_i = \mathcal{R}(T_i), i = 1,2.$

The reader may be interested to know that, starting from $(\mathbf{C}_7)$, $(\mathbf{C}_6)$ can be proven by means of Theorem 2.3(b)—this is already evident from the proof given in Dellacherie-Meyer (1975, III.70-73).

THEOREM 3.4. Suppose that $(\mathbf{C}_4)$ (with $n = 2$), $(\mathbf{C}_5)$ and $(\mathbf{C}_6)$ hold. Then there exists a saddle point equilibrium in the $\Gamma$-admissible behavioral strategies, i.e., there exist $\delta_1^* \in \mathcal{R}_1^\Gamma$, $\delta_2^* \in \mathcal{R}_2^\Gamma$ such that

$$
E \left(\delta_ {1}, \delta_ {2} ^ {*}\right) \leqslant E \left(\delta_ {1} ^ {*}, \delta_ {2} ^ {*}\right) \leqslant E \left(\delta_ {1} ^ {*}, \delta_ {2}\right) \quad \text{for all } \delta_ {1} \in \mathcal {R} _ {1} ^ {\Gamma}, \delta_ {2} \in \mathcal {R} _ {2} ^ {\Gamma}.
$$

PROOF. Fix any $\delta_2 \in \mathcal{R}_2^\Gamma$ and define

$$
U _ {0} \left(t _ {1}, a _ {1}\right) := \int_ {T _ {2}} \left[ \int_ {A _ {1}} U \left(t _ {1}, t _ {2}, a _ {1}, a _ {2}\right) \delta_ {2} \left(t _ {2}; d a _ {2}\right) \right] \eta_ {2} ^ {1} \left(t _ {1}; d t _ {2}\right).
$$

We claim that $-U_{0}$ belongs to $\mathcal{G}_{A_1}^{bb} = \mathcal{G}_{A_1}^{bb}(T_1,\mathcal{T}_1,\eta_1)$. Indeed, for every $t_1\in T_1$, $-U_{0}(t_{1},\cdot)$ is lower semicontinuous on the (metric) space $A_{1}$ by Fatou's lemma, thanks to $(\mathbf{C}_5)$ (note that $\varphi$ in $(\mathbf{C}_5^{\prime \prime \prime \prime})$ is such that $\varphi (t_1,\cdot)$ is integrable with respect to $\eta_2^1 (t_1;\cdot)$ for $\eta_{1}$—almost every $t_1\in T_1$ (Ash 1972, 2.6.4)). Also, $\mathcal{T}_1\times \mathcal{R}(A_1)$-measurability of $-U_{0}$ follows from the same result. Finally, $-U_{0}(t_{1},a_{1})\geqslant \varphi_{1}(t_{1})$ with $\varphi_{1}(t_{1})\coloneqq \int_{T_{1}}\varphi (t_{1},t_{2})\eta_{2}^{1}(t_{1};dt_{2})$, and $\varphi_{1}$ is $\eta_{1}$-integrable, again by Ash (1972, 2.6.4). Hence we conclude by Theorem 2.2(a) that $E(\cdot ,\delta_2)(= I_{-U_0})$ is weakly upper semicontinuous on $\mathcal{R}_1^\Gamma$ for any $\delta_2\in \mathcal{R}_2^\Gamma$. Completely symmetrically it follows that $E(\delta_1,\cdot)$ is weakly lower semicontinuous on $\mathcal{R}_2^\Gamma$ for any $\delta_1\in \mathcal{R}_1^\Gamma$. In both cases we are dealing with affine functionals. We can now finish by going to the quotient sets $\pi_i(\mathcal{R}_i^\Gamma)$—these were shown to be compact in proving Theorem 3.3—and applying Sion's minimax theorem (Sion 1958). (Recall that we go to the quotient sets since $\hat{\mathcal{L}}_i$ need not be Hausdorff, unlike $L_{i}\coloneqq \hat{\mathcal{L}}_{i} / \hat{\mathcal{N}}_{i}$.) The details of this procedure have already been discussed in proving Theorem 3.1, and will not be repeated here. QED

Theorem 3.4 generalizes the equilibrium result of Mamer and Schilling (1986) in a number of ways: (i) $(\mathbf{C}_4)$ deals with non-compact action spaces. (ii) $(\mathbf{C}_5^{\prime \prime})$ and $(\mathbf{C}_5^{\prime \prime \prime})$ are less restrictive than their corresponding continuity conditions. (iii) $(\mathbf{C}_5^{\prime \prime \prime \prime})$ is less restrictive than their uniform boundedness condition. (iv) $(\mathbf{C}_7)$ is more general than their condition that $T_{1}, T_{2}$ be Polish spaces (i.e., separable complete and metric).

Of course, Theorem 3.3 is by no means the only kind of saddle point equilibrium result that can be obtained in this way. For instance, another possibility would be to use the minimax theorem of Ha (1980, Theorem 4). This would require us to replace $(\mathbf{C}_5^{\prime \prime \prime})$ by a joint lower semicontinuity condition for $U(t_{1},t_{2},\cdot ,\cdot)$, and $(\mathbf{C}_5^{\prime \prime \prime \prime})$ by merely requiring $U\geqslant \varphi$ for some $\varphi \in \mathcal{L}_1(T,\mathcal{T},\eta)$. However, instead of $(\mathbf{C}_6)$ we would have to impose $(\mathbf{C}_2)$ once more, etc.

We shall leave such exercises to the interested reader. We hope that the results and the remarks given in this paper have convinced him of the value of the weak convergence apparatus for the study of equilibrium questions.

Acknowledgement. I wish to thank the referees for encouraging me to improve the presentation of my results. I am also indebted to L. Billera for sending me a preprint of Mamer-Schilling (1986).

---

276
ERIK J. BALDER

## References

[1] Ash, R.B. (1972). *Real Analysis and Probability*, Academic Press, New York.

[2] Balder, E.J. (1979). On a Useful Compactification for Optimal Control Problems. *J. Math. Anal. Appl.* **72** 391–398.

[3] ______. (1984a). A General Approach to Lower Semicontinuity and Lower Closure in Optimal Control Theory. *SIAM J. Control Optim.* **22** 570–598.

[4] ______. (1984b). A Unifying Note on Fatou’s Lemma in Several Dimensions. *Math. Oper. Res.* **9** 267–275.

[5] ______. (1984c). A General Denseness Result for Relaxed Control Theory. *Bull. Austral. Math. Soc.* **30** 463–475.

[6] ______. (1985). An Extension of Prohorov’s Theorem for Transition Probabilities with Applications to Infinite—Dimensional Lower Closure Problems. *Rend. Circ. Mat. Palermo* (II) **34** 427–447.

[7] ______ (1986a). On Weak Convergence Implying Strong Convergence in $L_1$-Spaces. *Bull. Austral. Math. Soc.* **33** 363–368.

[8] ______. (1986b). Fatou’s Lemma in Infinite Dimensions. Preprint no. 423, Department of Mathematics, University of Utrecht. *J. Math. Anal. Appl.* (to appear).

[9] Billingsley, P. (1968). *Convergence of Probability Measures*. Wiley, New York.

[10] Castaing, C. and Valadier, M. (1977). Convex Analysis and Measurable Multifunctions, *Lecture Notes in Mathematics* **580**, Springer-Verlag, Berlin.

[11] Choquet, G. (1969). *Lectures on Analysis*. Benjamin, Reading, Mass.

[12] Dellacherie, C. and Meyer, P.-A. (1975). *Probabilities and Potential*. Hermann, Paris. English transl. North-Holland, Amsterdam.

[13] Glicksberg, I. (1952). A Further Generalization of Kakutani’s Fixed Point Theorem with Applications to Nash Equilibrium Points. *Proc. Nat. Acad. Sci. U.S.A.* **38** 170–172.

[14] Ha, C.-W. (1980). Minimax and Fixed Point Theorems. *Math. Ann.* **248** 73–77.

[15] Harsanyi, J.C. (1967-68). Games with Incomplete Information Played by Bayesian Players. *Management Sci.* **14** 159–182, 320–334, 486–502.

[16] Holmes, R.B. (1975). *Geometric Functional Analysis and Its Applications*. Springer-Verlag, Berlin.

[17] Ionescu-Tulcea, A. and C. (1969). *Topics in the Theory of Lifting*. Springer-Verlag, Berlin.

[18] Jacod, J. and Memin, J. (1981). Sur un type de convergence intermédiaire entre la convergence en loi et la convergence en probabilité. Séminaire de Probabilités XV. *Lecture Notes in Mathematics* **850**, Springer-Verlag, Berlin, 529–546.

[19] LeCam, L.M. (1955). An Extension of Wald’s Theory of Statistical Decision Functions. *Ann. Math. Statist.* **26** 69–81.

[20] LeCam, L.M. (1957). La structure de l’espace des règles de décision. Observations prises en une seule étape. Unpublished manuscript. Department of Statistics, University of California, Berkeley.

[21] Mamer, J.W. and Schilling, K.E. (1986). A Zero-Sum Game with Incomplete Information and Compact Action Spaces, *Math. Oper. Res.* **11** 627–631.

[22] McShane, E.J. (1940). Generalized Curves. *Duke Math. J.* **6** 513–536.

[23] Meister, H. (1984). On the Existence of Approximate Equilibrium in Pure Strategies for a Game with Incomplete Information. Preprint, Fernuniversität Hagen.

[24] Mertens, J.-F. and Zamir, S. (1985). Formulation of Bayesian Analysis for Games with Incomplete Information. *Internat. J. Game Theory* **14** 1–29.

[25] Milgrom, P.R. and Weber, R.J. (1985). Distributional Strategies for Games with Incomplete Information. *Math. Oper. Res.* **10** 619–632.

[26] Neveu, J. (1964). *Mathematical Foundations of Probability Theory*. Masson, Paris. English transl. Holden-Day, San Francisco.

[27] Radner, R. and Rosenthal, R.W. (1982). Private Information and Pure-Strategy Equilibria. *Math. Oper. Res.* **7** 401–409.

[28] Renyi, A. (1963). On Stable Sequences of Events. *Sankhya Ser. A.* **25** 293–302.

[29] Sion, M. (1958). On General Minimax Theorems. *Pacific J. Math.* **8** 171–176.

[30] Wald, A. (1950). *Statistical Decision Functions*. Wiley, New York.

[31] Warga, J. (1962). Relaxed Variational Problems. *J. Math. Anal. Appl.* **4** 111–128.

[32] ______. (1972). *Optimal Control of Differential and Functional Equations*. Academic Press, New York.

[33] Young, L.C. (1969). *Lectures on the Calculus of Variations and Optimal Control Theory*. Saunders, Philadelphia.

MATHEMATICAL INSTITUTE, UNIVERSITY OF UTRECHT, BUDAPESTLAAN 6, P.O. BOX 80.010, 3508 TA UTRECHT, NETHERLANDS

---

Copyright 1988, by INFORMS, all rights reserved. Copyright of Mathematics of Operations Research is the property of INFORMS: Institute for Operations Research and its content may not be copied or emailed to multiple sites or posted to a listserv without the copyright holder's express written permission. However, users may print, download, or email articles for individual use.