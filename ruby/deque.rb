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
  end

  def empty?
    size == 0
  end

  def size
    (@tail - @head) % @n
  end
  alias length size

  def <<(x)
    __extend if __full?
    @buf[@tail] = x
    @tail += 1
    @tail %= @n
    self
  end

  def push(*args)
    args.each{ |x| self << x }
    self
  end
  alias append push

  def unshift(x)
    __extend if __full?
    @head -= 1
    @head %= @n
    @buf[@head] = x
    self
  end
  alias prepend unshift

  def pop
    return nil if size == 0
    @tail -= 1
    @tail %= @n
    @buf[@tail]
  end

  def shift
    return nil if size == 0
    ret = @buf[@head]
    @head += 1
    @head %= @n
    ret
  end

  def last
    @buf[@tail - 1] # self[-1]
  end

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
  alias slice []

  def at(idx)
    slice1(idx)
  end

  private def slice1(idx)
    sz = size
    return nil if idx < -sz || sz <= idx
    @buf[__index(idx)]
  end

  private def slice2(i, cnt)
    sz = size
    i += sz if i < 0
    return nil if cnt < 0 || i > sz

    if i == sz
      Deque[]
    else
      j = [i + cnt - 1, sz].min
      slice_indexes(i, j)
    end
  end

  private def slice_indexes(i, j)
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
    if @head <= @tail
      @buf[@head...@tail] = @buf[@head...@tail].reverse
    else
      sz = size
      @buf[0...sz] = @buf[@head..-1].concat(@buf[0...@tail]).reverse
      @head = 0
      @tail = sz
    end
    self
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
      @buf[@head...@tail].each{ |e| yield e }
    else
      @buf[@head..-1].each{ |e| yield e }
      @buf[0...@tail].each{ |e| yield e }
    end
  end

  def clear
    sz = size
    @head = 0
    @tail = 0
    self
  end

  def join(sep = $,)
    to_a.join(sep)
  end

  # def rotate(cnt = 1)
  #   sz = size
  #   h, t = @head, @tail
  #   # p [sz, h, t]
  #   hh = __index(0)
  #   tt = __index((sz - cnt) % sz) + 1
  #   # if (@head <= @tail) == (h <= t)
  #   #   @head, @tail = @tail, @head
  #   # end
  #   p [sz, h, t, hh, tt]
  #   @head = 1
  #   @tail = 1
  #   self
  # end

  def replace(other)
    ary = other.to_a
    @n = ary.size + 1
    @buf = ary + [nil] * (@n - ary.size)
    @head = 0
    @tail = ary.size
    self
  end

  private def __build(other)
    ary = other.to_a
    @n = ary.size + 1
    @buf = ary + [nil] * (@n - ary.size)
    @head = 0
    @tail = ary.size
    self
  end

  def self.to_a_to_deque(name, args = 0)
    args = (0...args).map{ |i| "a#{i}" }.join(", ")
    code = "def #{name}(#{args})
              Deque.new(to_a.#{name}(#{args}))
            end"
    class_eval(code)
  end

  to_a_to_deque(:compact)

  def rotate(cnt = 0)
    Deque.new(to_a.rotate(cnt))
  end

  def rotate!(cnt = 0)
    replace(to_a.rotate!(cnt))
  end

  def map!(&blk)
    replace(to_a.map!(&blk))
  end

  def sample(n = 1)
    Deque.new(to_a.shuffle)
  end

  def shuffle(n = nil)
    Deque.new(to_a.shuffle(n))
  end

  def shuffle!(n = nil)
    replace(to_a.shuffle!(n))
  end

  def swap(i, j)
    i = __index(i)
    j = __index(j)
    @buf[i], @buf[j] = @buf[j], @buf[i]
    self
  end

  def to_a
    __to_a
  end
  # alias to_ary to_a

  private def __to_a(s = @head, t = @tail)
    s <= t ? @buf[s...t] : @buf[s..-1].concat(@buf[0...t])
  end

  def to_s
    "#{self.class}#{to_a}"
  end
  # alias inspect to_s

  def inspect
    "Deque#{to_a}(@n=#{@n}, @buf=#{@buf}, @head=#{@head}, @tail=#{@tail}, size #{size}#{" full" if __full?})"
  end

  private def __full?
    raise if size > @n - 1
    size == @n - 1
  end

  def __index(i)
    l = size
    raise IndexError, "index out of range: #{i}" unless -l <= i && i < l
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
