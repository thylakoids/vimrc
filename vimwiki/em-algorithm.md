EM Algorithm for Gaussian Mixture Model
---------------------------------------

### Gaussian Mixture Model
$$ p(y|\theta) = \sum_{k=1}^{K}\alpha_{k}\Phi(y|\theta_k) $$

In which, $\alpha_k \geq 0$, $\sum_{k=1}^{K}\alpha_k=1$; $\Phi(y|\theta_k)$ is a
Gaussian distribution, $\theta_k = (\mu_k, \sigma_k^2)$,

### Estimate Parameter in GMM using EM
$$\theta=(\alpha_1, \alpha_2, \cdots, \alpha_k;\theta_1, \theta_2, \cdots, \theta_k)$$

1. Log-likelihood for **complete-data**

