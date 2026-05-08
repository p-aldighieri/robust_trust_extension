International Journal of Game Theory, Vol. 15, Issue 4, page 237–250

# The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions¹

By J.-F. Mertens²

## 1 Introduction

Our aim is to get a “general minimax theorem” whose assumptions and conclusions are phrased only in terms of the data of the problem, i.e. the pair of pure strategy sets $S$ and $T$ and the payoff function on $S \times T$. For the assumptions, this means that we want to avoid any assumption of the type “there exists a topology (or a measurable structure) on $S$ and (or) $T$ such that ...”. For the conclusions, we are led to require that players have $e$-optimal strategies with finite support, both because those are the easiest to describe in intrinsic terms, and because in any game where the value would not exist in strategies with finite support, all known general minmax theorems implicitly select as “value” either the sup inf or the inf sup by in effect restricting either player I or player II arbitrarily to strategies with finite support — so that the resulting “value” is completely arbitrary and misleading.

Those points are discussed in more detail in Section 3, after having proved a first theorem in Section 2.

## 2 A First Theorem

**Minmax Theorem**: A two person zero sum game with compact strategy spaces has a value and each player has $e$-optimal strategies with finite support if each player’s payoff is, for any fixed strategy of his opponent, an uppersemicontinuous (u.s.c.) function of his strategy, and is bounded either from above or from below. (In this section, “compact” means compact and Hausdorff.)

**Proof**: Let $f$ denote the first player’s payoff function, $S$ his strategy space, and $T$ his opponent’s strategy space. For any pair of mixed strategies $\sigma$ and $\tau$, we will denote by $f(\sigma, \tau)$ the expectation of $f$ under the corresponding product measure, whenever this expectation is unambiguously defined (via Fubini’s theorem).

---

¹ This research was supported in part by the National Science Foundation Grant SES 8201373 and in part by the Office of Naval Research Contract ONR-N00014-79-C-0685 at the Institute for Mathematical Studies in the Social Sciences, Stanford University.

² Jean-François Mertens, CORE, 34 Voie du Roman Pays, B-1348 Louvain La Neuve, Belgium.

0020-7276/86/04237-250 $2.50 © 1986 Physica-Verlag, Heidelberg, Wien

---

238 J.-F. Mertens

A function $f$ on a compact space $K$ is u.s.c. if and only if $f \colon K \to R \cup \{-\infty\}$ and $\forall \alpha \in R, \{x \mid f(x) \geqslant \alpha\}$ is closed, or equivalently, if and only if $f$ is the pointwise limit of a decreasing net of continuous real valued functions on $K$. $f$ is lowersemicontinuous (l.s.c.) if and only if $-f$ is u.s.c. Remark that if $f$ is l.s.c., then $f$ is bounded from below, so each player guarantees himself a finite payoff with any pure strategy.

The proof starts by proving particular cases of the statement; the first of them is standard and is just recalled for the reader's convenience.

(A) Case where $S$ or $T$ – say $T$ – is finite (Von Neumann).

*Proof:* Let $T = \{t_1, \ldots, t_n\}$ and let $C$ denote the closed convex set $\{x \in R^n \mid \exists \sigma \text{ probability on } S \text{ (with } \# \operatorname{Supp}(\sigma) \leqslant n \text{ (Caratheodory)): } \forall i, \int f(s, t_i) d\sigma(s) \geqslant x_i\}$. Let $v = \max_{x \in C} \min_{i} x_i$; then $\forall \epsilon &gt; 0 \text{ (with } e = (1, 1, \ldots, 1) \in R^n) [C - (v + \epsilon)e] \cap R_+^n = \emptyset$, so that for a separating hyperplane $(\lambda_1, \ldots, \lambda_n)$ we have $\sup_{y \in C - (v + \epsilon)e} \langle \lambda, y \rangle &lt; 0, \lambda_i \geqslant 0$, and also by normalizing $\sum \lambda_i = 1$: player II has a strategy $\lambda$ such that $\forall x \in C, \langle \lambda, x \rangle \leqslant v + \epsilon$. When $\epsilon \to 0$, we get by compactness a strategy $\lambda: \langle \lambda, x \rangle \leqslant v, \forall x \in C$.

(B) *Corollary:* Let $T$ be an arbitrary set, $f(s,t)$ u.s.c. on $S$ for each $t \in T$. Then $\max_{\sigma} \inf_{\tau} f(\sigma,\tau) = \inf_{\tau} \max_{\sigma} f(\sigma,\tau)$, where $\sigma$ ranges over all regular Borel probabilities on $S$ and $\tau$ over all probabilities with finite support on $T$.

*Proof:* For any finite subset $\tilde{T}$ of $T$, let $\sum_{\epsilon, \tilde{T}}$ denote the set of $\sigma$'s satisfying $\inf_{t \in \tilde{T}} f(\sigma, t) \geqslant \inf_{\tau} \max_{\sigma} f(\sigma, \tau) - \epsilon$. By (A), the $\sum_{\epsilon, \tilde{T}}$ form a decreasing net of non-empty weakly compact sets, so have a non-empty intersection. Any $\sigma_0$ in the intersection yields $\inf_{\tau} f(\sigma_0, \tau) = \inf_{\tau} \max_{\sigma} f(\sigma, \tau)$.

(C) Case where one of the strategy spaces – say $T$ – is metrisable.

(i) *Claim:* $f$ is Borel measurable.

Let $\phi_1, \phi_2, \phi_3, \ldots$ be a dense sequence of continuous functions on $T$.

Denote by $S_i$ the closed set $\{s \mid \forall t \in T, f(s, t) \geqslant \phi_i(t)\}$, and let $\psi_i(s, t) = \phi_i(t)$ for $s \in S_i, = -\infty$ otherwise. Obviously $\psi_i$ is Borel measurable, and therefore also $f = \sup_i \psi_i$.

(ii) Denote by $\Sigma$ (resp. $\mathsf{T}$) the space of regular Borel probabilities on $S$ (resp. $T$), and by $\Sigma_f$ (resp. $\mathsf{T}_f$) the probabilities with finite support.

$f$ being Borel measurable and bounded either from above or from below, $f(\sigma, \tau)$ is well defined on $\Sigma \times \mathsf{T}$.

By (B), there exist $\tilde{v} \in R$ and $\sigma_0 \in \Sigma$ such that

$$
f(\sigma_0, t) \geqslant \tilde{v} = \inf_{\tau \in \top_f} \sup_{\sigma \in \Sigma_f} f(\sigma, \tau) \quad \forall t \in T
$$

---

The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions

and there exist  $\mathfrak{v} \in \mathbb{R}$  and  $\tau_0 \in \mathbb{T}$  such that

$$
f (s, \tau_ {0}) \leqslant \mathfrak {v} = \sup  _ {\sigma \in \Sigma_ {f}} \inf  _ {\tau \in \mathsf {T} _ {f}} f (\sigma , \tau) \quad \forall s \in S.
$$

On the one hand, one has always  $\mathfrak{v} = \sup \inf \leqslant \inf \sup = \bar{\mathfrak{v}}$ , on the other hand one gets  $f(\sigma_0, \tau_0) = \int f(\sigma_0, t) d\tau_0(t) \geqslant \bar{\mathfrak{v}} \geqslant \mathfrak{v} \geqslant \int f(s, \tau_0) d\sigma_0(s) = f(\sigma_0, \tau_0)$ , and thus the desired equality  $\mathfrak{v} = \bar{\mathfrak{v}}$ .

(D) General Case

(i) Construction of a countable set of best replies

Let  $\bar{v} = \inf_{\mathsf{T}_f}\sup_{\Sigma_f}f(\sigma ,\tau)$ , and let  $\mathsf{T}_n$  denote those  $\tau \in \mathsf{T}_f$  with  $\# \operatorname {Supp}(\tau)\leqslant n$ . Denote also by  $\bar{F}$  the set of continuous functions  $\phi$  on  $T$  for which there exists  $s\in S$  such that  $f(s,t)\geqslant \phi (t)\forall t\in T$ : then  $\bar{v}\leqslant \inf_{\tau \in \mathsf{T}_n}\sup_{\phi \in \bar{\Gamma}}\int \phi d\tau$ .

$$
\forall \phi \in \bar {F}, \quad \text {let} \quad 0 _ {\phi , k, n} = \left\{\tau \in \mathsf {T} _ {n} | \int \phi d \tau &gt; \bar {v} - \frac {1}{k} \right\}.
$$

The  $0_{\phi, k, n}$  form, for each fixed  $k$  and  $n$ , an open covering of the compact space  $\mathsf{T}_n$ . Let  $\Phi_{k,n}$  denote a finite subset of  $\bar{\mathsf{F}}$  such that  $\bigcup_{\phi \in \Phi_{k,n}} 0_{\phi, k, n} = \mathsf{T}_n$ .

Then  $\Phi = \bigcup_{k,n}\Phi_{k,n}$  is a countable subset of  $\bar{F}$ , such that  $\bar{v} = \inf_{\tau \in \mathsf{T}_f}\sup_{\phi \in \Phi}\int \phi d\tau$

(ii) Reduction to Case (C)

If  $\phi_i$  enumerates  $\Phi$ , let  $d(t_1, t_2) = \sum_{i} 2^{-i} |\phi_i(t_1) - \phi_i(t_2)| / \| \phi_i \|$ .  $d$  defines a metrisable quotient space  $\tilde{T}$  of  $T$ , such that, if  $\psi$  denotes the quotient mapping, any  $\phi \in \Phi$  can be written as  $g \circ \psi$ , for some  $g \in C(\tilde{T})$  - where, for some  $s \in S$ ,  $(g \circ \psi)(t) \leqslant f(s, t)$ $\forall t \in T$ . Let  $\Psi$  denote the set of all  $g \in C(\tilde{T})$  having this property.

Define  $\tilde{f}$  on  $S\times \tilde{T}$  by  $\tilde{f} (s,\tilde{t}) = \sup \{g(\tilde{t})|g\in C(\tilde{T}),(g\circ \psi)(\cdot)\leqslant f(s,\cdot)\}$ . Then, from (i),  $\bar{v} = \inf_{\tau \in \mathsf{T}_f}\sup_{\phi \in \Phi}\int \phi d\tau \leqslant \inf_{\tau \in \mathsf{T}_f}\sup_{g\in \Psi}\int (g\circ \psi)(t)d\tau (t)\leqslant \inf_{\tilde{\tau}\in \tilde{\mathsf{T}}_f}\sup_{s\in S}\int \tilde{f} (s,\tilde{t})d\tilde{\tau} (\tilde{t})$ . Obviously  $\tilde{f}$  is l.s.c. on  $\tilde{T}$  for each  $s\in S$ , and is the largest such function satisfying  $\tilde{f} (s,\psi (t))\leqslant f(s,t)$ .

Let  $h(s, \tilde{t}) = \inf \{f(s, t) | t \in \psi^{-1}(\tilde{t})\}$ : if we show that  $h(s, \tilde{t})$  is l.s.c. on  $\tilde{T}$  for each  $s \in S$ , it will follow that  $\tilde{f} = h$ , and therefore that  $\tilde{f}$  is also u.s.c. on  $S$  for each  $\tilde{t} \in \tilde{T}$  - as an infimum of u.s.c. functions.

Since  $\tilde{T}$  is metrisable, denote by  $\tilde{t}_i$  a sequence converging to  $\tilde{t}_{\infty}$ . Choose  $t_i \in T$  such that  $\psi(t_i) = \tilde{t}_i$  and  $f(s, t_i) \leqslant h(s, \tilde{t}_i) + 1 / i$ , and let  $t_{\infty}$  be a limit point of  $t_i$ : we have  $\psi(t_{\infty}) = \tilde{t}_{\infty}$ , and  $h(s, \tilde{t}_{\infty}) \leqslant f(s, t_{\infty}) \leqslant \lim_{i \to \infty} \inf f(s, t_i) \leqslant \lim_{i \to \infty} \inf h(s, \tilde{t}_i)$  - hence the result.

---

240 J.-F. Mertens

(iii) Conclusion

$\tilde{f}$ on $S \times \tilde{T}$ satisfies all assumptions of (C), and from (ii) we have $\tilde{f}(s, \psi(t)) \leqslant f(s, t)$ and $\tilde{v} \leqslant \inf_{\tilde{T} \in \tilde{T}_f} \sup_{s \in S} \int \tilde{f}(s, \tilde{t}) d\tilde{\tau}(\tilde{t})$.

From (C), we know therefore that

$$
\tilde{v} \leqslant \sup_{\sigma \in \Sigma_f} \inf_{t \in \tilde{T}} \int \tilde{f}(s, \tilde{t}) d\sigma(s) \leqslant \sup_{\sigma \in \Sigma_f} \inf_{t \in T} f(\sigma, t),
$$

which completes the proof, the reverse inequality being obvious.

## 3 Comments on the Present Result

(i) The compactness assumption on both sides is really needed, as the following example due to H. Kuhn shows (private communication through R. J. Aumann, example originates from Kuhn’s “Lecture Notes in Game Theory” [~1949], unpublished).

Player I picks a number $x$ in $[0, 1]$, and player II chooses a continuous function $\psi$ from $[0, 1]$ to itself with $\int \psi(t) dt = 1/2$. The payoff is $\psi(x)$. Then player I can guarantee $1/2$ by choosing $x$ uniformly distributed and player II by taking $\psi(t) = 1/2 \forall t$. But for any strategy of I with finite support, player II can choose an appropriate $\psi$ that vanishes on the support — so player I cannot guarantee more than zero using strategies with finite support.

Remark here that if player II’s strategy space is endowed with the uniform topology, we have a compact metric strategy space for player I, and a complete separable metric one for II, and the payoff is uniformly bounded and a uniformly continuous function of player II’s strategy — in particular it is jointly continuous on $S \times T$: even with much stronger assumptions everywhere else, just the failure of the compactness assumption on one side makes the theorem break down.

(ii) Two directions of extension seem conceivable:

- The first would rely on some idea that our whole line of proof, of reducing oneself to some case where Fubini’s theorem could be applied, is artificial, and that Fubini’s theorem is irrelevant for this problem. In that case, one ought to be able to remove from the assumptions the last trace of Fubini’s theorem — i.e. that the payoff function be uniformly bounded either from below or from above, and one might try to extend this to some “intrinsic” setting, i.e. essentially drop the assumption that the strategy spaces are Hausdorff, and just ask, using Alexander’s subbase theorem, that the family of sets $S_{t,\alpha} = \{s \in S \mid f(s, t) \geqslant \alpha\} (t \in T, \alpha \in \underline{R})$ has the finite intersection property, and similarly for Player II.

- The other direction would on the contrary look at Fubini’s theorem as being basic, and consider that the “good” minmax theorem is the corollary sub (B) in the proof (from which all other minmax statements are easily obtained as corollaries — cfr. Section 4). So one would try to show that, for any payoff function satisfying the assumptions of the theorem, Fubini’s theorem applies for any product of regular Borel

---

The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions

measures. Then the theorem would become an immediate corollary of the statement sub (B). Furthermore, this would be a much more flexible tool, in conjunction with the methods mentioned in Section 4, using the stability properties of the set of functions that are measurable for any product of tight probabilities (pointwise limits, algebraic operations, composition, etc.).

The best result we know in this direction requires however, $f(s, t)$ to be continuous in each variable separately (and implies then, whenever $S$ and $T$ are Hausdorff spaces, that $f$ is measurable for any tight probability on $S \times T$ — cf. Bourbaki (1959, § 2, ex. 26)). It is by the way the basic idea of a fundamental lemma underlying this theorem (that points in the closure of some set in $C(K)$ are already in the closure of some countable subset of it) that we have used in part (D) (i) of the proof.

(iii) Motivations for this type of theorem are multiple.

(a) There is first the aesthetic motivation of obtaining the minmax theorem for mixed strategies under such assumptions that, by just adding the quasi-concavity-quasi-convexity assumption, one obtains Sion's assumptions for the existence of pure strategy solutions (adding a boundedness assumption to Sion's does not weaken his theorem).

(b) There is also the "effectiveness" point of view, that only discrete random variables can be effectively generated in finite time. (Any such discrete r.v. can be generated with a fair coin, by generating by successive tosses the successive bits of some random number $x(0 \leqslant x &lt; 1)$, stopping as soon as it is clear that, for some $n$, $\sum_{i &lt; n} p_i \leqslant x &lt; \sum_{i \leqslant n} p_i$

and deciding then in favor of the $n$-th outcome: clearly a decision will be reached a.s. in finite time, and the $n$-th outcome will have probability $p_n$. This procedure can even be used with a biased coin, with unknown bias, by counting a pair of successive tosses as one unit, giving a bit of "1" if first heads, then tails, a bit of "0" if first tails, then heads, and being inconclusive otherwise, in which case one should look to the next pair.)

It follows then that, for an operational concept of value, the players should be able to construct $\epsilon$-optimal strategies where, in each information set, they are restricted to discrete mixtures.

In particular, for general minmax theorems, for normal form games, which may represent games with a single information set, one is led to the requirement of $\epsilon$-optimal discrete mixtures. Under our assumptions, the players have $\epsilon$-optimal finite mixtures, and the guaranteed payoff varies continuously with the probability vector used, so in any realistic model the player can play $\epsilon$-optimally, even in bounded time.

(c) More important is the "safety" consideration, that, even neglecting the above, the player should always consider that his opponent might have an infinity of information sets at his disposal, or some analog device such as a continuous roulette wheel, and thus would be able to generate continuous random variables. In such a case, the evaluation of the expected payoff (even if players agree on some compact topologies on $S$ and $T$, and to use only integration theory for regular Borel measures on compact spaces) would depend on the order of integration — except if one knows in addition that Fubini's theorem holds for the payoff function. For instance, players may think that the corollary sub (B) in the proof is the good minmax theorem; given a payoff

---

242 J.-F. Mertens

function that would satisfy those assumptions for both players, player I might find an optimal strategy that “guarantees” him +1, and similarly, player II applying the same corollary for him might find an optimal strategy that “guarantees” to him that the payoff will not exceed −1. Obviously, realizing this, both players can only conclude that the only thing they really can guarantee, is what they can guarantee with mixtures with finite support. Since “−1” is always ≤ to “+1” this argument is perfectly general. (By our theorem, one could, in this example, have a strict inequality only for unbounded payoff functions; but still, the theorem is needed for that, and anyway the argument remains, since it depends only on the weak inequality −1 ≤ +1.)

And things can be much worse, because nothing compels the player to agree on some integration theory — or even on some topology for the strategy spaces. You could even happen to be playing against Dubins and Savage (1965), using finitely additive randomizations. In such cases only finite mixtures remain safe, unambiguous, and devoid of arbitrarines (i.e. only such a solution depends only on the data of the problem, i.e. the pure strategy sets — as sets — and the payoff function — as a real valued function on the product of the pure strategy sets).

(d) The proof shows that the result is much easier to get for compact metric spaces. Is it really worthwhile to make a substantially bigger effort in order to get rid of the metrisability assumption?

A first answer would be that this simplifies the statement of the theorem (one can drop “metric”), and that any effort in a proof is worthwhile if it leads to a simpler (and more powerful) theorem.

A much more important reason is, however, that, in any game where a continuous variable can be observed before some action is taken, the strategy spaces are non-metrisable. Certainly one does not want to exclude such models from game theory. Besides the obvious cases (observation of a price, or a quantity, or a continuous random variable), this would also exclude any differential game (time being a continuous variable) and any game with a continuum of players (just to define its characteristic function, one needs the value of a zero sum game between two opposing coalitions, where the strategy space of each coalition, as an uncountable product, cannot be metrisable). Those problems are amply documented in the literature; for instance, R. J. Aumann (1964) suggests the use of behavioral strategies to get around this type of problem; in other contexts (differential games, games with a continuum of players, etc.) various other restrictions are imposed on the strategy sets.

Besides the inconvenience of requiring additional structure (a topology, or a measurable structure), as was discussed in the previous point, such procedures have the unpleasant feature of restricting the strategy space — for instance, an arbitrary pure strategy is not necessarily a behavioral strategy, since it may lack the measurability requirement. For a minmax theorem, it is of course a net gain if one can show that some player’s (ε)-optimal strategies have in fact some additional regularity property; however, it is disturbing when it is only shown the strategy is safe against some subclass of the opponent’s strategies. Indeed, the opponent should ideally not even be assumed to follow a strategy, — he is just playing — and one would like the minmax theorem to have essentially the same force as in the perfect information case i.e. that any “play” consistent with your ε-optimal strategy yields a payoff ≥ v − ε.

---

The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions

# 4 Other Minmax Theorems

## A Measure Theory (non-Hausdorff compact spaces)

For any compact space $S$, denote by $C$ the convex cone of bounded l.s.c. functions on $S$, and let $E = C \setminus C$. Denote by $P$ the set of monotonic real valued sublinear (i.e. positively homogeneous of degree 1 and subadditive ($p(x + y) \leqslant p(x) + p(y)$)) functions on $C$. $P$ is ordered in the usual way ($p_1 \leqslant p_2$ iff $p_1(f) \leqslant p_2(f) \forall f \in C$).

**Definition**: $M(S)$ is the set of minimal elements of $P$.

**Lemma 1**: $\forall p \in P, \exists \mu \in M(S): \mu \leqslant p$.

**Proof**: $\forall p \in P, \forall f \in C$ let $\alpha \leqslant 0$ be such that $f \geqslant \alpha$. Then $\forall q \in P$ s.t. $q \leqslant p: p(f) \geqslant q(f) \geqslant q(\alpha) \geqslant -q(-\alpha) \geqslant -p(-\alpha)$, so set of possible values $q(f)$ is a bounded interval. Zorn's lemma then yields a minimal such $q$.

**Lemma 2**: Any $\mu \in M(S)$ can be identified with a positive linear functional on $E$ satisfying

$$
\mu(f) = \inf \{\mu(g) | g \in C, g \geqslant f\} \quad \forall f \in E.
$$

**Proof**: Let $\tilde{\mu}: E \to R$ be defined by the above formula. Clearly $\tilde{\mu}$ is real valued (if $f \geqslant \alpha$, then $\tilde{\mu}(f) \geqslant \tilde{\mu}(\alpha) \geqslant \mu(\alpha) &gt; -\infty$). Further, $\tilde{\mu}$ is obviously monotonic and sublinear, coinciding with $\mu$ on $C$.

The Hahn-Banach theorem says that any such $\tilde{\mu}$ is the supremum of a family of linear functionals. Any linear functional $\xi \leqslant \tilde{\mu}$ is positive, because $\leqslant 0$ on the negative functions. If there was a second such $\xi$, say $\tilde{\xi}$, one would have $\xi(f) \neq \tilde{\xi}(f)$ for some $f \in C$. Then either $\xi$ or $\tilde{\xi}$, restricted to $C$, would be some element of $P \leqslant \mu$, and $\neq \mu$, thus $\mu$ would not be minimal. Therefore this $\xi$ is unique, and thus coincides with $\tilde{\mu}: \tilde{\mu}$ is a positive linear functional on $E$.

**Lemma 3**: $M(S)$ is the set of positive linear functionals $\mu$ on $E$ such that

$$
\forall f \in C, \quad \mu(-f) = \inf \{\mu(g) | g \in C, g \geqslant -f\}.
$$

**Proof**: One direction is given by Lemma 2. In the other direction, we have clearly $\mu \in P$, thus (Lemma 1) $\exists \nu \in M(S): \nu(h) \leqslant \mu(h) \forall h \in C$. Thus $\nu(-f) \geqslant \mu(-f) = \inf \{\mu(g) | g \in C, g \geqslant -f\} \geqslant \inf \{\nu(g) | g \in C, g \geqslant -f\} = \nu(-f)$ (by Lemma 2), from which the equality of $\mu$ and $\nu$.

**Lemma 4**: $M(S)$ is the set of regular Borel measures on $S$, i.e. the set of positive, bounded, countably additive measures on the Borel sets of $S$ satisfying $\mu(A) = \sup \{\mu(F) | F \subseteq A, F \text{ closed}\} = \inf \{\mu(0) | 0 \supseteq A, 0 \text{ open}\}$ for any $\mu$-measurable set $A$.

---

244 J.-F. Mertens

Proof: Follows from a standard Daniell-type extension procedure. We sketch just a typical sequence of steps:

- Denote by LSC the set of l.s.c. functions with values in $R \cup \{+\infty\}$, and USC = -LSC.

Let $\mu_1(f) = \sup \{\mu(g) \mid -g \in C, g \leqslant f\} \quad \forall f \in \mathrm{LSC}$

Let $\mu^*(f) = \inf \{\mu_1(g) \mid g \in \mathrm{LSC}, g \geqslant f\}$ for any extended real-valued $f$.

- Lemma 2 implies $\mu^{*} = \mu$ on $E$, and $\mu^{*} = \mu_{1}$ on LSC.

- Dini’s theorem implies that, if $f_{\alpha} \in \mathrm{LSC}$ is filtering increasing, then

$$
\mu^ {*} (\lim  f _ {\alpha}) = \lim  \mu^ {*} (f _ {\alpha}).
$$

- It follows that $\mu^{*}(f + g) = \mu^{*}(f) + \mu^{*}(g)$ on LSC.

- The sublinearity of $\mu^{*}$ follows (avoiding $(+\infty) + (-\infty)$ right-hand members, and using the convention $(0) \cdot (\infty) = 0$).

- Finally one gets: if $h_n$ is any increasing sequence, with $\lim \mu^*(h_n) &gt; -\infty$, then $\mu^*(\lim h_n) = \lim \mu^*(h_n)$. (It is sufficient to consider $\mu^*(h_n)$ finite; choose $f_n \in \mathrm{LSC}$, $f_n \geqslant h_n$, $\mu^*(f_n) \leqslant \mu^*(h_n) + \epsilon \cdot 2^{-n}$.) Let $\psi_n = \sup_{i \leqslant n} f_i$. $\psi_n$ is an increasing sequence in LSC such that $\psi_n \geqslant h_n$. $\psi_n = \max (\psi_{n - 1}, f_n)$ implies $\mu^*(\psi_n) + \mu^*(h_{n - 1}) \leqslant \mu^*(\psi_n) + \mu^*(\min (f_n, \psi_{n - 1})) = \mu^*(\psi_n + \min (f_n, \psi_{n - 1})) = \mu^*(f_n + \psi_{n - 1}) = \mu^*(f_n) + \mu^*(\psi_{n - 1})$, thus $\mu^*(\psi_n) - \mu^*(h_n) \leqslant [\mu^*(f_n) - \mu^*(h_n)] + [\mu^*(\psi_{n - 1}) - \mu^*(h_{n - 1})]$ and therefore $\mu^*(\psi_n) - \mu^*(h_n) \leqslant \sum_{i \leqslant n} [\mu^*(f_i) - \mu^*(h_i)] \leqslant \epsilon \sum_{i \leqslant n} 2^{-i} \leqslant \epsilon$, so that $\lim \mu^*(h_n) \leqslant \mu^*(\lim h_n) \leqslant \mu^*(\lim \psi_n) = \lim \mu^*(\psi_n) \leqslant \lim \mu^*(h_n) + \epsilon$.

- It follows that $\mu^{*}$, restricted to indicator functions, is an outer measure.

- Let $L = \{f \mid \mu^*(f) &gt; -\infty, \mu^*(f) &gt; -\infty, \mu^*(f) + \mu^*(f) \leqslant 0\}$.

By the sublinearity of $\mu^{*}$, $L$ is a vector space and $\mu^{*}$ is a linear functional on $L$. Further $E \subseteq L$ since $\mu^{*}$ coincides with $\mu$ on $E$, and in addition $f \in \mathrm{LSC}$, $\mu^{*}(f) \leqslant \infty$ implies $f \in L$.

- Since for any open sets $0$ and $U$, $I_0 \in L$, and $I_{0 \cap U} \in L$, we have also $I_{0 \setminus U} \in L$, so we get $\mu^*(0) = \mu^*(0 \cap U) + \mu^*(0 \setminus U)$. Thus, for any set $A$, since $\mu^*(A) = \inf \{\mu^*(0) \mid A \subseteq 0\}$, we get $\mu^*(A) \geqslant \mu^*(A \cap U) + \mu^*(A \setminus U)$, so that any open set $U$ is $\mu^{*}$-measurable and thus all Borel sets are $\mu^{*}$-measurable.

- The formula $\mu(A) = \inf \{\mu(0) \mid A \subseteq 0, 0 \text{ open}\}$ for any $\mu^{*}$-measurable set $A$ implies $\mu(A) = \sup \{\mu(F) \mid F \subseteq A, F \text{ closed}\}$, and thus the $\mu^{*}$-measurable sets are just the completion of the Borel sets, and $\mu$ is a regular Borel measure.

- Finally, $\int f d\mu = \mu^*(f)$ first for the convex cone spanned by the constants and the indicators of open sets, by linearity, next for all $f \in \mathrm{LSC}$, by monotone convergence, and therefore for all $f \in L$ and in particular all $f \in E$. It also follows that $L = L_1(\mu)$.

- The regular Borel measure $\mu$ is unique, because its value on the open sets is determined.

---

The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions

- Conversely, clearly the integral for any regular Borel measure is a functional in  $M(S)$ .

The essential results of this section are summarized in the following:

Proposition 1: Denote by  $M(S)$  the set of positive, regular Borel measures on  $S$ . Then:

-  $\forall p \in P \exists \mu \in M(S): \mu \leqslant p$  on  $C$  (Lemma 1).
-  $M(S)$  is a convex cone (and a complete lattice) (immediate from Lemma 4).
- If the sum of 2 positive linear functionals on  $E$  is in  $M(S)$ , each one is also (immediate from Lemma 3).
- Define the "weak\*-topology" on  $M(S)$  as the coarsest topology for which  $\int f d\mu$  is lowersemicontinuous  $\forall f \in C$ , and thus for all l.s.c.  $f$ . Then addition and scalar multiplication are continuous, points are closed and all sets  $\{\mu | \mu(1) = \lambda\}$  and  $\{\mu | \mu(1) \leqslant \lambda\} (\lambda &gt; 0)$  are closed and compact.

Proof: The continuity of addition and scalar multiplication is immediate.  $\{\mu\}$  is closed because, if  $\tilde{\mu}$  is in the closure of  $\mu$ , one has  $\tilde{\mu}(f) \leqslant \mu(f) \forall f \in C$ , thus  $\tilde{\mu} = \mu$  by the minimality of  $\mu$ .

Since all constants belong to  $C$ , there only remains to prove the compactness of  $\{\mu | \mu(1) \leqslant \lambda\}$ . For any ultrafilter on this set, let  $\phi$  denote its pointwise limit in the set of positive linear functionals on  $E$ . By Lemma 1,  $\exists \nu \in M(S)$  with  $\nu \leqslant \phi$  on  $C$ :  $\nu$  is a limit point in  $M(S)$ .

Note that the above applies whenever  $C$  is a lattice and convex cone of bounded functions on some set  $S$ , containing the constants and such that  $f_{i} \in C$ ,  $f_{i} \leqslant f_{i+1} \leqslant 0$  implies  $\lim f_{i} \in C$ , and  $\lim f_{i} &gt; -1$  implies  $\exists i: f_{i} &gt; -1$ . The Borel sets are then interpreted as the  $c$ -field generated by  $C$ , and the regularity is with respect to the  $\{f \leqslant 0\}$  ( $f \in C$ ) as closed sets. (Dini's theorem should be used only for sequences then.)

In particular, everything applies as soon as  $S$  is countably compact (any sequence has a cluster point). Compactness only yields the additional  $\tau$ -smoothness property:  $\mu(\bigcup_{\alpha} 0_{\alpha}) = \sup_{\alpha} \mu(0_{\alpha})$  for any increasing net of open sets  $0_{\alpha}$ .

In the particular case where  $S$  is Hausdorff, i.e.,  $\forall f, g \in C$  s.t.  $f &gt; -g \exists h: -g \leqslant h \leqslant f, h$  continuous, the above results yield Riesz' theorem.

We now obtain also, using standard techniques, a Fubini theorem (the same theorem and proof obviously holds for arbitrary products, finite or infinite; the min-max theorem is however concerned only with products of two factors. The contribution of the theorem is obviously to get the measure on the Borel  $\sigma$ -field of the product, instead of the product  $\sigma$ -field):

Proposition 2: Let  $K_{1}$  and  $K_{2}$  denote two compact spaces,  $K = K_{1} \times K_{2}$ . Let  $\mu_{1} \in M(K_{1}), \mu_{2} \in M(K_{2})$ . Then

(a) There exists a unique  $\mu \in M(K)$ , denoted  $\mu_1 \otimes \mu_2$ , such that  $\mu(F_1 \times F_2) = \mu_1(F_1) \mu_2(F_2) \forall F_i$  closed in  $K_i$ .

---

246 J.-F. Mertens

(b) For any lowersemicontinuous $f$, there exists a sequence of functions $\psi_i = \epsilon_i I_{F_1^i \times F_2^i}$ with $\epsilon_i &gt; 0$, $F_j^i$ closed in $K_j$, and a constant function $\psi_0 \leqslant 0$, such that

$$
\sum_{i} \psi_{i} \leqslant f \quad \text{and} \quad \int f d\mu = \sum \int \psi_{i} d\mu.
$$

(c) For any $\mu$-quasi-integrable $f$ one has that

- for $\mu_1$-almost every $x, f(x, .)$ is $\mu_2$-quasi-integrable.
- $\int f(x,y)d\mu_2(y)$ is $\mu_1$-quasi-integrable (and l.s.c. if $f$ is)
- $\int [\int f(x,y)d\mu_2(y)]d\mu_1(x) = \int fd\mu.$

(An extended real valued function $f$ called $\mu$-quasi-integrable if it is $\mu$-measurable and either $\int f^{+}d\mu \neq \infty$ or $\int f^{-}d\mu \neq \infty$).

Proof: Denote by $\tilde{\mu}$ the product measure on the product of the Borel $\sigma$-fields; let $\tilde{\mu}$ be a positive linear functional on all bounded functions that extends $\int (.)d\tilde{\mu}$, and let (Lemma 1) $\tilde{\mu} \in M(K)$ minorize $\tilde{\mu}$ on $C$. Then we have

$$
\tilde{\mu}(0_{1} \times 0_{2}) \leqslant \tilde{\mu}(0_{1} \times 0_{2}) = \tilde{\mu}(0_{1} \times 0_{2}) = \mu_{1}(0_{1})\mu_{2}(0_{2})
$$

for all $0_{i}$ open in $K_{i}$, and

$$
\tilde{\mu}(F_{1} \times F_{2}) \geqslant \tilde{\mu}(F_{1} \times F_{2}) = \tilde{\mu}(F_{1} \times F_{2}) = \mu_{1}(F_{1})\mu_{2}(F_{2})
$$

for all $F_{i}$ closed in $K_{i}$.

Using the regularity of $\mu_i$, it follows that, for any $\mu_i$-measurable sets $A_i$, $\tilde{\mu}(A_1 \times A_2) = \mu_1(A_1)\mu_2(A_2)$.

Thus the product measure $\tilde{\mu}$ can be extended to a regular Borel measure. By the regularity of $\mu_1$ and $\mu_2$, any Borel measure $\mu$ satisfying $\mu(F_1 \times F_2) = \mu_1(F_1)\mu_2(F_2)$ will satisfy $\mu(A_1 \times A_2) \geqslant \mu_1(A_1)\mu_2(A_2)$ for any Borel sets $A_i$, and thus going to complements, the inverse inequality: it will be an extension of $\tilde{\mu}$. Since any open set $0$ is the limit of the increasing net of sets $0_\alpha$, where the sets $0_\alpha$ are all finite unions of products $0_1 \times 0_2 \subseteq 0$, and thus $\tilde{\mu}$-measurable, the regularity of $\mu$ will imply that $\mu$ is uniquely determined on all open sets, and thus on all Borel sets.

This proves statement (a), and (b) is obtained by pursuing a bit the same argument (representing the $0_\alpha$ as finite disjoint unions of products of Borel sets, and using there the regularity of the $\mu_i$'s, going from indicator functions of open sets to l.s.c. functions $f$, one obtains a finite sequence $\psi_i$ with $\sum_{i} \psi_i \leqslant f$ and $\sum \int \psi_i d\mu$ as close as required to $\int fd\mu$. Iterating this conclusion with the l.s.c. function $f - \sum \psi_i$ yields (b)).

(c) is proved by first noting its truth when $f = I_{0_\alpha}$, next, using the regularity of all measures, that it remains therefore true for indicators of open sets, and hence for all lowersemicontinuous $f$. The general statement follows then because, for any quasi-integrable $f$, $\int fd\mu = \inf \left\{ \int gd\mu \mid g \text{ l.s.c.} \geqslant f \right\} = \sup \left\{ \int hd\mu \mid h \text{ u.s.c.} \leqslant f \right\}$; this was proved in Lemma 4.

---

The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions

# B A Basic Tool

We return now to the corollary sub (B) of our minmax theorem, dropping the Hausdorff assumption on $S$. Remark that, for any $\tau$ with finite support, $f(s, \tau)$ is u.s.c. in $s$; it therefore achieves its maximum, and $\max_{s} f(s, \tau) = \max_{\sigma \in M(S)} f(\sigma, \tau)$. Let $\tilde{v} = \inf_{\tau} \max_{\sigma} f(\sigma, \tau)$ ($\tau$ ranging over probabilities with finite support). By part (A) of the proof there exists, for any finite subset $\tilde{T}$ of $T$, a probability $\sigma$ with finite support on $S$ such that $\min_{t \in \tilde{T}} f(\sigma, t) \geqslant \tilde{v}$. Since $f(., t)$ is u.s.c., and $\sigma$ is a positive linear functional on $E$, there exists by Lemma 1, $\tilde{\sigma} \in M(S)$ with $\tilde{\sigma}(g) \geqslant \sigma(g)$ for all u.s.c. $g$. In particular, $\tilde{\sigma}(1) = \sigma(1) = 1$, and $\min_{t \in \tilde{T}} f(\tilde{\sigma}, t) \geqslant \tilde{v}$. Let $\sum_{\tilde{T}} = \{ \sigma \in M(S) | \sigma(1) = 1 \text{ and } f(\tilde{\sigma}, t) \geqslant \tilde{v} \forall t \in \tilde{T} \}$.

$\sum_{\tilde{T}}$ is obviously closed in $M(S)$, thus, by Proposition 1, the sets $\sum_{\tilde{T}}$ form a decreasing net of nonempty, closed, compact sets, and therefore have a nonempty intersection. Any $\sigma$ in the intersection fills the bill.

Observe that it follows from this that we can phrase the assumptions of that corollary in a fully intrinsic way, using Alexander's subbase theorem:

Theorem 2: Denote by $S$ and $T$ two sets, $f\colon S \times T \to \mathbb{R} \cup \{-\infty\}$. For any $\alpha \in \mathbb{R}$ and $t \in T$, let $S_{t,\alpha} = \{s \in S \mid f(s,t) \geqslant \alpha\}$. If the family of sets $S_{t,\alpha}$ has the finite intersection property, and if $M(S)$ denotes the set of regular Borel probabilities on $S$ endowed with the coarsest topology for which the functions $f(.,t)$ ($t \in T$) are u.s.c. then

$$
\max_{\sigma \in M(S)} \inf_{t \in T} f(\sigma, t) = \inf_{\tau \in \mathsf{T}_{f}} \max_{s \in S} f(s, \tau).
$$

# Remarks:

1) The finite intersection property can be rephrased as asking that any pointwise limit of pure strategies, i.e. of functions $f(s,.)$, be dominated by some pure strategy, i.e. by some function $f(s_0,.)$.
2) This property is substantially weaker than the usual compactness assumption. For instance, if $T$ is a single point, it just asks that $f(s)$ attains its maximum.
3) Using the remark after Proposition 1, it is sufficient to ask that the class of sets $S_{t,\alpha}$ be countably compact, i.e. that any countable family of such sets has the finite intersection property. In that case $M(S)$ becomes the set of probabilities on the $\sigma$-field generated by the functions $f(.,t)$, regular w.r.t. the countable intersections of finite unions of sets $S_{t}$ (in particular, if $S$ with its coarsest topology is countably compact, $M(S)$ is just the set of regular Borel probabilities on $S$). This amounts to ask that, for any countable subset $\tilde{T}$ of $T$, any pointwise limit of pure strategies $s_n$ be dominated on $\tilde{T}$ by some pure strategy $s_0$. E.g., illustrating 3.iii.c, if I picks the indicator function of a countable subset of $[0,1]$, and II a number in $[0,1]$, with the evaluation as payoff, this theorem implies the existence of an optimal strategy of I (countably additive, regular), "guaranteeing" him a payoff of 1.

---

248 J.-F. Mertens

4) Given the above measure theory, including Fubini, essentially our whole proof of Section 2 would go through without the Hausdorff assumption, and thus give the corresponding “intrinsic” result. Indeed, the use of continuous functions in part “D” has nothing essential; lowersemicontinuous ones would do as well, giving a reduction to the case where $T$ is compact with countable base, in which case the proof sub (C) works just as well. The only troublesome point lies in the last sentence sub (ii) of case (D) where the regularity of the topology (“every point has a basis of closed neighborhoods”) seems to be used in an essential way.

Anyway, we get nevertheless the following extension:

**Theorem 3**: The minmax theorem of § 2 is still true with non-Hausdorff compact strategy spaces, provided at least one of them either has a countable basis or is Hausdorff (or if $f$ is measurable for any product measure).

## C Other Techniques from the Literature

Most results of the literature (except of course Sion’s) are obtained, or are at least obtainable, by applying to some particular case of Theorem 2 one of the two following generalization techniques:

1) The first one goes back to Wald. It states that, if for any $\epsilon &gt; 0$ it is possible to find subsets $S_{\epsilon}$ of $S$ and $T_{\epsilon}$ of $T$ such that, by some independent argument, the game restricted to $S_{\epsilon}$ and $T_{\epsilon}$ has a value, and such that $\forall s \in S, \exists s' \in S_{\epsilon} : f(s, t) \leqslant f(s', t) + \epsilon \forall t \in T_{\epsilon}$, and similarly $\forall t \in T, \exists t' \in T_{\epsilon} : \forall s \in S_{\epsilon} f(s, t) \geqslant f(s, t') - \epsilon$, then the given game has a value.

2) The other idea is based on Karlin, and amounts essentially to using the monotone convergence theorem, or Fatou’s lemma.

For instance, after applying Theorem 2 to some game, and having found the value $v$ and player I’s optimal strategy $\mu$, one looks for some class $C$ of functions $\phi(s)$ such that $\int \phi(s) d\mu \geqslant v$. Say $C$ contains all bounded measurable functions that are minorized by some $f(., t)$ ($t \in T$) and their convex combinations, and also the limit of any decreasing sequence $\phi_n$ of such functions (one could still add all functions $\psi$ which are, for any regular Borel probability $\mu$, in the equivalence class of some $\phi \in C$).

3 If this is done, the resulting class $C$ is identical to the set of all functions $\phi$, such that $\forall n, \max(-n, \phi)$ is in the closed convex hull of the set of bounded measurable function $\geqslant$ some $f(., t)$, in the space of all bounded universally measurable functions in duality with the space of regular Borel measures on $S$. This shows that our technique is really equivalent to Karlin’s apparently more powerful closure methods (Karlin 1950).

The only point to show is that the class $\tilde{C}$ of bounded functions in $C$ is closed, it is thus sufficient to show closedness in $L_{\infty}(\mu) \sigma(L_{\infty}(\mu), L_1(\mu))$. By the Krein-Smulian theorem on weak*-closed convex sets, it is sufficient to show that its intersection with any ball of $L_{\infty}$ is $\tau(L_{\infty}, L_1)$-closed. Since the Mackey topology coincides on balls of $L_{\infty}$ with the topology of convergence in measure (this result of Grothendieck follows easily from Dunford-Pettis’ equiintegrability criterion for weak compactness in $L_1$), it follows from Egorov’s theorem that it is sufficient to show that the limit of any uniformly bounded a.e. convergent sequence $(g_n)$ in $\tilde{C}$ is in $\tilde{C}$.

There is obviously no loss in assuming further that each $g_n$ is larger than some convex combination of functions $f(., t)$. Then $\limsup g_n$ is obviously in $\tilde{C}$.

---

The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions

Then any game $\tilde{f}(s, t)$ such that $\tilde{f} \leqslant f$ and $\forall t, \tilde{f}(., t) \in C$ would have the same value and optimal strategy.

Usually $f$ is constructed from $\tilde{f}$ by taking the smallest u.s.c. function majorizing it, but sometimes the argument has to be applied both ways.

To illustrate, we give a typical application: $S$ and $T$ are compact metric, $f$ is a bounded measurable (i.e. measurable for any product measure) function on $S \times T$ such that, if $E = \{(s, t) | f \text{ is not continuous in } s \text{ or in } t \text{ at } (s, t)\}$, then $\forall s, \# \{t | (s, t) \in E\} \leqslant 1$ and $\forall t, \# \{s | (s, t) \in E\} \leqslant 1$. (Remark that measurability would follow for instance if we had, denoting by $\tilde{E}$ the $(F_{\sigma})$ set of points of discontinuity of $f$, $\forall s \{t | (s, t) \in \tilde{E}\}$ and $\forall t \{s | (s, t) \in \tilde{E}\}$ are at most countable.)

Such a game has a value.

Indeed, let $\phi_1(s_0,t_0) = \lim_{s\to s_0}\sup_{t\to t_0}f(s,t_0),\phi_2(s_0,t_0) = \liminf_{t\to t_0}f(s_0,t)$. Consider an

$$
\begin{array}{l}
s \neq s _ {0} \\
s \neq s _ {0} \\
\end{array}
$$

optimal strategy $\sigma$ of player I in the game with payoff $f \vee \phi_{1}$ (Theorem 2). $\forall t_0 \in T,$ by considering an appropriate sequence $t_i$ converging to $t_0$, one can have $\lim_{i \to \infty} (f \vee \phi_1)$

$(s, t_i) = [\phi_2 \wedge (f \vee \phi_1)] (s, t_0)$. Thus, by the above argument, say in the form of Fatou's lemma, $\sigma$ is still an optimal strategy of player I for $[\phi_2 \wedge (f \vee \phi_1)]$, guaranteeing the same value $v_1$, and player II's $\epsilon$-optimal strategy with finite support $\tau_\epsilon$ guarantees the same $v_1$ for $(f \vee \phi_1)$.

Inverting the roles of the players, we get a value $v_{2}$ for both $f \wedge \phi_{2}$ and $[\phi_{1} \vee (f \wedge \phi_{2})]$, an optimal strategy $\tau$ for II and an $\epsilon$-optimal strategy with finite support $\sigma_{\epsilon}$ for I. But $\phi_{1} \vee (f \wedge \phi_{2}) \geqslant \phi_{2} \wedge (f \vee \phi_{1})$, so, by applying Fubini's theorem to $\sigma \otimes \tau$ and those payoff functions, we get $v_{2} \geqslant v_{1}$. Since $f \vee \phi_{1} \geqslant f \geqslant f \wedge \phi_{2}$, we have $v_{2} = v_{1} = v$, and $\sigma_{\epsilon}$ and $\tau_{\epsilon}$ guarantee $v$ in those 3 games, so in $f$.

Karlin's "general game of timing of class II" (Karlin 1959, Chap. V, Ex. 20), falls in this category.

Similarly, assume $S$ and $T$ are compact, and $f(s, t)$ is bounded and Borel-measurable on $S \times T$. Assume $\exists S^0 \subseteq S$ and $T^0 \subseteq T$ such that $f(s,.)$ is l.s.c. on $T$ for $s \in S^0$, $f(., t)$ is u.s.c. on $S$ for $t \in T^0$, and such that $\forall s \in S \exists s_n \in S^0$ with $\lim_{n \to \infty} \inf_{n \to \infty} f(s_n, t) \geqslant f(s, t) \forall t \in T$, and that $\forall t \in T \exists t_n \in T^0$ with $\lim_{n \to \infty} \sup_{n \to \infty} f(s, t_n) \leqslant f(s, t) \forall s \in S$.

Then this game has a value, and both players have $\epsilon$-optimal strategies with finite support carried by $S^0$ and $T^0$ respectively.

Indeed, Theorem 2 yields a value $\tilde{v}$ for the game on $S \times T^0$, and by Fatou's lemma, player I's optimal strategy is still safe against all $t \in T$. Similarly one can apply Theorem 2 and next Fatou's lemma to the game on $S^0 \times T$, with value $\tilde{v}$. Fubini's theorem applied to $f$ and the product of the optimal strategies yields then $\tilde{v} = \tilde{v}$, hence the result.

C. Waternaux (1983)'s "auxiliary game" is of this type.

Most other classical examples (like all examples in Karlin 1950, Restrepo's "general silent duel" or Karlin's "two machinegun duel") can be shown to have a value by the same technique, applied in a more or less similar (and often easier) way.

---

250 J.-F. Mertens: The Minmax Theorem for U.S.C.-L.S.C. Payoff Functions

# References

For general reference in mathematics, the reader may want to consult Halmos (1950), Kelley (1955) and Kelley and Namioka (1963); and on minmax theorems, Parthasarathy and Raghavan (1971).

Aumann RJ (1964) Mixed and behavioural strategies in infinite extensive games. In: Dresher, Shapley, Tucker (eds), pp 627–650
Bourbaki N (1959) Éléments de mathématique, Livre VI: Intégration, Ch. VI: Intégration vectorielle. Hermann, Paris
Dresher M, Tucker AW, Wolfe P (eds) (1957) Contributions to the theory of games III (Annals of Mathematical Studies, vol 39). Princeton University Press, Princeton, New Jersey
Dresher M, Shapley LS, Tucker AW (eds) (1964) Advances in game theory (Annals of Mathematical Studies, vol 52). Princeton University Press, Princeton, New Jersey
Dubins L, Savage LJ (1965) How to gamble if you must. MacGraw Hill, New York
Grothendieck A (1952) Critères de compactité dans les espaces fonctionnels généraux. American Journal of Mathematics 74:168–186
Grothendieck A (1953) Sur les applications linéaires faiblement compactes d'espaces de type $C(K)$. Canadian Journal of Mathematics 5:129–173
Halmos PR (1950) Measure theory. Van Nostrand, New York
Karlin S (1950) Operator treatment of the minmax principle, I. In: Kuhn HW, Tucker AW (eds), pp 133–154
Karlin S (1959) Mathematical methods and theory in games, programming and economics, vol II. Addison-Wesley
Kelley JL (1955) General topology. Van Nostrand, New York
Kelley JL, Namioka I, et al (1963) Linear topological spaces. Van Nostrand, New York
Kneser H (1952) Sur un théorème fondamental de la théorie des jeux. Comptes Rendus de l'Académie des Sciences 234:2418–2420
Kuhn HW, Tucker AW (eds) (1950) Contributions to the theory of games, I (Ann Math Studies, vol 24). Princeton University Press, Princeton, New Jersey
Nikaido H (1954) On von Neumann's minimax theorem. Pacific Journal of Mathematics 4:65–72
Parthasarathy T, Raghavan TES (1971) Some topics in two-person games. American Elsevier Publishing Company, New York
Restrepo R (1957) Tactical problems involving several actions. In: Dresher, Tucker, Wolfe (eds), pp 313–337
Sion M (1958) On general minimax theorems. Pacific Journal of Mathematics 8:171–176
Sion M, Wolfe P (1957) On a game without a value. In: Dresher, Tucker, Wolfe (eds), pp 299–305
Teh Tjoe-Tie (1963) Minmax theorems on conditionally compact sets. Annals of Mathematical Statistics 34:1536–1540
Wald A (1945) Generalization of a theorem by von Neumann concerning zero-sum two-person games. Annals of Mathematics 46:281–286
Wald A (1950) Note on zero-sum two-person games. Annals of Mathematics 52:739–742
Waternaux C (1983) Minmax and maxmin of repeated games without a recursive structure. CORE Discussion Paper 8313, Université Catholique de Louvain
Yanovskaya EB (1964) Minimax theorems for games on the unit square. Theory of Probability and its Applications 9:500–502

Received April 1984
Revised version May 1985