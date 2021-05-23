# UnionFind(DSU)

ac-library-rbのDSUライブラリの方がしっかりしている。
そっちを使ったらよさそう。

- 典型的なUnionFind
  - union_find_light(最低限の軽量バージョン)
  - union_find_experimental(実験バージョン)
  - union_find_undo(巻き戻しつき)
- weighte_union_find(重み付きUnionFind)

- union_find_light
  - 軽量版。無駄な物がない最低限でシンプルなバージョン。
- union_find_experimental
  - unite_by_rankとunite_by_sizeを用意した。どっちが速いか試せる。
    rankの方が1つ動作が多いよね。
  - uniteもあるけど、rankもsizeも計算するので重たいかも。
  - rootにpath halvingという経路圧縮を使ってみた？

重み付きUnionFind。ポテンシャル付きUnionFindTreeとも。  
これは、ACLに存在しない。
- weighted_union_find_node
  最初に作ったやつ。Nodeクラスを組み込んで実装。
  コードが無駄に長くなる感じあるし、ほんの少し重たい。
- weighted_union_find_rank
  rankを保持し、rankを比べて連結している。sizeも持ってる。
  「ABC087 D - People on a Line」を解く感じ、重たくなさそう。
- weighted_union_find
  rankを調べたり、比較したりするのをやめた。

重み付きUnionFindは、`diff`メソッドで、`same?(a, b)`が同じでなければ`nil`かエラーをだすべきかも。path halvingと相性がいいらしい。

- union_find_undo
  undoつきのUnionFind.
  undoのために経路圧縮しない。
  undoメソッドの最後に、配列は作らないようにする。返り値に配列があると重たくなる。

UnionFind全体的に、1-based indexのまま突っ込んでエラーになることが多いので、ちゃんとエラー処理してあげた方がいいかもしれない。

[素集合データ構造\(Union\-Find\) \| Luzhiled’s memo](https://ei1333.github.io/luzhiled/snippets/structure/union-find.html)
UndoつきUnionFindの参考にした。

[UnionFindTree に関する知見の諸々 \- noshi91のメモ](https://noshi91.hatenablog.com/entry/2018/05/30/191943)

https://twitter.com/satanic0258/status/1102945080908939265
> Path compressionは自身と先祖を全て根に繋げるけど，
Path halvingは自身から2個飛ばしで2個上の親に繋げ変える感じ，
Path splittingは自身と先祖を全て2個上の親に繋げる感じかな

https://twitter.com/satanic0258/status/1103214038270435328
> そいや昨日Path halving+union by sizeで書き直したUnionFind
https://atcoder.jp/contests/atc001/submissions/4480412

https://github.com/not522/ac-library-python/pull/49
> DSU with path halving

path halvingの実装の参考にした。

[\[Ruby\] UnionFind木の実装 \| このコードわからん](https://hai3.net/blog/ruby-union-find-tree/)
nodeを入れたときの実装の参考にした。
