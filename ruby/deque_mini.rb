class Deque
  def self.[](*args)
    new(args)
  end

  def initialize(ary = [], capa: 0)
    @capa = [ary.size, capa].max + 1
    @buf = ary + [nil] * (@capa - ary.size)
    @head = 0
    @tail = ary.size
  end

  def size
    (@tail - @head) % @capa
  end
  alias length size

  def empty?()
    size == 0
  end

  private def _full?
    size >= @capa - 1
  end

  private def _extend
    if @tail + 1 == @head
      tail = @buf.shift(@tail + 1)
      @buf.concat(tail).concat([nil] * @capa)
      @head = 0
      @tail = @capa - 1
      @capa = @buf.size
      return
    else
      @buf[(@tail + 1)..(@tail + 1)] = [nil] * @capa
      @capa = @buf.size
      @head += @capa if @head > 0
    end
  end

  def push(x)
    _extend if _full?
    @buf[@tail] = x
    @tail += 1
    @tail %= @capa
    self
  end

  def unshift(x)
    _extend if _full?
    @head -= 1
    @head %= @capa
    @buf[@head] = x
    self
  end

  def pop
    return nil if size == 0
    @tail -= 1
    @tail %= @capa
    @buf[@tail]
  end

  def shift
    return nil if size == 0
    ret = @buf[@head]
    @head += 1
    @head %= @capa
    ret
  end

  def [](i)
    sz = size
    return nil unless -sz <= i && i < sz
    i += size if i < 0
    @buf[(@head + i) % @capa]
  end

  def []=(i, value)
    sz = size
    raise IndexError, "index out of range: #{i}" unless -sz <= i && i < sz
    i += sz if i < 0
    @buf[(@head + i) % @capa] = value
  end

  def ==(other)
    return false unless size == other.size
    to_a == other.to_a
  end

  def to_a
    @head <= @tail ? @buf[@head...@tail] : @buf[@head..-1].concat(@buf[0...@tail])
  end
  # alias to_ary to_a

  # private def _to_a(s = @head, t = @tail)
  #   s <= t ? @buf[s...t] : @buf[s..-1].concat(@buf[0...t])
  # end

  def to_s
    "#{self.class}#{to_a}"
  end
  # alias inspect to_s

  def inspect
    "Deque#{to_a}(@capa=#{@capa}, @buf=#{@buf}, @head=#{@head}, @tail=#{@tail}, size #{size}#{" full" if _full?}#{" empty" if empty?})"
  end
end

p Deque[] == Deque[]
