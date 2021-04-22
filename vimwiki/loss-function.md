Loss Function
=============
Let's look at a toy example, the example involves a neuron with just one input:
``` mermaid
graph LR
A((1))==weigth ω==>B((bias b))
B==>C((0))
```
We'll train this neuron to do something ridiculously easy: take input 1 to the 
output 0.

Mean Square Error
--------------
Now we take a deep look at the learning process when using quadratic loss function:
$$  C(w, b) = \frac{1}{2n}\sum_{x}\|y(x) - a\|^2  $$

Then "learning speed" is determined by:
$$ \frac{\partial{C}}{\partial{w}}$$
$$ \frac{\partial{C}}{\partial{b}}$$

The Cross-Entropy Cost Function
-------------------------------

Differences in Learning Speed for Classification
------------------------------------------------
First, let’s recall the gradient descent update rule:
``` python
For i = 1 ... N:
    Compute dJ/dw_i for i = 1 ... M parameters
    Let w_i = w_i - learning_rate * dJ/dw_i
```


Reference
---------
[CHAPTER 3:Improving the way neural networks learn](http://neuralnetworksanddeeplearning.com/chap3.html)
[Picking Loss Functions - A comparison between MSE, Cross Entropy, and Hinge Loss](https://rohanvarma.me/Loss-Functions/)
