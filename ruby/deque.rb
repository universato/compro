

class Deque
  def initialize(ary, max_size = 300_000)
    @n = [max_size, ary.size].max + 1
    @buf = ary + [nil] * (@n - ary.size)
    @head = 0
    @tail = ary.size
  end

  def __index(i)
    l = size
    raise IndexError("index out of range: #{i}") if not -l <= i && i < l
    i += l if i < 0

    (@head + i) % @n
  end

  def __extend
    ex = @n - 1
    @buf[@tail + 1 ] = [nil] * ex
    @n = @buf.size
    if @head > 0
      @head += ex
    end
  end

  def full?
    size >= @n - 1
  end

  def empty?
    size == 0
  end

  def size
    (@tail - @head) % @n
  end

  def push(x)
    self.__extend if full?
    @buf[@tail] = x
    @tail += 1
    @tail %= @n
  end

  def unshift(x)
    __extend() if full?
    @buf[(@head - 1) % @n] = x
    @head -= 1
    @head %= @n
  end

  def pop
    raise IndexError('pop() when buffer is empty') if empty?
    ret = @buf[(@tail - 1) % @n]
    @tail -= 1
    @tail %= @n
    ret
  end

  def shift
    raise IndexError('popleft() when buffer is empty') if empty?
    ret = @buf[@head]
    @head += 1
    @head %= @n
    ret
  end

  def [](idx)
    @buf[__index(idx)]
  end

  def []=(idx, value)
    @buf[__index(idx)] = value
  end

  def to_s
    "#{self.class}#{@buf[@head, @tail].inspect}"
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
