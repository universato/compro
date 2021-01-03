Rubyの`Array#pop`は、末尾をだす。
けど、prioryty_queueの実装は、先頭をだす。だす先頭の代わりに、末尾をいったん先頭に持ってきて、おろしていく。

ソートだと扱いやすいから、昇順でデフォルトで最小値がとりだせた方がいい。

[priority\_queue \- cpprefjp C\+\+日本語リファレンス](https://cpprefjp.github.io/reference/queue/priority_queue.html)
C++の命名が、push, top, pop。
他にsize, empty, emplace, swap.

[heapq \-\-\- ヒープキューアルゴリズム — Python 3\.9\.1 ドキュメント](https://docs.python.org/ja/3/library/heapq.html)
heappush
heappop

heapにアンダーバーなしで続いてるのが、受け入れがたい記法だ。

push_popは実装してもいいかな？

pushやpopの返り値をselfにすると、続けてかけるみたい。
自分は書きたくないかな。
pq.push(5).pop
pq.pop.top
`Array#pop`の返り値が要素だから、Rubyには馴染まないよね。
pushはいいかもしれないけど。
`Array#push`の返り値は配列自身だから、こっちは`pq.push(2).pop`のような書き方が似合うし`self`を返してもよさそう。

基本的には、単純な昇順・降順のどちらかで、比較方法は要素で定義されるべきな気がする。
そういう意味で、ブロックで比較方法をとる初期化はあまり使われなくて不要なのではという気もしなくない。デフォルトが昇順で、降順に簡単に切り替えられるといいと思う。

https://github.com/tobyapi/crystalg/blob/master/src/crystalg/data_structures/priority_queue.cr
https://github.com/universato/ac-library-rb/blob/master/lib/priority_queue.rb
