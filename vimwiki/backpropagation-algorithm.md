Backpropagation Algorithm
=========================

Computational Graphs
--------------------
A vectorized example: $f(x,W) = ||W · x||^2 = \sum_{i=1}^{n}(W · x)_{i}^2$
``` mermaid
graph LR;
W(W)-->*(*)
x(x)-->*
*-->L2(L2)
```
1.
$$q=W · x$$
$$\frac{\partial{f}}{\partial{q_i}} = 2q_i$$
$$\nabla_{q}f=2q$$
2.
$$\frac{\partial{q_k}}{\partial{W_{i,j}}} = 1_{k=i}X_{j}$$
$$\frac{\partial{f}}{\partial{W_{i, j}}}
= \sum_{k} \frac{\partial{f}}{\partial{q_k}} \frac{\partial{q_k}}{\partial{W_{i,j}}}
\\= \sum_{k}(2q_k)(1_{k=i}X_{j})
\\= 2q_ix_j$$
$$\nabla_{W}f=2q·x^T$$
3.
$$ \frac{\partial{q_k}}{\partial{x_i}} = W_{k,i} $$
$$ \frac{\partial f}{\partial x_i} 
= \sum_{k} \frac{\partial{f}}{\partial{q_k}} \frac{\partial{q_k}}{\partial x_i}
\\= \sum_{k}(2q_k)(W_{k, i}) $$
$$ \nabla_{x}f = 2W^T · q $$

Derivative of Softmax Function
------------------------------
$$ S_{i,j} = \frac{e^{z_{i, j}}}{ \sum_{l=1}^{L}e^{z_{i,l}} } $$

$$ \frac{\partial S_{i,j}}{\partial z_{i,k}} = 
\frac{\partial \frac{e^{z_{i, j}}}{ \sum_{l=1}^{L}e^{z_{i,l}} }}{\partial z_{i,k}}
$$

$$ \frac{\partial S_{i,j}}{\partial z_{i,k}}  = 
\begin{cases}
S_{i,j} · (1-S_{i,j}) & j=k \\
-S_{i,j} · S_{i,k} & j \neq k
\end{cases} \\

 = S_{i, j} · (\delta_{j, k} - S_{i,k})
$$
