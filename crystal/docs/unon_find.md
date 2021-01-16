# UnionFind

配列のサイズは、せいぜいInt32型に収まる範囲。
頂点数も0-based indexで普通はこれでいいはず。

ac-library-rbは、nを使っているけど、sizeにしておいた。

`union_find.cr` 引数のエラーや返り値の型をちょっと入れてみた。
`union_find_light.cr` 上記がない。ほんのちょっぴり高速か? 些細な差だろう。
