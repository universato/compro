# 最初に

自分用の簡単なメモ

# テストの実行方法

jestを利用してテストをしている。`package.json`にスクリプトが指定されている。

```
$ npm test
$ npx test
```

# Rubyぽくするnpm

[ruby - npm](https://www.npmjs.com/package/ruby)
[like-ruby - npm](https://www.npmjs.com/package/like-ruby)

# JavaScript


2019/6/23  
[AtCoderをJavaScriptで挑むのは厳しいと思った \| 404 Motivation Not Found](https://tech-blog.s-yoshiki.com/2019/06/1317/)

2018/09/23 - 2019/01/18
[JavaScriptで処理時間を計測する本当に正しい方法 \| PisukeCode \- Web開発まとめ](https://pisuke-code.com/javascript-measure-processing-time/)
[performance.getEntriesByName is not a function · Issue \#21621 · nodejs/node](https://github.com/nodejs/node/issues/21621)
[perf\_hooks: simplify perf\_hooks by jasnell · Pull Request \#19563 · nodejs/node](https://github.com/nodejs/node/pull/19563)

`getEntriesByName` was removed in v10.0.0.

## Array

配列の重複を削除して各要素がユニークとなった配列を返す。(Rubyでいう`Array#uniq`。distinct)
```js
function uniq(numbers) { return Array.from(new Set(numbers)); }
```

## 高速入力


catoonさんのJSの高速入力を見る。

```js
"use strict";
var input=require("fs").readFileSync("/dev/stdin","utf8");
var cin=input.split(/ |\n/),cid=0;
function next(){return +cin[cid++];}
function nextstr(){return cin[cid++];}
function nextbig(){return BigInt(cin[cid++]);}
function nexts(n,a){return a?cin.slice(cid,cid+=n):cin.slice(cid,cid+=n).map(a=>+a);}
function nextssort(n,a){return a?cin.slice(cid,cid+=n).map(a=>+a).sort((a,b)=>b-a):cin.slice(cid,cid+=n).map(a=>+a).sort((a,b)=>a-b);}
function nextm(h,w,a){var r=[],i=0;if(a)for(;i<h;i++)r.push(cin.slice(cid,cid+=w));else for(;i<h;i++)r.push(cin.slice(cid,cid+=w).map(a=>+a));return r;}
function xArray(v){var a=arguments,l=a.length,r="Array(a["+--l+"]).fill().map(x=>{return "+v+";})";while(--l)r="Array(a["+l+"]).fill().map(x=>"+r+")";return eval(r);}
```

`cin` ? C++の入力の名前と一緒だ。`split(/ |\n/)`は、半角スペースと改行で分割している。
なぜ`var`なのか。
`next()`は数値1つ。
`nexts(n, a)`は、引数の数で変わる。
`nexts(n)`なら、n個とる。`a`がfalsyになって、`.map(k => +k)`で数値に変換される。引数の`a`があると、何もしない。
`a`にtruthyを入れると、数値変換をしないっぽい。
`nextssort`。これも、デフォルトだと昇順ソートだが、第2引数の`a`にtrueを入れると降順ソートになるみたい。

```js
"use strict";
let input = require("fs").readFileSync("/dev/stdin", "utf8");
let cin = input.split(/ |\n/), cid = 0;
function next(){ return +cin[cid++]; }
function nextstr(){ return cin[cid++]; }
function nextbig(){ return BigInt(cin[cid++]); }
function nexts(n,a){ return a?cin.slice(cid,cid+=n):cin.slice(cid,cid+=n).map(a=>+a); }
function nextssort(n,a){ return a?cin.slice(cid,cid+=n).map(a=>+a).sort((a,b)=>b-a):cin.slice(cid,cid+=n).map(a=>+a).sort((a,b)=>a-b); }
function nextm(h,w,a){ var r=[],i=0;if(a)for(;i<h;i++)r.push(cin.slice(cid,cid+=w));else for(;i<h;i++)r.push(cin.slice(cid,cid+=w).map(a=>+a));return r; }
function xArray(v){ var a=arguments,l=a.length,r="Array(a["+--l+"]).fill().map(x=>{return "+v+";})";while(--l)r="Array(a["+l+"]).fill().map(x=>"+r+")";return eval(r); }
```


# 入力

```js
function main(input) {
  let a = input.split(" ");
}

main(require("fs").readFileSync("/dev/stdin", "utf8"));
```

```js
let input = require("fs").readFileSync("/dev/stdin", "utf8");
```

```js
let input = require("fs").readFileSync("/dev/stdin", "utf8");
let cin = input.split(/ |\n/), cid = 0;
```
`/ |\n/`は、半角スペースか改行。
`split`はRubyと同じで文字列でも正規表現でも引数で指定できる。
`cin`は、catoon-san方式で、配列に入る。`cin`や`cid`は直接参照せず、`next()`などで取り出す。
