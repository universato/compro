# [].balanced?      # => true
# [1, -1].balanced? # => true
# [-1, 1].balanced? # => false
# [1].balanced?     # => false
# [1, 1, -1, -1].balanced  # => true
class Array
  def balanced?
    return false if size.odd?

    balance = 0
    each do |k|
      balance += k
      return false if balance < 0
    end
    return balance == 0
  end
end

# "".balanced?      # => true
# "()".balanced?    # => true
# ")(".balanced?    # => false
# "(".balanced?     # => false
# "(())".balanced   # => true
class String
  def balanced?
    return false if size.odd?

    balance = 0
    each_byte do |b|
      balance += (b == 40 ? 1 : -1)
      return false if balance < 0
    end
    return balance == 0
  end
end

# 競プロでいう正しい括弧列・バランスの取れた括弧列かどうかを判定する。

def typical90_2
  n = gets.to_s.to_i

  exit if n.odd?

  [1, -1].repeated_permutation(n) do |prm|
    if prm.balanced?
      puts prm.map{ |t| t == 1 ? '(' : ')' }.join
    end
  end
end
