# FenwickTree

ac-library-rbに寄せて作った。

引数に型を指定できるので、初期化のときに配列を引数にとるものを作った。

引数1個のsum(left_sum)に、T.zeroを指定すれば、それぞれの型になるみたい。
ここが1番難しかったかも。

Rubyでは、初期化時に、引数を破壊的変更しないように、`[0].concat(@data)`としてたが、ここをCrystalでは`Array(T).new(1, T.zero)`とした。`[T.zero]`の方がいいかもしれない。

tobyapiさんのやGoogle(hakatashiさん)のを参考にした気がする。

ac-library.crは、FenwickTreeのサイズがInt64指定。そっちの方がいいのかな？


# google/ac-library-.cr

# AC

ALPC
https://atcoder.jp/contests/practice2/submissions/22893243 292ms

## 初期化

Int64のサイズを指定する。配列とか、Int32はダメ。面倒だな。
これはPRを送りたい感じがある。
