# AtCoderのac-libraryをそのまま持ってきて、自分流に改造。

https://github.com/atcoder/ac-library/blob/master/atcoder/dsu.hpp

`namespace atcoder { }`内をコピーする。

- merge -> unite
- leader -> root

なんで`_n`なのか謎。
