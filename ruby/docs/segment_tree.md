# SegmentTree

- SegmentTree
- LazySegmentTree

この2つは別物で、LazySegmentTreeは完成してない。
ac-library-rbに一応あるので、そっちがよさそう。

- segment_tree_form
- segment_tree_light
- segment_tree_mini
- segment_tree

4ファイルあるけど、何が違うんだろう。

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
