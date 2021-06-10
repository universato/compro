# SegmentTree

- SegmentTree
- LazySegmentTree

この2つは別物で、LazySegmentTreeは完成してない。
ac-library-rbに一応あるので、そっちがよさそう。

## 普通のSegmentTree

- segment_tree_form
- segment_tree_light
- segment_tree_mini
- segment_tree

4ファイルあるけど、何が違うんだろう。
これらのSegtreeは、どれも具体的なやつかな。
ブロック指定するのは想定してない。
ac-library-rbのは、初期化時にブロックで演算子を指定するけど、そういうのは入ってない。

- segment_tree
  - new(size_or_ary, :form)
  - min, max, gcd, sum, set
  - proc使ってない。formを指定すると, 単位元が入る。
  - abc125(gcd), dsl_2_a
- form
  - new(n, "form")
  - gcd, min, sum
  - proc
  - abc125(gcd), dsl_2_a
  - test: min(update, get)
- light
  - new(n, 単位元)
  - abc125(gcd), dsl_2_a
  - test: min(update_min, get_min)
- mini
  - new(n, "form")
  - and, gcd, lcm, max, min, min_with_index, or, prod, sum
  - proc, swap
  - test: min(update_min, get_min)

# ACL
# ac-library-rb

```ruby
def test_max_right
    a = [*0..6]
    st = Segtree.new(a, 0){ |x, y| x + y }

    # [0, 1, 2, 3,  4,  5,  6] i
    # [0, 1, 3, 6, 10, 15, 21] prod(0, i)
    # [t, t, t, f,  f,  f,  f] prod(0, i) < 5
    assert_equal 3, st.max_right(0){ |x| x < 5 }

    # [4, 5,  6] i
    # [4, 9, 15] prod(4, i)
    # [t, t,  t] prod(4, i) >= 4
    assert_equal 7, st.max_right(4){ |x| x >= 4 }

    # [3, 4,  5,  6] i 
    # [3, 7, 12, 18] prod(3, i)
    # [f, f,  f,  f] prod(3) <= 2
    assert_equal 3, st.max_right(3){ |x| x <= 2 }
  end
```

最初にfalseがあらわれるindex。現れなければ、サイズ。t, t, t, t, t, **f**, f, f, f

min_leftは、右から見て、**最後に**trueがあらわれる位置。最も左にあるtrueの位置といえる。f, f, f, **t**, t, t, t
最初から右端がfalseなら、引数(≒引数で指定されたサイズ)を返す。
