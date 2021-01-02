# UnionFind(DSU)

ac-library-rbのDSUライブラリの方がしっかりしている。
そっちを使ってくれたら。

- union_find_experimental
- union_find_light
- union_find_with_time
- weighte_union_find

何が違うんだ？ 自分でもよくわからない。

- union_find_experimental
  - unite_by_rankとunite_by_sizeを用意した。どっちが速いか試せる。
  - rankの方が1つ動作が多いよね。
  - このuniteは、rankもsizeも計算するので重たい。
- union_find_light
  - 軽量版。これが真正かな。無駄な物がない感じ。
- union_find_with_time
  - 作りかけかな。忘れた。
