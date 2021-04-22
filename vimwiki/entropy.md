A Short Introduction to Entropy, Cross-Entropy and KL-Divergence
================================================================

Entropy
-------
The entropy measures the average information that you get when you learn from
one sample drawn from a given probability distribution $\bold{p}$. It tells you
how unpredictable that probability distribution is.

$$ H(\bold{p}) = -\sum_{i}p_ilog_2(p_i) $$

Cross-Entropy
-------------
>Average message length

$\bold{p}$ = true distribution

$\bold{q}$ = predicted distribution

$$ H(\bold{p}, \bold{q}) = -\sum_{i}p_ilog_2(q_i) $$

Relative-Entropy
----------------
> Also called Kullback-Leibler Divergence (or KL Divergence), is the amount by which cross-entropy exceeds the
entropy.

**Cross-Entropy = Entropy + KL Divergence**

KL Devergence:
$$D_{KL}(p||q) = H(p, q)-H(p)$$
