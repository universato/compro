


```rb
$ typeprof union_find_light.rb
# Classes
class UnionFind
  @parents: Array[Complex | Float | Integer | Rational]
  @parent_or_size: bot

  def initialize: (untyped n) -> Array[Integer]
  def unite: (untyped a, untyped b) -> (Complex | Float | Integer | Rational | false)
  def root: (Complex | Float | Integer | Rational a) -> (Complex | Float | Integer | Rational)
  def same?: (untyped a, untyped b) -> bool
  def size: (untyped a) -> (Complex | Float | Integer | Rational)
  def groups: -> Array[Array[untyped]]
  def each_group: -> Enumerator[Array[untyped]]
end
```
botって何? ミスに気がついた。名前ミスだった。


```rb
$ rbs prototype rb union_find_light.rb
class UnionFind
  def initialize: (untyped n) -> untyped

  def unite: (untyped a, untyped b) -> (::FalseClass | untyped)

  def root: (untyped a) -> untyped

  def same?: (untyped a, untyped b) -> untyped

  def size: (untyped a) -> untyped

  def groups: () -> untyped

  def each_group: () -> untyped
end
```

```rb
class Array
  include Comparable

  def abs
    map(&:abs)
  end

  def abs!
    map!(&:abs)
    self
  end
end
```
↓ $ typeprof array.rb
```rb
# Classes
class Array
  def abs: -> Array[untyped]
  def abs!: -> Array[bot]
end
```
