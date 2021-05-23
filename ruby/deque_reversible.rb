class Deque
  include Enumerable

  def self.[](*args)
    new(args)
  end

  def initialize(ary = [], max_size: 0)
    @n = [max_size, ary.size].max + 1
    @buf = ary + [nil] * (@n - ary.size)
    @head = 0
    @tail = ary.size
    # @reversed = false
    @reverse_count = 0
  end

  def empty?
    size == 0
  end

  def size
    (@tail - @head) % @n
  end
  alias length size

  def <<(x)
    if reversed?
      __unshift(x)
    else
      __push(x)
    end
  end

  def push(*args)
    args.each{ |x| self << x }
    self
  end
  alias append push

  def unshift(*args)
    if reversed?
      args.reverse_each{ |e|  __push(e) }
    else
      args.reverse_each{ |e| __unshift(e) }
    end
    self
  end
  alias prepend unshift

  def pop
    if reversed?
      __shift
    else
      __pop
    end
  end

  def shift
    if reversed?
      __pop
    else
      __shift
    end
  end

  def last
    self[-1]
  end

  def [](idx)
    sz = size
    return nil if idx < -sz || sz <= idx
    @buf[__index(idx)]
  end
  alias slice []

  def [](a, b = nil)
    if b
      slice2(a, b)
    elsif a.is_a?(Range)
      s = a.begin
      t = a.end
      t -= 1 if a.exclude_end?
      slice2(s, t - s + 1)
    else
      slice1(a)
    end
  end

  def at(idx)
    slice1(idx)
  end

  private def slice1(idx)
    sz = size
    return nil if idx < -sz || sz <= idx
    @buf[__index(idx)]
  end

  private def slice2(i, t)
    sz = size
    return nil if t < 0 || i > sz
    if i == sz
      Deque[]
    else
      j = [i + t - 1, sz].min
      slice_indexes(i, j)
    end
  end

  private def slice_indexes(i, j)
    i, j = j, i if reversed?
    s = __index(i)
    t = __index(j) + 1
    Deque.new(__to_a(s, t))
  end

  def []=(idx, value)
    @buf[__index(idx)] = value
  end

  def ==(other)
    return false unless size == other.size
    to_a == other.to_a
  end

  def hash
    to_a.hash
  end

  def reverse
    dup.reverse!
  end

  def reverse!
    # @reversed = !@reversed
    @reverse_count += 1
    self
  end

  def reversed?
    # @reversed
    @reverse_count & 1 == 1
  end

  def dig(*args)
    case args.size
    when 0
      raise ArgumentError, "wrong number of arguments (given 0, expected 1+)"
    when 1
      self[args[0].to_int]
    else
      i = args.shift.to_int
      self[i]&.dig(*args)
    end
  end

  def each
    return enum_for(:each) unless block_given?

    if @head <= @tail
      if reversed?
        @buf[@head...@tail].reverse_each{ |e| yield e }
      else
        @buf[@head...@tail].each{ |e| yield e }
      end
    else
      if reversed?
        @buf[0...@tail].reverse_each{ |e| yield e }
        @buf[@head..-1].reverse_each{ |e| yield e }
      else
        @buf[@head..-1].each{ |e| yield e }
        @buf[0...@tail].each{ |e| yield e }
      end
    end
  end

  def clear
    sz = size
    @reverse_count = 0
    @head = 0
    @tail = 0
    self
  end

  def join(sep = $,)
    to_a.join(sep)
  end

  def self.to_a_to_deque(name, args = 0)
    args = (0...args).map{ |i| "a#{i}" }.join(", ")
    code = "def #{name}(#{args})
              Deque.new(to_a.#{name}(#{args}))
            end"
    class_eval(code)
  end

  def sample(n = nil)
    Deque.new(to_a.shuffle)
  end

  def shuffle(n = nil)
    Deque.new(to_a.shuffle)
  end

  def replace(other)
    ary = other.to_a
    @n = ary.size + 1
    @buf = ary + [nil] * (@n - ary.size)
    @head = 0
    @tail = ary.size
    @reverse_count = 0
    self
  end

  def to_a
    __to_a
  end
  # alias to_ary to_a

  private def __to_a(s = @head, t = @tail)
    res = s <= t ? @buf[s...t] : @buf[s..-1].concat(@buf[0...t])
    reversed? ? res.reverse : res
  end

  def to_s
    "#{self.class}#{to_a}"
  end
  # alias inspect to_s

  def inspect
    "Deque#{to_a}(@n=#{@n}, @buf=#{@buf}, @head=#{@head}, @tail=#{@tail}, size #{size}#{" full" if __full?})"
  end

  private def __push(x)
    __extend if __full?
    @buf[@tail] = x
    @tail += 1
    @tail %= @n
    self
  end

  private def __unshift(x)
    __extend() if __full?
    @buf[(@head - 1) % @n] = x
    @head -= 1
    @head %= @n
    self
  end

  private def __pop
    return nil if empty?
    ret = @buf[(@tail - 1) % @n]
    @tail -= 1
    @tail %= @n
    ret
  end

  private def __shift
    return nil if empty?
    ret = @buf[@head]
    @head += 1
    @head %= @n
    ret
  end

  private def __full?
    size >= @n - 1
  end

  private def __slice1(idx)
    sz = size
    return nil if idx < -sz || sz <= idx
    @buf[__index(idx)]
  end

  private def __index(i)
    l = size
    raise IndexError, "index out of range: #{i}" unless -l <= i && i < l
    i = -(i + 1) if reversed?
    i += l if i < 0
    (@head + i) % @n
  end

  private def __extend
    if @tail + 1 == @head
      tail = @buf.shift(@tail + 1)
      @buf.concat(tail).concat([nil] * @n)
      @head = 0
      @tail = @n - 1
      @n = @buf.size
      return
    else
      @buf[(@tail + 1)..(@tail + 1)] = [nil] * @n
      @n = @buf.size
      @head += @n if @head > 0
    end
  end
end

def typical90_044
  n, q = gets.to_s.split.map{ |e| e.to_i }
  a = gets.to_s.split.map{ |e| e.to_i }
  a = Deque.new(a)
  puts a
  q.times do |i|
    t, x, y = gets.to_s.split.map{ |e| e.to_i - 1 }
    case t
    when 0
      a[x], a[y] = a[y], a[x]
    when 1
      a.unshift(a.pop)
    when 2
      puts a[x]
    end
  end
end

# [Pythonで各要素にO\(1\)でランダムアクセスできるdeque\(両端キュー\)を書いてみた \- 30歳で競プロに目覚めた霊長類のブログ](https://prd-xxx.hateblo.jp/entry/2020/02/07/114818)

# <<, pop, unshfit, shift を逆にする。
# self[], self[]= でも、逆にする。
# each, to_a
# to_s は、to_a に依存する。
# pushは、<< に依存。
# digは、self[]に依存。
