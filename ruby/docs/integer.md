
# 約数か、倍数か、divisible_by?, multiple_of?

[Crystal](https://github.com/crystal-lang/crystal/blob/c3a3c18238f0caa8b0ce62652808706924bccfca/src/int.cr#L485-L487)
```rb
  def divisible_by?(num)
    remainder(num) == 0
  end
```

```rb
p 2.divisible_by?(1) # => true   2 は 1 で割れる。1は、2の約数。
p 1.divisible_by?(2) # => false  1 は 2 で割れない。2は、1の約数ではない。
p 0.divisible_by?(3) # => true   0 は 3 で割れる。3は、0の約数。
p 0.divisible_by?(1) # => true   0 は 1 で割れる。1は、0の約数。
p 2.divisible_by?(0) # Unhandled exception: Division by 0 (DivisionByZeroError)
```

引数に0は取れない。0は約数にならないけど、エラーになる。
逆に、一般として、0の約数は、全ての0でない整数であり、無限個あると考えられている。

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


# 二項係数

TeXだと`\binom{n}{r}`らしい。
`cmb`は一般的じゃなくて、`comb`を使っている人が多いかもしれない。


nCk mod2(`comb_mod2(k)`)
これは、123 triangleで出題された。

nCk mod3
ARC117 C問題で出題された。


# Division

床関数とガウス記号って同じか。
「を超えない最大の整数」という言い方は、「以下の最大の整数」でよくないかと思った。
「未満の最大の整数」の呼び方がなさそうで困った。

「a / b 以下の最大の整数」は、「integer floor division」でいいと思う。
「a / b 以上の最小の整数」は、「integer ceil division」でいいと思う。
「a / b 未満の最大の整数」は、なんだろう。

ceil divisionは「a / b 以上の最小の整数で」、「a / b 未満の最大の整数」と対になっている。ちょうど答えが 1 ずれる。
```rb
# ceil dividsion
(a + b - 1) / b
# ↓
((a + b - 1) / b) - 1
(a - 1) / b
```
