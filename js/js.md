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
`nexts(n)`なら、n個とる。`a`がfalsyになって、`.map(k => +k)`で数値に変換される。引数の`a`があると、何もしない。何をとるんだろう。

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
