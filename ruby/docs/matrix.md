Rubyの標準添付ライブラリにも、`matrix`ライブラリはある。
しかし、これは多次元にも対応しているMatrixである。
自分は、2次元平面の2行2列のMatrixさえあれば十分であるl
それに、Rubyの標準添付ライブラリのMatrixは多機能ゆえか遅い感じがある。
だから、簡易版のMatrixを作るのである。

本家版を再現したメソッドもあれば、オリジナルのメソッドもある。

```ruby
m = Matrix[1, 2, 3, 4]
m = Matrix.new(1, 2, 3, 4)
```



```rb
  def ==(other)
    @x == other.x && @y == other.y
    (@x - other.x).abs < EPS && (@y - other.y).abs < EPS
  end
```

`cross_product`って意味合いが異なることがあるかもしれない。
Rubyの`cross_product`は、ベクトルを返す。

```rb

```
