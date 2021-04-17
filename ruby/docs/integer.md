
# 約数か、倍数か、divisible_by?, multiple_of?

[Crystal](https://github.com/crystal-lang/crystal/blob/c3a3c18238f0caa8b0ce62652808706924bccfca/src/int.cr#L485-L487)
```rb
  def divisible_by?(num)
    remainder(num) == 0
  end
```

```rb
p 2.divisible_by?(1) # => true
p 1.divisible_by?(2) # => false
p 0.divisible_by?(3) # => true
p 0.divisible_by?(1) # => true
p 2.divisible_by?(0) # Unhandled exception: Division by 0 (DivisionByZeroError)
```
引数に0は取れない。0は約数にならないけど、エラーになる。
一般として、0の約数は、全ての0でない整数であり、無限個あると考えられている。

Rails [Active Support コア拡張機能 \- Railsガイド](https://railsguides.jp/active_support_core_extensions.html#multiple-of-questionmark)
```rb
2.multiple_of?(1) # => true
1.multiple_of?(2) # => false
```
2は1の倍数か。2の約数に1があるか。2は1で割り切れるか。

https://github.com/rails/rails/blob/v5.2.4.4/activesupport/lib/active_support/core_ext/integer/multiple.rb
```rb
class Integer
  # Check whether the integer is evenly divisible by the argument.
  #
  #   0.multiple_of?(0)  # => true
  #   6.multiple_of?(5)  # => false
  #   10.multiple_of?(2) # => true
  def multiple_of?(number)
    number != 0 ? self % number == 0 : zero?
  end
end
```
↓三項演算子を逆にした方が読みやすそう。浮動小数点数がくると、意味が変わるかな。いや、一緒だろう。
```rb
class Integer
  def multiple_of?(number)
    number == 0 ? zero? : self % number == 0
  end
end
```

引数が0でもエラーにならない。引数が0のときは、0どうしのときのみ`true`になる。
0は0の倍数となる。
