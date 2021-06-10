# google/ac-library-.cr

## サイズ

google/ac-library-.crのDSUやSegtreeは、サイズがInt64。

- DSU
- FenwickTree
- Segtree

## Set

あと、UnionFindのgropsが返すのが、Set(Set(Int64))だから、注意。sortメソッドがない。

sortだけじゃなくくて、次のもない。何があるんだろう。
Error: undefined method '[]' for Set(Set(Int64))

## sameメソッド

`same?`じゃなくて、`same`メソッド。AtCoder本家に合わせてる感じがある。

```
Showing last frame. Use --error-trace for full trace.

In Main.cr:89:15

 89 | puts uf.same?(a, b) ? "Yes" : "No"
              ^----
Error: wrong number of arguments for 'AtCoder::DSU#same?' (given 2, expected 1)

Overloads are:
 - Reference#same?(other : Reference)
 - Reference#same?(other : Nil)
```

## parentsとsizes

https://atcoder.jp/contests/atc001/submissions/22893003 80ms

```ruby
  class DSU
    getter parents : Array(Int64)
    getter sizes : Array(Int64)
    getter size : Int64
  end
```
parentsとsizesを別々に持っている。
まぁ、両方混ぜるのはストイックというか、そこまでしなくてもとはちょっと思う。
