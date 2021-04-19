# Facts

剰余つきの場合の数(nCk)などを複数もとめるときのテーブルを作って、求めるクラス。

テーブルが足りないときは、自動で拡張する優れもの。

# 注意点

nCr (mod)について、
mod < n だと、全て0になってしまって、求められないらしい。
ARC117のC問題で、ハマる人がそこそこいた模様。結果が0になってしまうとか。

[解説 \- AtCoder Regular Contest 117](https://atcoder.jp/contests/arc117/editorial/1113)
> この問題は mod = 10**9 + 7 ではなく mod = 3 での二項係数の値を求める必要があるため、逆元を使った手法を用いることができません。

## 参考

[Python で二項係数 nCr を高速に計算したい \| Satoooh Blog](https://satoooh.com/entry/5195/)
ここを参考に最初作った。わかりやすかった。

[二項係数 mod 素数を高速に計算する方法 \[累積和, フェルマーの小定理, 繰り返し二乗法, コンビネーション, 10^9\+7\] \- はまやんはまやんはまやん](https://www.hamayanhamayan.com/entry/2018/06/06/210256)

[組合せ\(Combination\) \| Luzhiled’s memo](https://ei1333.github.io/luzhiled/snippets/math/combination.html)

[競プロでよく使う二項係数\(nCk\)を素数\(p\)で割った余りの計算と逆元のまとめ \| アルゴリズムロジック](https://algo-logic.info/combination/)
