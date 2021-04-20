class Dice
  def initialize(top = 1, bottom = 6, front = 2, back = 5, right = 3, left = 4)
    @top    = 1
    @front  = 2
    @right  = 3
    @left   = 4
    @back   = 5
    @bottom = 6
  end

  def rotate_right
    tmp = @top
    @top = @left
    @left = @bottom
    @bottom = @right
    @right = tmp
  end

  def rotate_left
    tmp = @top
    @top = @right
    @right = @bottom
    @bottom = @left
    @left = tmp
  end

  def rotate_front
    tmp = @front
    @front = @top
    @top = @back
    @back = @bottom
    @bottom = tmp

    # tmp = @top
    # @top = @back
    # @back = @bottom
    # @bottom = @front
    # @front = tmp
  end

  def rotate_back
    tmp = @back
    @back = @bottom
    @bottom = @front
    @front = @top
    @top = tmp
  end
end
