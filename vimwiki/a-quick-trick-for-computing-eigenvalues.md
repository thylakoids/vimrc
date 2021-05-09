<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.13.9/dist/katex.min.css" integrity="sha384-r/BYDnh2ViiCwqZt5VJVWuADDic3NnnTIEOv4hOh05nSfB6tjWpKmn1kUHOVkMXc" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.13.9/dist/katex.min.js" integrity="sha384-zDIgORxjImEWftZXZpWLs2l57fMX9B3yWFPN5Ecabe211Hm5ZG/OIz2b07DYPUcH" crossorigin="anonymous"></script>
Eigenvalues and Eigenvectors
----------------------------

### Find the Eigenvalues of $\left[ \begin{matrix} 3 & 1 \\ 4 & 1\end{matrix} \right]$
$$
\begin{aligned}

A \vec{v} &=  \lambda I \vec{v} \\
A \vec{v} - \lambda I \vec{v} &=  0 \\
(A - \lambda I) \vec{v} &= \vec{0} \\
det(A- \lambda I) &= 0

\end{aligned}
$$

$$
\begin{aligned}
det(
\left[ \begin{matrix}
    3-\blue\lambda & 1 \\
    4 & 1-\blue\lambda \\
\end{matrix} \right]
) &= (3-\blue\lambda)(1-\blue\lambda) - 4 \\
&= \blue\lambda^2 - 4\blue\lambda -1 = 0
\end{aligned}
$$
