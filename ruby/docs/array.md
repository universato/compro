
# ones, zeros

MATLAB, NumPy, Numo-NArrayは、ones, zeros。
Ruby matrixライブラリは、one, zero.

[MATLAB ones](https://jp.mathworks.com/help/matlab/ref/ones.html)

ones(n) n次元の正方行列
zeros

numo-narray
```rb
x = Int32.zeros(3, 3)
x = Int32.ones(3, 3)
y = Int32.eye(3, 3)
```

[numpy.zeros — NumPy v1.20 Manual](https://numpy.org/doc/stable/reference/generated/numpy.zeros.html)

```py
np.zeros(5) # => array([ 0.,  0.,  0.,  0.,  0.])
np.zeros((5,), dtype=int) #=> array([0, 0, 0, 0, 0])
np.zeros((2, 2)) # 正方行列
```

ruby `matrix`ライブラリ
るりまは、1引数が正方行列を作ることしか書かれてない。
Ruby 1.9.3-p551の頃には、2引数バージョンが入っている。
Ruby 1.8.7-p358には、2引数が入ってない。
```rb
Matrix.zero(n)
```
