Crystalの方が、Rubyよりもpushのところで書く必要があるものが多い。
Crystalは、空配列aに対してa[0] = xみたいな書き方ができないので、書く必要なある項目が大きい。Crystalはちゃんと<<で要素を足す。

push
ボトムアップに見ていく。頂点になったら、それ以上はないので見ない。

parは、parent(親の)のpar

@heap[i] = @heap[par]
子の要素に親の要素をいれる。

i = par
親の要素をいれる。

https://github.com/tobyapi/crystalg/blob/master/src/crystalg/data_structures/priority_queue.cr

https://github.com/google/ac-library.cr/blob/master/atcoder/PriorityQueue.cr
