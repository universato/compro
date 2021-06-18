# 最初に

AtCoder Library(ac-library, ACL)の各言語の表記について、まとめたものです。

C++とCのクラス名は、Snake case. すべて小文字で、アンダースコア区切り。  
それ以外の言語は、クラス名はキャメルケース。大文字始まり。  

Java、Crystal、C#は、クラス名とファイル名が完全一致の傾向あり。  
これが1番わかりやすいと思う。  

Rubyは、クラス名はキャメルケースで、ファイル名はスネークケース。Railsの傾向?  


# DSU

|lang   |class      |file |     |
|:---   |:---       |:--- |:--- |
|C++    |fenwick_tree|fenwicktree|[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/fenwicktree.hpp#L12)|
|C      |---        |---|[---]()|
|C#     |FenwickTree|FenwickTree|[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/FenwickTree.cs#L95)|
|Python |FenwickTree|fenwicktree|[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/fenwicktree.py#L4)
|Rust   |FenwickTree|fenwicktree|[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/fenwicktree.rs)|
|Go|int|int|[URL](https://github.com/monkukui/ac-library-go/blob/master/fenwicktree/int.go#L1)|
|D      |FenwickTree|fenwicktree|[URL](https://github.com/arkark/ac-library-d/blob/master/src/acl/fenwicktree.d#L4)|
|Java   |FenwickTree|FenwickTree|[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/FenwickTree)|
|Ruby   |FenwickTree|fenwick_tree|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/fenwick_tree.rb)|
|Crystal|FenwickTree|FenwickTre|[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/FenwickTree.cr#L27)|

Goだけ正式名称で異色さが目立つ。  
C++とC言語は全て小文字でdsu。  
それら以外の言語のクラス名は、DSUかDsu。  
- DSU派 C#, Python, Java, Ruby, Crystal
- Dsu派 Rust, D

Rubyは`UnionFind`のエイリアスあり。

# FenwickTree

|lang   |class   |file |     |
|:---   |:---    |:--- |:--- |
|C++    |||[URL]()|
|C      |---|---|[---]()|
|C#     |||[URL]()|
|Python |||[URL]()
|Rust   |||[URL]()|
|Go     |---|---|[---]()|
|D      |---|---|[---]()|
|Java   |||[URL]()|
|Ruby   |||[URL]()|
|Crystal|||[URL]()|


# SCC

|lang   |struct   |file    |     |
|:---   |:---     |:---    |:--- | 
|C++    |scc_graph|scc     |[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/scc.hpp#L12)|
|C      |---      |---     |[---]()|
|C#     |SCCGraph |SCCGraph|[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/SCCGraph.cs)|
|Python |SCCGprah |scc     |[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/scc.py)|
|Rust   |SccGraph |scc     |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/scc.rs)|
|Go     |SccGraph |scc     |[URL](https://github.com/monkukui/ac-library-go/blob/master/scc/scc.go#L6-L8)|
|D      |SccGraph |scc     |[URL](https://github.com/arkark/ac-library-d/blob/master/src/acl/scc.d#L7)|
|Java   |SCC      |SCC     |[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/SCC)|
|Kotolin|SCC      |SCC     |[URL](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/scc/SCC.kt#L6)|
|Ruby   |SCC      |scc     |[URL](https://github.com/universato/ac-library-rb/blob/main/lib/scc.rb)|
|Crystal|SCC      |SCC     |[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/SCC.cr#L27)|

本家に追従するタイプとそうでないタイプがある。
- SCCGraph派 C#, Python, Nim
- SccGraph派 Rust, Go, D
- SCC派 Java, Kotlin, Ruby, Crystal

SccGraphなのかSCCGraphなのかわからなくなりそうなので、SCCが好み。  
あと、SCCGraphは、区切りがわかりにくい。

# mf_graph

|lang   |class   |file    |     |
|:---   |:---    |:---    |:--- |
|C++    |mf_graph|maxflow |[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/maxflow.hpp#L14)|
|C#     |MFGraph |MaxFlow |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MaxFlow.cs#L29)|
|Python |MFGraph |maxflow |[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/maxflow.py#L4)
|Rust   |MfGraph |maxflow |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/maxflow.rs#L7)|
|Go     |---     |---     |[---]()|
|D      |MfGraph |maxflow |[URL](https://github.com/arkark/ac-library-d/blob/master/src/acl/maxflow.d#L7)|
|Java   |MaxFlow |MaxFlow |[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MaxFlow)|
|Kotlin |MaxFlow |MaxFlow |[URL](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/maxFlow/MaxFlow.kt#L6)|
|Ruby   |MaxFlow |max_flow|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/max_flow.rb)|
|Crystal|MaxFlow |MaxFlow |[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/MaxFlow.cr#L28)|

本家のフローは俗っぽい略語を使っていて、他のライブラリでも混乱を感じる。  
mfは頭字語(アクロニム)なので、mf_grphをcamel caseにするときにMFと大文字にしたい気持ちわかる。  
本家を除くと、MFGrahp, MfGraph, MaxFlowの3派閥。

クラス名について
- MFGrahp C#, Python
- MfGraph Rust, D
- MaxFlow Java, Ruby, Crystal

# mcf_graph
|lang   |class        |file         |     |
|:---   |:---         |:---         |:--- |
|C++    |mcf_graph    |mincostflow  |[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/mincostflow.hpp#L17)|
|C#     |McfGraph     |MinCostFlow  |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MinCostFlow.cs#L58)|
|Python |MCFGraph     |mincostflow  |[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/mincostflow.py#L5)
|Rust|MinCostFlowGraph|mincostflow  |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/mincostflow.rs#L16)|
|Go     |---          |             |[---]()|
|D      |McfGraph     |mincostflow  |[URL](https://github.com/arkark/ac-library-d/blob/master/src/acl/mincostflow.d#L7)|
|Java   |MinCostFlow  |MinCostFlow  |[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MinCostFlow)|
|Java   |MinCostFlow  |MinCostFlow  |[URL](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/minCostFlow/MinCostFlow.kt#L6)|
|Ruby   |MinCostFlow  |min_cost_flow|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/min_cost_flow.rb)|
|Crystal|(MinCostFlow)|(MinCostFlow)|[---](https://github.com/google/ac-library.cr/blob/master/atcoder/MinCostFlow.cr)|

Rust, C#は、最大流と最小費用流で記法が揺れている。  
Rustは「MfGraph」vs「MinCostFlowGraph」。  
C#は、「MFGraph」vs「McfGraph」。  

クラス名について
- MCFGrahp Python
- McfGraph C#, D
- MinCostFlow Java, Ruby, Crystal

Pythonは大文字が連続していても全く構わないという気概を感じる。  
Crystalに実装がなかったが、あるとしたら`MinCostFlow`。

# segtree
|lang   |class   |file|    |
|:---   |:---    |:---|:---|
|C++    |segtree |segtree|[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/segtree.hpp#L14)|
|C      |seg_tree|segtree|[URL](https://github.com/siumai1223/ac-library-c/blob/master/atcoder/segtree.c#L29)|
|C#     |Segtree |Segtree|[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/Segtree.cs#L38)|
|Python |SegTree |segtree|[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/segtree.py#L6)
|Rust   |Segtree |segtree|[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/segtree.rs#L71)|
|Go     |---     |---    |[---]()|
|D      |---     |---    |[---]()|
|Java   |SegTree |SegTree|[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/SegTree)|
|Ruby   |Segtree |segtree|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/segtree.rb)|
|Crystal|SegTree |SegTree|[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/SegTree.cr)|

segtreeで1単語とみなすか、segとtreeで2単語とみなすかの流派がありそう。  
個人的にはSegment Treeは2単語だが、Segtreeは1単語の愛称だと思う。  
- 1単語の愛称派 …… 本家、C#, Rust, Ruby
- 2単語の由来派 …… C, Python, Java, Crystal  

Rubyは、`Segtree`と`SegTree`のエイリアスがある。

# lazy_segtree

LazySegtree
|lang   |class       |file        |    |
|:---   |:---        |:---        |:---|
|C++    |lazy_segtree|lazysegtree |[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/lazysegtree.hpp#L20)|
|C      |lazy_segtree|lazy_segtree|[URL](https://github.com/siumai1223/ac-library-c/blob/master/atcoder/lazy_segtree.c)|
|C#     |LazySegtree |LazySegtree |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/LazySegtree.cs#L51)|
|Python |LazySegTree |lazysegtree |[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/lazysegtree.py#L6)
|Rust   |LazySegtree |lazysegtree |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/lazysegtree.rs#L22)|
|Go     |---       |---         |[---]()|
|D      |---       |---         |[---]()|
|Java   |LazySegTree |LazySegtree |[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/LazySegTree)|
|Ruby   |LazySegtree |lazy_segtree|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/lazy_segtree.rb)|
|Crystal|LazySegTree |LazySegTree |[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/LazySegTree.cr#L37)|

C言語、seg_treeとlazy_segtreeで一貫してる感じがしない。
Segment Treeの部分について、語源から2語に区切る派と愛称で1単語にする派がある。  
- 1単語の愛称派 …… 本家、C, C#, Rust, Ruby
- 2単語の由来派 …… Python, Java, Crystal   

Rubyは、`LazySegtree`と`LazySegTree`のエイリアスがある。

# two_sat

|lang   |class   |file   | |
|:---   |:---    |:---|:---|
|C++    |two_sat|twosat|[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/twosat.hpp#L15)|
|C#     |TwoSat |TwoSat |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/TwoSat.cs#L12)|
|Python |TwoSAT |twosat |[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/twosat.py#L6)
|Rust   |TwoSat |twosat |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/twosat.rs)|
|Go     |TwoSat |twosat |[URL](https://github.com/monkukui/ac-library-go/blob/master/twosat/twosat.go#L6)|
|D      |TwoSat |twosat |[URL](https://github.com/arkark/ac-library-d/blob/master/src/acl/twosat.d)|
|Java   |TwoSAT |2SAT   |[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/2SAT)|
|Kotlin |TwoSAT |TwoSAT |[URL](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/twoSAT/TwoSAT.kt#L6)|
|Ruby   |TwoSAT |two_sat|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/two_sat.rb)|
|Crystal|TwoSat |TwoSat |[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/TwoSat.cr#L28)|

クラス名について、本家に合わせるならTwoSatだけど、TwoSATの表記は多い。
- Sat派 C#, Rust, Go, D, Crystal
- SAT派 Python, Java, Ruby

ファイル名についてJavaだけ数字を使っていて不思議な感じがする。   
CrystalとJavaはクラス名とファイル名が同じなイメージだったので、なおさら不思議。  

Rubyは、`TwoSAT`と`TwoSat`のエイリアスあり。

# ModInt

|lang   |class   |file |     |
|:---   |:---    |:--- |:--- |
|C++    |modint|modint|[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/modint.hpp)|
|C      |---|---|[---]()|
|C#     |ModInt|ModInt|[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/Math/ModInt.cs#L72)|
|Python |Modint|modint|[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/modint.py#L26)
|Rust   |ModInt|modint|[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/modint.rs)|
|Go     |---|---|[---]()|
|D      |---|---|[---]()|
|Java   |ModInt|ModInt|[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/ModInt)|
|Ruby   |ModInt|modint|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/modint.rb)|
|Crystal|---|ModInt|[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/ModInt.cr)|

PythonがModIntじゃなくて、Modintにしていた。愛称っぽい。  
Rubyはクラス名をModIntにしているが、それならファイル名はmod_intではという気がしている。  


# テンプレート1

|lang   |class   |file |     |
|:---   |:---    |:--- |:--- |
|C++    |||[URL]()|
|C      |---|---|[---]()|
|C#     |||[URL]()|
|Python |||[URL]()
|Rust   |||[URL]()|
|Go     |---|---|[---]()|
|D      |---|---|[---]()|
|Java   |||[URL]()|
|Ruby   |||[URL]()|
|Crystal|||[URL]()|

PyPyとNimは、Pythonのポートだったと思うので記載してない。  
Kotlinは、基本的にJavaからconvertしているものなので記載してない。  

Nim https://github.com/zer0-star/Nim-ACL/

# C#

最大流はMFGraph、最小費用流はMcfGraphというクラス名になっています。  
他のDSUやSCCGraphを考えると、最小費用流をMCFGraphに変更するとスタイルが整合します。  

なお、本家AtCoderのC++ライブラリの命名の影響でMFGraphのような名称になっていると思いますが、  
本家のC++と異なり、アンダースコアのないキャメルケースは区切りがわかりにくく、略語が何なのかもわかりにくいです。  
また、「MFGraph」なのか「MfGraph」なのか、どっちを使うべきだったか知っておく必要があるように思います。  
以上を踏まえて、いっそクラス名とファイル名をSCC, MaxFlow, MinCostFlowに統一してしまえば、わかりやすいだろうと思います。  

|lang|class       |file           |     |
|:---|:---        |:---           |:--- |
|C#  |DSU         |DSU            |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/DSU.cs)|
|C#  |**SCCGraph**|**SCCGraph**   |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/SCCGraph.cs)|
|C#  |**MFGraph** |**MaxFlow**    |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MaxFlow.cs#L29)|
|C#  |**McfGraph**|**MinCostFlow**|[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MinCostFlow.cs#L58)|
|C#  |Segtree     |Segtree        |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/Segtree.cs#L38)|
|C#  |LazySegtree |LazySegtree    |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/LazySegtree.cs#L51)|
|C#  |TwoSat      |TwoSat         |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/TwoSat.cs#L12)|
|C#  |ModInt      |ModInt         |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/Math/ModInt.cs#L72)|

# Rust

|lang   |struct, impl   |file |     |
|:---   |:---    |:--- |:--- |
|Rust   |Dsu        |dsu|[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/dsu.rs)|
|Rust   |**SccGraph** |scc     |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/scc.rs)|
|Rust   |**MfGraph** |maxflow |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/maxflow.rs#L7)|
|Rust|**MinCostFlowGraph**|mincostflow  |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/mincostflow.rs#L16)|
|Rust   |Segtree |segtree|[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/segtree.rs#L71)|
|Rust   |LazySegtree |lazysegtree |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/lazysegtree.rs#L22)|
|Rust   |TwoSat |twosat |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/twosat.rs)|
|Rust   |ModInt|modint|[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/modint.rs)|

クラス名はアクロニムでも、イニシャルだけ大文字。

# Graph

|Lang   |SCC   |MaxFlow    |MinCostFlow     |
|:---   |:---     |:---    |:--- | 
|C++    |[scc_graph](https://github.com/atcoder/ac-library/blob/master/atcoder/scc.hpp#L12)|[mf_graph](https://github.com/atcoder/ac-library/blob/master/atcoder/maxflow.hpp#L14)     |[mcf_graph](https://github.com/atcoder/ac-library/blob/master/atcoder/mincostflow.hpp#L17) |
|C#     |[SCCGraph](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/SCCGraph.cs) |[MFGraph](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MaxFlow.cs#L29)|[McfGraph](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MinCostFlow.cs#L58) |
|Python |[SCCGprah](https://github.com/not522/ac-library-python/blob/master/atcoder/scc.py) |[MFGraph](https://github.com/not522/ac-library-python/blob/master/atcoder/maxflow.py#L4) |[MCFGraph](https://github.com/not522/ac-library-python/blob/master/atcoder/mincostflow.py#L5)|
|Rust   |[SccGraph](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/scc.rs) |[MfGraph](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/maxflow.rs#L7)     |[MinCostFlowGraph](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/mincostflow.rs#L16)|
|Go     |[SccGraph](https://github.com/monkukui/ac-library-go/blob/master/scc/scc.go#L6-L8) |---     |---|
|D      |[SccGraph](https://github.com/arkark/ac-library-d/blob/master/src/acl/scc.d#L7) |[MfGraph](https://github.com/arkark/ac-library-d/blob/master/src/acl/maxflow.d#L7)     |[McfGraph](https://github.com/arkark/ac-library-d/blob/master/src/acl/mincostflow.d#L7) |
|Java   |[SCC](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/SCC)      |[MaxFlow](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MaxFlow)      |[MinCostFlow](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MinCostFlow)|
|Kotolin|[SCC](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/scc/SCC.kt#L6)      |[MaxFlow](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/maxFlow/MaxFlow.kt#L6)     |[MinCostFlow](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/minCostFlow/MinCostFlow.kt#L6) |
|Ruby   |[SCC](https://github.com/universato/ac-library-rb/blob/main/lib/scc.rb)      |[MaxFlow](https://github.com/universato/ac-library-rb/blob/main/lib/max_flow.rb)     |[MinCostFlow](https://github.com/universato/ac-library-rb/blob/main/lib/min_cost_flow.rb)|
|Crystal|[SCC](https://github.com/google/ac-library.cr/blob/master/atcoder/SCC.cr#L27)      |[MaxFlow](https://github.com/google/ac-library.cr/blob/master/atcoder/MaxFlow.cr#L28)     |(MinCostFlow)|

# MinCostFlow

|lang   |class        |file         |     |
|:---   |:---         |:---         |:--- |
|C++    |[mcf_graph](https://github.com/atcoder/ac-library/blob/master/atcoder/mincostflow.hpp#L17)    |mincostflow  |[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/mincostflow.hpp#L17)|
|C#     |[McfGraph](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MinCostFlow.cs#L58)     |MinCostFlow  |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MinCostFlow.cs#L58)|
|Python |[MCFGraph](https://github.com/not522/ac-library-python/blob/master/atcoder/mincostflow.py#L5)     |mincostflow  |[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/mincostflow.py#L5)
|Rust|[MinCostFlowGraph](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/mincostflow.rs#L16)|mincostflow  |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/mincostflow.rs#L16)|
|Go     |---          |             |[---]()|
|D      |[McfGraph](https://github.com/arkark/ac-library-d/blob/master/src/acl/mincostflow.d#L7)     |mincostflow  |[URL](https://github.com/arkark/ac-library-d/blob/master/src/acl/mincostflow.d#L7)|
|Java   |[MinCostFlow](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MinCostFlow)  |MinCostFlow  |[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MinCostFlow)|
|Kotlin   |[MinCostFlow](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/minCostFlow/MinCostFlow.kt#L6)  |MinCostFlow  |[URL](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/minCostFlow/MinCostFlow.kt#L6)|
|Ruby   |[MinCostFlow](https://github.com/universato/ac-library-rb/blob/main/lib/min_cost_flow.rb)  |min_cost_flow|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/min_cost_flow.rb)|
|Crystal|(MinCostFlow)|(MinCostFlow)|[---](https://github.com/google/ac-library.cr/blob/master/atcoder/MinCostFlow.cr)|

# MaxFlow

|lang   |class   |file    |     |
|:---   |:---    |:---    |:--- |
|C++    |[mf_graph](https://github.com/atcoder/ac-library/blob/master/atcoder/maxflow.hpp#L14)|maxflow |[URL](https://github.com/atcoder/ac-library/blob/master/atcoder/maxflow.hpp#L14)|
|C#     |[MFGraph](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MaxFlow.cs#L29) |MaxFlow |[URL](https://github.com/key-moon/ac-library-cs/blob/master/AtCoderLibrary/MaxFlow.cs#L29)|
|Python |[MFGraph](https://github.com/not522/ac-library-python/blob/master/atcoder/maxflow.py#L4) |maxflow |[URL](https://github.com/not522/ac-library-python/blob/master/atcoder/maxflow.py#L4)
|Rust   |[MfGraph](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/maxflow.rs#L7) |maxflow |[URL](https://github.com/rust-lang-ja/ac-library-rs/blob/master/src/maxflow.rs#L7)|
|Go     |---     |---     |[---]()|
|D      |[MfGraph](https://github.com/arkark/ac-library-d/blob/master/src/acl/maxflow.d#L7) |maxflow |[URL](https://github.com/arkark/ac-library-d/blob/master/src/acl/maxflow.d#L7)|
|Java   |[MaxFlow](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MaxFlow) |MaxFlow |[URL](https://github.com/NASU41/AtCoderLibraryForJava/tree/master/MaxFlow)|
|Kotlin |[MaxFlow](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/maxFlow/MaxFlow.kt#L6) |MaxFlow |[URL](https://github.com/da-louis/ac-library-kt/blob/master/src/main/kotlin/jp/atcoder/library/kotlin/maxFlow/MaxFlow.kt#L6)|
|Ruby   |[MaxFlow](https://github.com/universato/ac-library-rb/blob/main/lib/max_flow.rb) |max_flow|[URL](https://github.com/universato/ac-library-rb/blob/main/lib/max_flow.rb)|
|Crystal|[MaxFlow](https://github.com/google/ac-library.cr/blob/master/atcoder/MaxFlow.cr#L28) |MaxFlow |[URL](https://github.com/google/ac-library.cr/blob/master/atcoder/MaxFlow.cr#L28)|
