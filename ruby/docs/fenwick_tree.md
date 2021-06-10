
ac-library-rbと一緒。

`ft.sum(l, r)`は、`[l, r)`である。
`ft.sum(0, n)`と`ft._sum(n)`は、`[0, n)`であり、左から`n`個ともいる。

転倒数に使える。

`i += (i & -i)`は、lsb(最下位ビット)を求めている。


# sumの実装

## シンプル最短バージョン、551ms

https://atcoder.jp/contests/arc120/submissions/22878470

## sum(1引数) 566ms
https://atcoder.jp/contests/arc120/submissions/22903125

```ruby
  # .sum(r)     # [0, r)
  # .sum(l, r)  # [l, r)
  # .sum(l..r)  # [l, r]
  def sum(a, b = nil)
    if b
      _sum(b) - _sum(a)
    elsif a.is_a?(Range)
      l = a.begin
      r = a.exclude_end? ? a.end : a.end + 1
      _sum(r) - _sum(l)
    else
      _sum(a)
    end
  end
```

## sum(range)引数 604ms

https://atcoder.jp/contests/arc120/submissions/22903369

# tomerun-san

BIT
