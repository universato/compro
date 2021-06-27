# Deque

Ring Buffing による実装。

## 特異メソッド

### new(array) -> Deque

```rb
Deque.new([10, 20, 30])
d # => Deque[10, 20, 30]
```

## インスタンスメソッド

### size -> Integer
### length -> Integer

```rb
d = Deque([10, 20, 30])
d.size # => 3
```

### empty? -> Bool

```rb
d = Deque([10, 20, 30])
d.empty? # => false
```

### push(x)


# [Pythonで各要素にO\(1\)でランダムアクセスできるdeque\(両端キュー\)を書いてみた \- 30歳で競プロに目覚めた霊長類のブログ](https://prd-xxx.hateblo.jp/entry/2020/02/07/114818)

<<, pop, unshfit, shift を逆にする。
self[], self[]= でも、逆にする。
each, to_a
to_s は、to_a に依存する。
pushは、<< に依存。
digは、self[]に依存。

# 061

[061 \- Deck（★2）](https://atcoder.jp/contests/typical90/tasks/typical90_bi)
unshiftとpushと[]だけで、更新なしなので、RubyならArrayでよさそう。
https://atcoder.jp/contests/typical90/submissions/me Ruby 2.7.1 216ms reversible
https://atcoder.jp/contests/typical90/submissions/me Ruby 2.7.1 195ms mini
https://atcoder.jp/contests/typical90/submissions/me Ruby 2.7.1 182ms Array
https://atcoder.jp/contests/typical90/submissions/23555208 Crystal 45ms

```rb
q = gets.to_s.to_i

d = Deque.new

q.times do
  t, x = gets.to_s.split.map{ |e| e.to_i }
  case t
  when 1
    d.unshift(x)
  when 2
    d.push(x)
  when 3
    puts d[x - 1]
  end
end
```
