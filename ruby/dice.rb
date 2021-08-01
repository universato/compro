class Dice
  def initialize(top = 1, bottom = 6, front = 2, back = 5, right = 3, left = 4)
    @top    = 1
    @front  = 2
    @right  = 3
    @left   = 4
    @back   = 5
    @bottom = 6
  end

  attr_accessor :top, :bottom, :front, :back, :right, :left

  men = {top: :bottom, right: :left, front: :back}
  REVERSE_MAP = men.merge(men.invert)

  def reverse(name)
    REVERSE_MAP[name]
  end

  def self.rotate(name, x, y)
    code = <<~RUBY
def rotate_#{name}(n = 1)
  if n == 1
    tmp = @#{x}
    @#{x} = @#{y}
    @#{y} = @#{REVERSE_MAP[x]}
    @#{REVERSE_MAP[x]} = @#{REVERSE_MAP[y]}
    @#{REVERSE_MAP[y]} = tmp
  else
    (n % 4).times{ rotate_#{name} }
  end
end
    RUBY
    class_eval(code)
  end

  rotate :right, :back, :right
  rotate :right, :back, :left
  rotate :north, :top, :back
  rotate :south, :top, :front
  rotate :east, :top, :right
  rotate :west, :top, :left

  # def rotate_right(n == 1)
  #   if n == 1
  #     tmp = @top
  #     @top = @left
  #     @left = @bottom
  #     @bottom = @right
  #     @right = tmp
  #   else
  #     (n % 4).times{ rotate_right }
  #   end
  # end

  # def rotate_left(n == 1)
  #   if n == 1
  #     tmp = @top
  #     @top = @right
  #     @right = @bottom
  #     @bottom = @left
  #     @left = tmp
  #   else
  #     (n % 4).times{ rotate_right }
  #   end
  # end

  # def rotate_front(n == 1)
  #   tmp = @front
  #   @front = @top
  #   @top = @back
  #   @back = @bottom
  #   @bottom = tmp

  #   # tmp = @top
  #   # @top = @back
  #   # @back = @bottom
  #   # @bottom = @front
  #   # @front = tmp
  # end

  # def rotate_back(n == 1)
  #   tmp = @back
  #   @back = @bottom
  #   @bottom = @front
  #   @front = @top
  #   @top = tmp
  # end

  def ==(other)
    @top == other.top &&
    @bottom == other.bottom &&
    @front == other.front &&
    @back == other.back &&
    @right == other.right &&
    @left == other.left
  end
end


# 上から見たときに、上と下を固定して、右回りに回すか、左回しに回すか。
# 上から見たときに、上をどこかに動かす。
