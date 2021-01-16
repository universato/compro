## atcoder/ac-library

ここからだいぶ持ってきてる。

## マクロ、エイリアス

蟻本で使われている`typedef`は古いかもしれない。
時代は`using`なのか。

## ll, lint, int64, i64, llong

```cpp
#define int long long // int main(){…… の部分も入れ替わる。危険。やめよう。
#define llong long long
typedef long long ll; // 蟻本, tomerun氏(KUPC2015)
typedef long long int ll; // yutaka1999氏, snuke氏(KUPC2015)
typedef unsigned long long ull; // 蟻本
using ll = long long; // atcoder/live_library
using int64 = long long; // うしさん
```

`using ll = long long`がC++11からの記法。

ll、lint、int64、i64、llong。`long`1つで済むケースも多いかもしれない。
lintは、int感があっていいけど、コードの整形ツール?の名称みたいなのでも使われている。

llという略称は、蟻本、cLay、[atcoder/live\_library template\.cpp](https://github.com/atcoder/live_library/blob/master/template.cpp)などでも広く使われている。

うしさんの[テンプレート \| Luzhiled’s memo](https://ei1333.github.io/luzhiled/snippets/template/template.html)では、`int64`が使われている。

`int64`は、RustとかCrystalがそんな感じかな。Crystalは`Int64`, `i64`.

`int64_t`

https://twitter.com/armeria_betrue/status/1054745064541323264
AtCoder環境だとint64_tはlong intなので、min(1LL, <int64_tなやつ>) がCEになる
Codeforces環境だとint64_tはlong long intなので、min(1L, <int64_tなやつ>) がCEになる
悩ましい

`int64_t`が環境によって、`long int`だったり`long long int`だったりするので、`max(int64_t, long long)`が手元で動くのに別環境だとCEになったりするらしい。
AtCoderが`long int`で、Codeforcesが`long long int`らしい。AtCoderでは、`max(1LL, int64_t)`がCEになり、CFでは`max(1L, int64_t)`がCEになるらしい。ただ、`int64_t`はハイライトがつくのがいいらしい。

```cpp
int64_t x = 1e18+1; // 1e18が入る。
```

https://twitter.com/satanic0258/status/1325405222932344832
```cpp
using i64 = std::int_fast64_t;
```
をよく使っているんだけど，キャストでもにょることがちょいちょいあり普通にlong longにしてしまおうかという気持ちに


https://twitter.com/kotatsugame_t/status/1329184022073798656
> define int long longはあなたのメモリ使用量を破壊し、キャッシュを破壊し、定数倍を破壊し、あなたのオーバーフローに対する感覚を破壊します。今すぐ辞めよう！

https://twitter.com/kotatsugame_t/status/1336833392864677891
> #define int long longしてる人が32bit環境のこどふぉで定数倍にやられるの絶対見たい、ってツイートしようとしたけど、よく考えたらすでに数回見たことある気もするな

> 結構前に64bit環境が追加されてると思います
https://codeforces.com/blog/entry/75004

https://gcc.gnu.org/onlinedocs/cpp/Macros.html#Macros
gcc はintをdefineしても問題ないらしく、未定義動作ではないらしい。英語が読めないので、よくわからない。

## define

KUPC2015より
```cpp
// zerokugi氏
#define ALL(container) (container).begin(), (container).end()
#define RALL(container) (container).rbegin(), (container).rend()

// sky58氏
#define All(s) s.begin(),s.end()
#define rAll(s) s.rbegin(),s.rend()

// kmjp氏
#define ALL(a) (a.begin()),(a.end())

// evima氏
#define all(x) (x).begin(), (x).end()

// climpet氏
#if __cplusplus >= 201103L
#define ALL(v) begin(v),end(v)
#else
#define ALL(v) (v).begin(),(v).end()
#endif
#define RALL(v) (v).rbegin(),(v).rend()

// asi1024氏
#define ALL(x) (x).begin(),(x).end()

// sune2氏
#define ALL(c) (c).begin(), (c).end()
```

vectorやstringだと、`(x).begin(), (x).end()`となるのだろう。

関数派、メソッド派、小文字派、大文字派

# INF

```
const int INF = 100000000; // 10^8
```

# pair, point, P

[template\.cpp atcoder/live\_library](https://github.com/atcoder/live_library/blob/master/template.cpp)
```cpp
using P = pair<int,int>;
```

C++11以降では`auto`が使える。

```cpp
auto p = make_pair(1, 2);
```

螺旋本の幾何

```cpp
struct Point { double x, y; };
typedef Point Vector;
struct Segment { Point p1, p2; };
typedef Segment Line;
typedef vector<Point> Polygon;
```

structは閉じ波括弧の後ろにも`;`が必要なのか。
`typedef`でエイリアス。

2015-12
[競技プログラミング for beginners\! ～C\+\+実装テク編～ \- 西から昇って東に沈むアレ](http://yumai6.hatenablog.com/entry/2015/12/21/222930)

```cpp
typedef pair<int, int> P;
typedef pair<llong, llong> LP;
typedef pair<int, P> PP;
typedef pair<llong, LP> LPP;
```

大文字は打つのが面倒なような。
蟻本が`typedef pair<int, int> P;`や`typedef pair<double, double> P`を使っている。4-6,p.326など



## 定数

螺旋本で使われていた。`#define`はあまりよくない書き方なのでは?
```cpp
static const int MAX = 200000;
#define MAX 2000001 // p.171
```

## MOD

蟻本で使用されていた。`const`はつけた方がいいのかもしれない。
```cpp
const int MOD = 10009; // 蟻本
const int mod = 1e9 + 7; // うしさん
```

## ModInt, Mint,

cLayは、mint型。

## solve

蟻本はこの中に答えを書いてる。
```cpp
void solve() {

}
```

蟻本で使われていた。文字列の配列の宣言か。
```cpp
const char *AGCT = "AGCT";
```

## 幾何

螺旋本の幾何

```cpp
struct Point { double x, y; };
typedef Point Vector;
struct Segment { Point p1, p2; };
typedef Segment Line;
typedef vector<Point> Polygon;
```

# tourist

https://twitter.com/hir355/status/1247173485169766401
```cpp
#include <bits/stdc++.h>
touristが使ってるのでヨシ

using namespace std;
touristが使ってるのでヨシ

#define int long long
touristが使ってないのでダメ
```

https://twitter.com/hrmk_code/status/1296889450144776192
>tourist、long long ちゃんと打つんだ

## 整数除算

C, C++は、整数除算。

## 累乗

Ruby, Python, JavaScriptには`**`が累乗の演算子としてある。
C++とかはないはず。

初期化のない`string`は、空文字列`""`らしい。

```cpp
"文字列リテラル".size(); // コンパイルエラー
"文字列リテラル"s.size();

string s = "文字列";
s.size();
```

型が同じstringどうしは`==`で比較できる。
stringとcharどうしは`==`で比較できない。
stringとcharの`+`による連結はできる。

```cpp
char a, b;
cin >> a >> b;
```
空白区切りでなくても、1文字ずつ入力してくれるらしい。
むしろ空白があると困る?

Rubyの`gets`は、C++では`getline`が近そう。
```cpp
string s;
getline(cin, s);
```

配列
- 静的配列(従来型の配列、単に配列というとき、こちらを指すのが古)
- array
- 動的配列`vector` APG4bでは、これを単に配列と呼んでいる。

[N \- 1\.13\.配列](https://atcoder.jp/contests/apg4b/tasks/APG4b_n)
> vector<int> vec(3);はvector<int> vec = {0, 0, 0}とほとんど同じ意味です。

vector変数どうしの比較はできる。
けれど、vectorと配列リテラルの比較はできない。
stringとcharどうしは`==`で比較できない。

Rubyではハッシュとブロックが`{}`だけど、C++はブロックと配列がそうなのね。

#

2015/12/21
[競技プログラミング for beginners\! ～C\+\+実装テク編～ \- 西から昇って東に沈むアレ](http://yumai6.hatenablog.com/entry/2015/12/21/222930)

2015/12/23
[いろんな人のテンプレートを観察 \- memo](http://ehafib.hatenablog.com/entry/2015/12/23/164517)
- [テンプレート観察メモ\(KUPC2015) \- memo](http://ehafib.hatenablog.com/entry/2015/12/23/164232)
- [テンプレート観察メモ\(Codeforces\) \- memo](http://ehafib.hatenablog.com/entry/2015/12/23/164137)

```cpp
#define pcnt __builtin_popcount

#define buli(x) __builtin_popcountll(x)

#define pb push_back
#define mp make_pair

#define F first
#define S second
```

###

テンプレート観察メモで`make_pair`を検索したら、みんな`mp`に略していた。
同じく`push_back`を検索したら、みんな`pb`だった。1人だけ`PB`。

```cpp
#define all(c) c.begin(),c.end()
#define FOR(i, x, n) for(int i = x; i < (int)n; i++)
#define REP(i, n) FOR(i, 0, n)
#define debug(x) #x << "=" << (x) << "(L" << __LINE__ << ")"
```

###

2019/04/05 18:32
[AtCoderで使える！便利テクニック｜plasma｜note](https://note.com/plasma_parse/n/n38a6c3faaa06#kVTDP)

```cpp
#include"bits/stdc++.h"
#include<boost/multi_array.hpp>
#include<boost/optional.hpp>
#include<boost/range/irange.hpp>
#include<boost/range/algorithm.hpp>
#include<boost/range/adaptors.hpp>

namespace adaptor = boost::adaptors;

void Main()
{

}

int main()
{
	std::cin.tie(nullptr);
	std::ios_base::sync_with_stdio(false);
	std::cout << std::fixed << std::setprecision(15);
	Main();
}
```

自分の気持ちとしては、`int main()`と`void Main()`があるのは変な感じがする。`void solve()`などにしたい。

### マルチプルテストケース

https://twitter.com/fairly_lettuce/status/1346749511390040064

```cpp
bool isMultpleTestcases = false;

void run() {
  int _t = 1;
  if (isMultpleTestcases) cin >> _t;
  while (_t--) solve();
}
```

### うさぎ小屋

[競技プログラミングにおける個人的 C\+\+ コーディングスタイル \(2020\) \- うさぎ小屋](https://kimiyuki.net/blog/2020/10/25/coding-style-for-competitive-programming/#fnref:remaining)
> main 関数の中などで`constexpr char endl = '\n';`と書いて、`endl`と書けば単なる`char`型のローカル変数が使われるように shadowing しておいてもよいでしょう。
