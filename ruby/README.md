# array.rb


- `to_adjacency_hash` -> Hash{Object => [Object]}
  - わざわざメソッド化するほどのことじゃないけど、処理的にはよく行う。
  - `edges`(2要素配列に配列)に対するメソッド。グラフの隣接リストにする。
  - 外側をハッシュにするか、配列にするか迷う。ハッシュの方が、色々と使いやすいかも。メモリは少し多めに食うかもだけど、計算量は定数倍しか変わらないよね。
  - 中身の方も、配列じゃなくて、ハッシュに出来るのかな。
  - verified: https://atcoder.jp/contests/abc277/submissions/36429198