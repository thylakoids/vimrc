Sampling
========
**Sampling** is a means of generating random numbers that belong to a particular
distribution.


Rejection Sampling
------------------
Rejection Sampling is one of the simplest sampling algorithm used to draw samples
from a complicated target distribution where direct sampling is hard. This can be 
done by using a proposal distribution `Q(x)` that is easy to sample from. This
`Q(x)` has to have an important property, namely, `Q(x)` has to envelope the target
distribution `P(x)`. That means, given a scaling factor `k`, it has to be `kQ(x) > P(x)`,
for all `x`. In other word, our target distribution has to be entirely our scaled
proposal distribution.

![rejection_sampling](rejection_sampling.png)

Importance Sampling
-------------------
Computing $\tilde P(x)$ and $\tilde Q(x)$, then *throwing $x$ away* seems wasteful.
Instead rewrite the integral as an expectation under $Q$:

$$
\begin{aligned}

E[f(x)]
&= \int{f(x)P(x)dx} \\
&= \int{f(x)\frac{P(x)}{Q(x)}Q(x)dx} \\
&\approx \frac{1}{S} \sum_{s=1}^{S}f(x^{(s)})\frac{P(x^{(s)})}{Q(x^{(s)})}, & x^{(s)} \sim Q(x) \tag{1}

\end{aligned}
$$
Importance sampling is an approximation method instead of sampling method.

The basic idea is that by concentrating work where the value of the integrand
is relatively high, an accurate estimate is computed more efficiently.  This
estimator converges more quickly if the samples are taken from a distribution
$P(x)$ that is similar to the function $f(x)$.

The variance of the estimation:
$$
Var(X) = E[X^2] - E[X]^2
$$
where in this case, $X$ is $f(x)\frac{P(x)}{Q(x)}$. It is possible to select
proper $Q(x)$ that results in even smaller variance.

The rule of thumb is to define $Q(x)$ where $P(x)|f(x)|$ is large.

Metropolis Hasting
------------------

Gibbs Sampling
--------------
Draw sample from a multi-dimensional Gaussian distribution:
$$
\begin{aligned}

\mu &= \left[ \begin{matrix}
    5 \\
    5 \\
\end{matrix} \right]

\\

\sigma &= \left[ \begin{matrix}
    1 & 0.9 \\
    0.9 & 1 \\
\end{matrix} \right]

\end{aligned}
$$

![gibbs_sampling](./gibbs_sampling.png)

References
----------
1. [A visual tutorial of Rejection Sampling](https://cosmiccoding.com.au/tutorials/rejection_sampling)
2. [Proof for Rejection Sampling](http://www.columbia.edu/~ks20/4703-Sigman/4703-07-Notes-ARM.pdf)
3. [Rejection Sampling](https://agustinus.kristia.de/techblog/2015/10/21/rejection-sampling/) 
4. [Importance Sampling Introduction](https://towardsdatascience.com/importance-sampling-introduction-e76b2c32e744) 
5. [YouTube:Importance sampling-intuition](https://www.youtube.com/watch?v=3Mw6ivkDVZc)
6. [MCMC lecture](http://videolectures.net/mlss09uk_murray_mcmc/)
