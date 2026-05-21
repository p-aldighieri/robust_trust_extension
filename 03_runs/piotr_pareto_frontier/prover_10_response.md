
========
ROLE: user (id=4ce84b8c-00ec-4fdf-a3f5-129599b89af1)
========
# Prover pass 10 — F3: Localized stationarity → fiberwise balance

## Role

You are the Prover. F1 (Conditional B1 + pasting) and F2 (Endpoint-only
fiber image) are both PASS in their corrected forms. Prove the third
FBNF lemma: **F3 — localized endpoint stationarity implies fiberwise
total balance**.

This is the |Ω|≥3 fibered analog of L_B5 (binary endpoint stationarity).

## Setup

FBNF class (see searcher_04_response.md, prover_08_response.md).
Assume FBNF-1+2+3+4+5. Adjudicate whether FBNF-6 should be:
- (FBNF-6-derived) a CONSEQUENCE of optimality + local perturbations
  (this lemma), OR
- (FBNF-6-primitive) a hypothesis on the model.

**Preferred: derived.** F3 should prove that AT THE OPTIMAL TRS, the
fiberwise total-balance equations hold for λ-a.e. z, by combining
local endpoint perturbations $L(z)\mapsto L(z)+\eps h(z)$,
$R(z)\mapsto R(z)+\eps k(z)$ with the v9 T1 Clarke-Danskin Fermat
applied conditionally.

## Lemma F3 — Localized stationarity

**Hypotheses.** Standing + |Ω| ≥ 3 + FBNF-1+2+3+4+5 + the optimal TRS
$T = \bigcup_z \ell_z([L(z), R(z)])$ is the argmax of $V_P$ on
$\K(W^P)$ within the FBNF class.

**Statement.** For λ-a.e. z, the fiberwise total-balance equations
hold:
\[
\alpha\!\int_{a_z}^{L(z)}(L(z)-t)\,\tau_z(dt) = (1-\alpha)\!\int_{S_+(z)}(t-L(z))\,\tau_z(dt),
\]
and the symmetric right-endpoint equation.

## Proof structure

### Step 1 — Localized perturbations

Consider perturbations of the trust band:
$L_\eps(z) = L(z) + \eps h(z)$, $R_\eps(z) = R(z) + \eps k(z)$
for Borel bounded $h, k:Z\to\R$.

Verify that the perturbed trust region $T_\eps = \bigcup_z \ell_z([L_\eps(z), R_\eps(z)])$
is admissible (FBNF-2 preserved) and that $V_P(T_\eps)$ is differentiable
in $\eps$ at $\eps=0$.

### Step 2 — Value functional derivative

Use the binary case's perturbation calculus pointwise in z (paper
Equations (6)-(7) in Appendix A.6 give the smooth-density version).

$\frac{d}{d\eps}\Big|_{\eps=0} V_P(T_\eps) = \int_Z [h(z)\Phi_L(z) + k(z)\Phi_R(z)]\,\lambda(dz)$,
where $\Phi_L(z), \Phi_R(z)$ are the fiberwise stationarity
expressions (LHS minus RHS of the displayed balance equation).

### Step 3 — λ-a.e. Fermat

Optimality at the unperturbed trust region: the derivative is ≤ 0 for
every admissible (h, k). By choosing $h, k$ supported on Borel patches
and using positive/negative tests, conclude $\Phi_L(z) = \Phi_R(z) = 0$
for λ-a.e. z.

This is the conditional v9 T1 Clarke-Danskin Fermat applied fiberwise.

### Step 4 — Verify FBNF-6 is derived, not primitive

Conclude that under FBNF-1+2+3+4+5 plus optimality, the fiberwise
total balance equations (i.e., FBNF-6) hold automatically. So FBNF
is a 5-primitive class, with FBNF-6 derived.

## What I want you to produce

A rigorous proof of F3, in the structure above. Key checks:
- Differentiability of $V_P(T_\eps)$ in $\eps$ (use bounded τ_z mass
  and the binary perturbation calculus).
- λ-a.e. Fermat (use Borel-patch testing).
- FBNF-6 follows from FBNF-1..5 + optimality, not assumed.

## Output Contract

- Inline markdown.
- End with verdict + next-step (F4 capstone assembly next).

Show more

========
ROLE: assistant (id=123f19a3-6edf-4815-a3e5-3cd4753c312a)
========
Lemma F3 - Localized stationarity implies fiberwise total balance
Statement

Work under the standing Robust Trust assumptions, ∣Ω∣≥3, α∈(0,1), and the FBNF structure with FBNF-1 through FBNF-5. Let the optimal TRS be fiberwise:

T
∗
=
z∈Z
⋃
	​

ℓ
z
	​

([L(z),R(z)]).

Assume the standard local two-sided perturbability condition for the FBNF band: for every bounded Borel h,k:Z→R supported on a Borel patch where

a
z
	​

<L(z)<R(z)<b
z
	​


with positive margin, the perturbed band

L
ε
	​

(z)=L(z)+εh(z),R
ε
	​

(z)=R(z)+εk(z)

is an admissible FBNF trust band for all sufficiently small ∣ε∣.

Then, for λ-a.e. z, the fiberwise total-balance equations hold:

α∫
a
z
	​

L(z)
	​

(L(z)−t)τ
z
	​

(dt)=(1−α)∫
S
+
	​

(z)
	​

(t−L(z))τ
z
	​

(dt),
(F3-L)

and

α∫
R(z)
b
z
	​

	​

(t−R(z))τ
z
	​

(dt)=(1−α)∫
S
−
	​

(z)
	​

(R(z)−t)τ
z
	​

(dt).
(F3-R)

Here S
+
	​

(z) is the strict left-endpoint row-minimizer region, i.e. the sources on fiber z for which the adversarial payoff-minimizing projected label is w
z,L
	​

=w
∗
(ℓ
z
	​

(L(z))). Similarly S
−
	​

(z) is the strict right-endpoint row-minimizer region.

This proves that FBNF-6 is derived, not primitive, for the regular interior FBNF class. If the band has endpoint constraints L=a
z
	​

, R=b
z
	​

, or no two-sided local perturbations on a positive-measure patch, the conclusion becomes the corresponding one-sided KKT inequality rather than equality. That is the same boundary caveat already seen in the binary capstone, where interior endpoint stationarity was needed to turn inequalities into equalities. 

prover_07_response

Hypotheses used

We use:

FBNF-1, measurable affine foliation:

τ(ds)=∫
Z
	​

τ
z
	​

(dt)λ(dz),s=ℓ
z
	​

(t).

FBNF-2, fiber-preserving TRS:

Π
T
	​

(ℓ
z
	​

(t))=ℓ
z
	​

(Π
[L(z),R(z)]
	​

(t)).

FBNF-3, endpoint-only projected payoff image, derived in F2 under the affine-fiber support-function primitive. F2 proves that, on each fiber, the rowwise minimum over the trusted interval is attained by an endpoint label. 

prover_09_response

FBNF-4, fiberwise endpoint exposure:

B
W
	​

(w
z,L
	​

)∩ℓ
z
	​

([a
z
	​

,b
z
	​

])={ℓ
z
	​

(L(z))},

and similarly for R(z).

FBNF-5, fiberwise tie discipline, so strict endpoint regions S
+
	​

(z),S
−
	​

(z) cover the fiber up to τ
z
	​

-null tie sets.

Optimality of T
∗
 within the locally perturbable FBNF class.

The corrected F1 proof already identified FBNF-6 as the scalar balance input needed for conditional B1, and marked FBNF-6 as the analytic piece still to be derived by localized Clarke-Danskin stationarity. 

prover_08_response

Step 1 - Localized perturbations

Fix a Borel patch A⊆Z on which the band has a positive uniform margin:

L(z)−a
z
	​

≥δ,R(z)−L(z)≥δ,b
z
	​

−R(z)≥δ

for some δ>0. Let h,k be bounded Borel functions supported on A. For sufficiently small ∣ε∣,

a
z
	​

<L
ε
	​

(z)<R
ε
	​

(z)<b
z
	​


on A, and the band is unchanged off A. Hence

T
ε
	​

=
z
⋃
	​

ℓ
z
	​

([L
ε
	​

(z),R
ε
	​

(z)])

is admissible in the local FBNF tangent class.

Borelness is inherited from z↦L(z),R(z),h(z),k(z) and the Borel chart in FBNF-1. The same chart condition was already needed in F1 to paste conditional kernels without multi-valued posterior ambiguity. 

prover_08_response

Let V
P
	​

(L,R) denote the payoff-profile value of the TRS band:

V
P
	​

(L,R)=∫
Z
	​

V
z
	​

(L(z),R(z))λ(dz).

Boundedness of W and τ
z
	​

-mass 1 imply local Lipschitzness in (L,R). Classical differentiability is available under the smooth-density assumptions of the paper’s Appendix A.6; in the general nonsmooth setting we use the Clarke-Danskin derivative. This is exactly the finite-menu T1 mechanism: Clarke multipliers λ
±
 are used to handle max/min active faces without pretending ties are absent. 

prover_02_response

Step 2 - Conditional endpoint labels and active masses

For each z, write:

w
z,L
	​

=w
∗
(ℓ
z
	​

(L(z))),w
z,R
	​

=w
∗
(ℓ
z
	​

(R(z))).

By F2, the projected adversarial payoff image on fiber z is endpoint-supported:

r∈[L(z),R(z)]
min
	​

ℓ
z
	​

(t)⋅w
∗
(ℓ
z
	​

(r))=min{ℓ
z
	​

(t)⋅w
z,L
	​

,ℓ
z
	​

(t)⋅w
z,R
	​

}.

F2’s proof is a one-dimensional supporting-line domination argument on each affine fiber: every interior supporting line is dominated, for minimization, by at least one endpoint supporting line. 

prover_09_response

Define the strict endpoint minimizer regions:

S
+
	​

(z)={t:ℓ
z
	​

(t)⋅w
z,L
	​

<ℓ
z
	​

(t)⋅w
z,R
	​

},
S
−
	​

(z)={t:ℓ
z
	​

(t)⋅w
z,R
	​

<ℓ
z
	​

(t)⋅w
z,L
	​

}.

By FBNF-5, the endpoint tie set has τ
z
	​

-mass zero for λ-a.e. z, so active minimizer weights are simply indicators of S
+
	​

(z) and S
−
	​

(z), rather than arbitrary tie weights. This is the exact fiberwise analogue of the tie-free specialization in the binary L_B5 proof. 

prover_06_response

Now define the total mixture mass attached to the left endpoint label:

q
L
	​

(z):=ατ
z
	​

([a
z
	​

,L(z)])+(1−α)τ
z
	​

(S
+
	​

(z)),

and its unnormalized posterior numerator:

g
L
	​

(z):=α∫
a
z
	​

L(z)
	​

ℓ
z
	​

(t)τ
z
	​

(dt)+(1−α)∫
S
+
	​

(z)
	​

ℓ
z
	​

(t)τ
z
	​

(dt).

Similarly,

q
R
	​

(z):=ατ
z
	​

([R(z),b
z
	​

])+(1−α)τ
z
	​

(S
−
	​

(z)),
g
R
	​

(z):=α∫
R(z)
b
z
	​

	​

ℓ
z
	​

(t)τ
z
	​

(dt)+(1−α)∫
S
−
	​

(z)
	​

ℓ
z
	​

(t)τ
z
	​

(dt).
Step 3 - Conditional Clarke-Danskin Fermat

We now apply the localized version of v9 T1 fiber by fiber.

The finite-menu T1 says: at a local optimum, Clarke-Fermat stationarity gives normal-cone multipliers; after normalization, the induced posterior at every active positive-mass label lies in that label’s Bayes cone. In finite-label notation, if

g
i
	​

=α∫λ
i
+
	​

(s)sτ(ds)+(1−α)∫λ
i
−
	​

(s)sτ(ds),

and

q
i
	​

=α∫λ
i
+
	​

(s)τ(ds)+(1−α)∫λ
i
−
	​

(s)τ(ds),

then

p
i
	​

:=g
i
	​

/q
i
	​

∈B
W
	​

(w
i
	​

)

whenever q
i
	​

>0. 

prover_02_response

The localization is standard: because the perturbations h,k may be supported on arbitrary Borel patches A⊆Z, any violation of the T1 normal-cone condition on a positive-λ-measure set would admit a Borel patch and a signed perturbation improving the objective there, contradicting optimality. Equivalently, the global Clarke-Fermat condition for the decomposable integral functional

∫
Z
	​

V
z
	​

(L(z),R(z))λ(dz)

localizes to a λ-a.e. Clarke-Fermat condition for the two endpoint labels on each fiber.

Thus, for λ-a.e. z, if q
L
	​

(z)>0,

p
L
	​

(z):=
q
L
	​

(z)
g
L
	​

(z)
	​

∈B
W
	​

(w
z,L
	​

),
(1)

and if q
R
	​

(z)>0,

p
R
	​

(z):=
q
R
	​

(z)
g
R
	​

(z)
	​

∈B
W
	​

(w
z,R
	​

).
(2)

This is the conditional version of the binary L_B5 mechanism: the normalized posterior at the active left label lies in the Bayes cone of w
L
	​

, and endpoint exposure collapses that cone to the endpoint belief. The earlier binary proof states precisely this route from Clarke-Danskin endpoint multipliers to total-balance equations. 

prover_07_response

Step 4 - Use fiberwise endpoint exposure

Because all beliefs inside g
L
	​

(z) lie on the same affine fiber, their normalized average also lies on that fiber. Write

ℓ
z
	​

(t)=p
z
	​

+td
z
	​

.

If q
L
	​

(z)>0, then

p
L
	​

(z)=ℓ
z
	​

(
t
ˉ
L
	​

(z)),

where

t
ˉ
L
	​

(z)=
ατ
z
	​

([a
z
	​

,L(z)])+(1−α)τ
z
	​

(S
+
	​

(z))
α∫
a
z
	​

L(z)
	​

tτ
z
	​

(dt)+(1−α)∫
S
+
	​

(z)
	​

tτ
z
	​

(dt)
	​

.

By (1) and FBNF-4,

p
L
	​

(z)∈B
W
	​

(w
z,L
	​

)∩ℓ
z
	​

([a
z
	​

,b
z
	​

])={ℓ
z
	​

(L(z))}.

Hence

t
ˉ
L
	​

(z)=L(z).

Multiplying by q
L
	​

(z) gives

α∫
a
z
	​

L(z)
	​

tτ
z
	​

(dt)+(1−α)∫
S
+
	​

(z)
	​

tτ
z
	​

(dt)=L(z)[ατ
z
	​

([a
z
	​

,L(z)])+(1−α)τ
z
	​

(S
+
	​

(z))].

Rearranging:

α∫
a
z
	​

L(z)
	​

(L(z)−t)τ
z
	​

(dt)=(1−α)∫
S
+
	​

(z)
	​

(t−L(z))τ
z
	​

(dt).

If q
L
	​

(z)=0, then both τ
z
	​

([a
z
	​

,L(z)]) and τ
z
	​

(S
+
	​

(z)) are zero, so both sides are zero. Thus (F3-L) holds for λ-a.e. z.

Step 5 - Right endpoint

The right endpoint is identical, with signs flipped.

If q
R
	​

(z)>0, then

p
R
	​

(z)=
q
R
	​

(z)
g
R
	​

(z)
	​

=ℓ
z
	​

(
t
ˉ
R
	​

(z)),

where

t
ˉ
R
	​

(z)=
ατ
z
	​

([R(z),b
z
	​

])+(1−α)τ
z
	​

(S
−
	​

(z))
α∫
R(z)
b
z
	​

	​

tτ
z
	​

(dt)+(1−α)∫
S
−
	​

(z)
	​

tτ
z
	​

(dt)
	​

.

By (2) and FBNF-4,

p
R
	​

(z)∈B
W
	​

(w
z,R
	​

)∩ℓ
z
	​

([a
z
	​

,b
z
	​

])={ℓ
z
	​

(R(z))}.

So 
t
ˉ
R
	​

(z)=R(z). Multiplying out:

α∫
R(z)
b
z
	​

	​

tτ
z
	​

(dt)+(1−α)∫
S
−
	​

(z)
	​

tτ
z
	​

(dt)=R(z)[ατ
z
	​

([R(z),b
z
	​

])+(1−α)τ
z
	​

(S
−
	​

(z))].

Rearranging:

α∫
R(z)
b
z
	​

	​

(t−R(z))τ
z
	​

(dt)=(1−α)∫
S
−
	​

(z)
	​

(R(z)−t)τ
z
	​

(dt).

If q
R
	​

(z)=0, both sides are again zero. Thus (F3-R) holds for λ-a.e. z.

Step 6 - Relation to the perturbation derivative

In the smooth-density binary proof in the paper, the derivative of the interval objective with respect to an endpoint is U
′′
 times the signed endpoint-balance expression. At an interior optimum, the derivative vanishes, and U
′′
>0 converts first-order stationarity into total balance. The nonsmooth proof above is the Clarke-Danskin version of the same calculation: instead of dividing by U
′′
, it uses the normal-cone posterior p
i
	​

∈B
W
	​

(w
i
	​

), and endpoint exposure collapses that posterior to the endpoint coordinate. 

prover_06_response

So the derivative formula can be read as

DV
P
	​

(L,R)[h,k]=∫
Z
	​

h(z)χ
L
	​

(z)Φ
L
	​

(z)λ(dz)+∫
Z
	​

k(z)χ
R
	​

(z)Φ
R
	​

(z)λ(dz)

in smooth fibers, with positive endpoint speeds χ
L
	​

,χ
R
	​

. In the nonsmooth formulation, v9 T1 replaces χΦ=0 by the sharper posterior-cone statement, and the same scalar balance follows.

Here

Φ
L
	​

(z)=α∫
a
z
	​

L(z)
	​

(L(z)−t)τ
z
	​

(dt)−(1−α)∫
S
+
	​

(z)
	​

(t−L(z))τ
z
	​

(dt),
Φ
R
	​

(z)=α∫
R(z)
b
z
	​

	​

(t−R(z))τ
z
	​

(dt)−(1−α)∫
S
−
	​

(z)
	​

(R(z)−t)τ
z
	​

(dt).

The proof above establishes Φ
L
	​

=Φ
R
	​

=0 λ-a.e.

Step 7 - Why the a.e. conclusion is legitimate

Suppose, for example, that Φ
L
	​

>0 on a Borel set A with λ(A)>0. By local two-sided perturbability, choose h supported on A with the sign that increases the objective to first order. If Φ
L
	​

<0, choose the opposite sign. This contradicts optimality of the unperturbed band. The same argument applies to Φ
R
	​

.

Equivalently, using the Clarke-Danskin formulation: if the normalized endpoint posterior failed to lie in the relevant Bayes cone on a positive-measure patch, finite-dimensional separation plus measurable selection would produce a local endpoint/profile perturbation improving the objective on that patch. Patch testing prevents cancellations across fibers. The conclusion is therefore genuinely λ-a.e., not merely integrated over Z.

FBNF-6: derived or primitive?

Under FBNF-1 through FBNF-5 plus:

local two-sided endpoint perturbability,

endpoint exposure,

tie discipline,

optimality of the TRS within the FBNF class,

the fiberwise total-balance equations are derived. They should not be a primitive axiom in the regular FBNF class.

So the clean class is:

FBNF primitives=FBNF-1 through FBNF-5 plus local perturbability.

Then FBNF-6 is the theorem F3. This fits the FBNF route: F1 needs scalar balance as input, F2 gives endpoint-only projected image, and F3 now supplies the scalar balance from optimality. The patched F1 proof explicitly recorded that FBNF-6 is the scalar total-balance input needed for conditional B1, while the open task was to derive it by localized Clarke-Danskin stationarity. 

prover_08_response

If endpoint perturbability fails on a positive-measure patch, then the correct replacement is not equality but a one-sided KKT condition. In that boundary case, declaring FBNF-6 primitive would be too strong unless the model separately guarantees equality.

Hidden-hypothesis audit

FBNF-1 is used to write the value as a decomposable integral over Z and to keep all posterior averages inside a single affine fiber.

FBNF-2 is used to identify left-fiber messages with endpoint label w
z,L
	​

 and right-fiber messages with w
z,R
	​

.

FBNF-3 / F2 is used to reduce the adversarial active image on each fiber to the two endpoint labels. The F2 proof already established endpoint-supported minimization under the affine-fiber support-function primitive. 

prover_09_response

FBNF-4 is the hinge that turns the vector normal-cone conclusion p
z,L
	​

∈B
W
	​

(w
z,L
	​

) into the scalar identity p
z,L
	​

=ℓ
z
	​

(L(z)), and similarly for R.

FBNF-5 removes positive-mass endpoint ties. Without it, the result becomes the weighted tie-split version, with λ
L
−
	​

,λ
R
−
	​

 instead of indicators 1
S
+
	​

	​

,1
S
−
	​

	​

.

Local two-sided perturbability is needed for equality. Without it, only one-sided inequalities follow.

Verdict and next step

Verdict: PASS, with one explicit regularity caveat. FBNF-6 is derived from optimality plus localized two-sided perturbations. If the model permits boundary endpoints or lacks two-sided localized perturbations, replace equality by KKT inequalities.

Next-step signal: fire F4 capstone assembly using patched F1, F2, and this F3.
