EPS = 1e-10
COUNTER_CLOCKWISE = 1
CLOCKWISE    = -1
ONLINE_BACK  =  2
ONLINE_FRONT = -2
ON_SEGMENT   =  0
points_position = { 1 => :COUNTER_CLOCKWISE, -1 => :CLOCKWISE, 2 => :ONLINE_BACK, -2 => :ONLINE_FRONT, 0 => :ON_SEGMENT }

class Numeric
  def equals(d); (self-d).abs < EPS end
end

class Point

  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def +(v); Point.new(@x+v.x, @y+v.y) end
  def -(v); Point.new(@x-v.x, @y-v.y) end
  def *(a); Point.new(1.0*@x*a,   1.0*@y*a) end
  def /(a); Point.new(1.0*@x/a,   1.0*@y/a) end

  def norm; @x**2 + @y**2 end
  def abs; norm**0.5 end
  def dist(v=nil);
    v = Point.new(0,0) if v.nil?
    ((x-v.x)**2 + (y-v.y)**2)**(0.5)
  end

  def <(v); @x!=v.x ? @x<v.x : @y<v.y end
  def >(v); @x!=v.x ? @x>v.x : @y>v.y end
  def <=(v); @x!=v.x ? @x<v.x : @y<=v.y end
  def >=(v); @x!=v.x ? @x>v.x : @y>=v.y end
  #def <=>(v); @x!=v.x ? @x<=>v.x : @y<=>v.y end
  def ==(v); (@x-v.x).abs < EPS && (@y-v.y).abs < EPS end

  def dot(v); @x*v.x + @y*v.y end
  def cross(v); @x*v.y - @y*v.x end

  def orthogonal?(v); dot(v).equals(0.0) end
  def parallel?(v); cross(v).equals(0.0) end

  def project(l)
    base = l.t - l.s
    r = 1.0 * (self-l.s).dot(base) / base.norm
    l.s + base * r
  end

  def reflect(l); self + (project(l) - self) * 2 end
  def getDistance(v) (self-v).abs end

  def ccw(v1,v2)
    a = v1 - self
    b = v2 - self
    return COUNTER_CLOCKWISE if a.cross(b) >  EPS
    return CLOCKWISE         if a.cross(b) < -EPS
    return ONLINE_BACK       if a.dot(b)   < -EPS
    return ONLINE_FRONT      if a.norm     < b.norm
    return ON_SEGMENT
  end

  # 三点が作る三角形の面積
  def area(v1,v2=nil)
    v2 = Point.new(0,0) if v2.nil?
    a = self - v2
    b = v1   - v2
    (a.x * b.y - a.y * b.x ) / 2.0
  end

  def arg; Math.atan2(y, x) end
  def rot90; Point.new(-y,x) end

  def to_s; "#{x.round(12)} #{y.round(12)}" end
  #def to_s; "#{x} #{y}" end
  def inspect; "(#{x}, #{y})" end
  def out; puts "#{x} #{y}" end
end

class Line

  attr_accessor :s, :t

  def initialize(s, t)
    @s = s
    @t = t
  end

  def orthogonal?(l); (0.0).equals( (@s-@t).dot( l.s-l.t ) ) end
  def parallel?(l); (0.0).equals( (@s-@t).cross( l.s-l.t ) ) end

  def project(v);
    base = @t - @s
    r = 1.0 * (v-@s).dot(base) / base.norm
    @s + base * r
  end

  def reflect(v); v + (project(v) - v) * 2.0 end
  def getDistanceLP(v); ( (@t-@s).cross(v-@s) / (@t-@s).abs ).abs end
  def getDistanceSP(v);
    return (v-@s).abs if (@t-@s).dot(v-@s) < 0.0
    return (v-@t).abs if (@s-@t).dot(v-@t) < 0.0
    getDistanceLP(v)
  end

  def intersect?(l);
    @s.ccw(@t, l.s) * @s.ccw(@t,l.t) <= 0 && l.s.ccw(l.t, @s) * l.s.ccw(l.t, @t) <= 0
  end

  def getDistance(l);
    return 0.0 if intersect?(l)
    res = getDistanceSP(l.s)
    m1 = getDistanceSP(l.t)
    m2 = l.getDistanceSP(@s)
    m3 = l.getDistanceSP(@t)
    res = m1 if res > m1
    res = m2 if res > m2
    res = m3 if res > m3
    res
  end

  # 切断のところで修正した。d2への代入のl.t -> l.s
  # これよくわからないので作りなおした。削除する?
  # def getCrossPoint(l)
  #   base = l.t - l.s
  #   d1   = base.cross(@s-l.s).abs
  #   d2   = base.cross(@t-l.t).abs #
  #   # d2 = base.cross(@t-l.s).abs
  #   t    = 1.0 * d1 / (d1+d2)
  #   @s + (@t-@s) * t
  # end

  #　作りなおしたもの
  def getCrossPoint(l)
    base = t - s
    d1   = base.cross(l.t - l.s).abs
    d2   = base.cross(t   - l.s).abs #
    return l.s if d1.abs < EPS && d2.abs < EPS # same line!!
    return STDERR.puts "!!!PRECONDITION NOT SATISFIED!!!" if d1.abs < EPS
    l.s + (l.t-l.s) * 1.0 * d2/d1
  end
  def ==(other); s == other.s and t == other.t; end
  def to_s; "#{s.to_s} #{t.to_s}" end
  def inspect; "[(#{s.x}, #{s.y}) -> (#{t.x}, #{t.y})]" end
end

class Polygon

  attr_accessor :points

  def initialize(points=[])
    @points = points
    @n = @points.size
  end

  def add_point(v); @points.push(v) end
  def push(v); @points.push(v) end
  def pop; points.pop end

  def area
    s = 0.0
    o = @points[-1]
    (@points.size-1).times do |i|
      s += o.area(@points[i-1],@points[i])
    end
    s.abs
  end

  def convex?
    n = @points.size
    if n == 3
      x = @points[0]
      y = @points[1]
      z = @points[2]
      return x.ccw(y,z).abs == 1 ? true : false
    end
    n.times do |i|
      x = @points[i]
      y = @points[(i+1)%n]
      z = @points[(i+2)%n]
      return false if x.ccw(y,z) == CLOCKWISE || x.ccw(y,z) == ONLINE_BACK
    end
    true
  end

  ON_EDGE = 1
  IN_POLYGON = 2
  OUT_OF_POLYGON = 0
  def include?(v)
    n = @points.size
    f = false
    n.times do |i|
      a = @points[i] - v
      b = @points[(i+1)%n] - v
      return 1 if a.cross(b).abs < EPS && a.dot(b) < EPS
      a, b = b, a if a.y > b.y
      f = !f if a.y < EPS && EPS < b.y && a.cross(b) > EPS
    end
    f ? 2 : 0
  end

  def sort!;
    points.sort!{ |a,b| (a.y <=> b.y).nonzero? || a.x <=> b.x }
  end

  def andrewScan
    u = Polygon.new
    l = Polygon.new
    return self if size < 3
    self.sort!

    u.push points[0]
    u.push points[1]
    l.push points[-1]
    l.push points[-2]

    (2...size).each do |i|
      (u.size).downto(2) do |n|
        break if u.points[n-2].ccw(u.points[n-1], points[i]) != COUNTER_CLOCKWISE
        u.pop
      end
      u.push(points[i])
    end

    (size-3).downto(0) do |i|
      (l.size).downto(2) do |n|
        break if l.points[n-2].ccw(l.points[n-1], points[i]) != COUNTER_CLOCKWISE
        l.pop
      end
      l.push(points[i])
    end

    # u.out
    # l.out
    # puts "l"

    l.points.reverse!
    # l.out
    (u.size-2).downto(1){ |i| l.push(u.points[i]) }
    l
  end

  def diameter
    n = size
    is = js = 0
    n.times do |i|
      is = i if points[i].y > points[is].y
      js = i if points[i].y < points[js].y
    end

    dmax = (points[is]-points[js]).dist

    i = maxi = is
    j = maxj = js
    loop do
      if (points[(i+1)%n] - points[i]).cross(points[(j+1)%n]-points[j]) >= 0
        j = (j+1) % n
      else
        i = (i+1) % n
      end
      d = (points[i]-points[j]).dist
      if d > dmax
        dmax = d
        maxi = i
        maxj = j
      end
      break if i == is && j == js
    end
    dmax
  end

  def cut(ln)
    n = size
    q = Polygon.new()
    n.times do |i|
      cur = points[i]
      nex = points[(i+1)%n]
      q.push(cur) if (ln.s).ccw(ln.t, cur) != CLOCKWISE
      q.push(ln.getCrossPoint(line(cur,nex))) if (ln.s).ccw(ln.t, cur) *  (ln.s).ccw(ln.t, nex) < 0
      # if (ln.s).ccw(ln.t, cur) *  (ln.s).ccw(ln.t, nex) < 0
      #   p [ln, cur, nex, line(cur,nex)]
      #   p ln.getCrossPoint(line(cur,nex))
      # end
    end
    q
  end

  def out
    puts size
    points.each do |point|
      puts point
    end
  end

  def pout
    puts size
    points.each do |point|
      p point
    end
  end

  def contain?(v); include(v) end
  def size; points.size; end
end

class Circle

  attr_accessor :c, :r

  def initialize(c, r)
    @c = c
    @r = r
  end

  def relation(other)
    d = (c-other.c).dist

    r_sum = r + other.r
    return 4 if d > r_sum
    return 3 if d == r_sum

    r0, r1 = r, other.r
    r0, r1 = other.r, r if other.r < r
    r_diff = r1 - r0
    return 2 if d > r_diff # && d < r_sum
    STDERR.puts "完全一致" if r_diff == 0 && d == 0
    return 1 if d == r_diff
    return 0 # if d < r_diff
  end
  alias number_of_common_tangents relation

  def getCrossPoints(other)

    if other.instance_of?(Line)
      l = other
      STDERR.puts "円と線は交わらない中(接していない含む)、交点を求めようとしました" if l.getDistanceLP(c) > r
      pr  = l.project(c)
      e    = (l.t - l.s) / (l.t - l.s).abs * 1.0 #単位ベクトル
      base = (r * r - (pr - c).norm)**0.5
      t = e * base
      return [pr - t, pr + t].sort{ |a,b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
    elsif other.instance_of?(Circle)
      # 途中、螺旋本p.397
      d = c.dist(other.c)
      STDERR.puts "両円が交わらない中(接していない含む)、交点を求めようとしました" if d > r + other.r
      a = Math.acos( Rational(r**2 + d**2 - other.r**2, 2.0*r*d))
      t = (other.c-c).arg
      return [c + polar(r, t+a), c+polar(r,t-a)].sort{ |a,b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
    end
  end

  def common_tangent(other)

    if other.instance_of?(Point)
      # refer to drken-san
      # http://judge.u-aizu.ac.jp/onlinejudge/review.jsp?rid=3140448#1
      d = (other - c).norm
      l = d - r * r
      return Point.new(0,0) if l < -EPS
      l = 0.0 if l <= 0.0
      cq = (other - c) * (r * r / d)
      qs = ( (other-c) * (r * l**0.5 / d) ).rot90
      return [c + cq + qs, c + cq - qs].sort{ |a,b| (a.x <=> b.x).nonzero? || a.y <=> b.y }
    elsif other.instance_of?(Circle)

      # 工事中。

    end
    p "???"
  end
end

def point(x,y) Point.new(x,y) end
alias xy point

def line(a,b=nil,c=nil,d=nil)
  if b
    c ? Line.new( xy(a,b), xy(c,d) ) : Line.new(a, b)
  else
    Line.new(a[0],a[1],a[2],a[3])
  end
end
def circle(x,y,r) Circle.new(Point.new(x,y),r) end

def triangle(a,b=nil,c=nil,d=nil,e=nil,f=nil)
  res = Polygon.new()
  if f
    res.push(point(a,b))
    res.push(point(c,d))
    res.push(point(e,f))
  end
  res
end

def rect(x, y, w, h)
  res = Polygon.new()
  res.push(x,y)
  res.push(x+h,y)
  res.push(x+w,y+h)
  res.push(x,y+h)
  res
end

def polar(a, r); Point.new((Math.cos(r) * a).round(13), (Math.sin(r) * a).round(13)); end

require 'minitest/autorun'

class Geometry_Test < Minitest::Test
  def test_projection_CGL_1_A
    o = point(0,0)
    a = point(3,4)
    b = point(2,5)
    assert_equal point(3.12, 4.16), line(o,a).project(b)
    c = point(2,0)
    assert_equal point(-1.0, 0.0), line(o,c).project(xy(-1,1))
    assert_equal point( 0.0, 0.0), line(o,c).project(xy(0, 1))
    assert_equal point( 1.0, 0.0), line(o,c).project(xy(1, 1))
    x_axis = line(0,0,1,0)
    y_axis = line(0,0,0,1)
    assert_equal point( 5, 0), x_axis.project(point(5,5))
    assert_equal point( 0, 5), y_axis.project(point(5,5))
  end
  def test_reflection_CGL_1_B
    l = line(0,0,3,4)
    x_axis = line(0,0,1,0)
    y_axis = line(0,0,0,1)
    assert_equal point(4.24, 3.32), l.reflect(point(2,5))
    assert_equal point(3.56, 2.08), l.reflect(point(1,4))
    assert_equal point(2.88, 0.84), l.reflect(point(0,3))
    assert_equal point( 5, -5), x_axis.reflect(point(5,5))
    assert_equal point(-5,  5), y_axis.reflect(point(5,5))
  end
  def test_lines_relation_CGL_2_A
    l = line(0,0,3,0)
    assert l.parallel?(line(0,2,3,2))
    assert !l.orthogonal?(line(0,2,3,2))
    assert l.orthogonal?(line(1,1,1,4))
    assert !l.parallel?(line(1,1,1,4))
    assert !l.parallel?(line(1,1,2,2))
    assert !l.orthogonal?(line(1,1,2,2))
  end
  def test_segments_relation_CGL_2_B
    s = line(0,0,3,0)
    assert s.intersect?(line(1,1,2,-1))
    assert s.intersect?(line(3,1,3,-1))
    assert !s.intersect?(line(3,-2,5,0))
  end
  def test_cross_point_CGL_2_C
    assert_equal point(  1,  0), line(0,0,2,0).getCrossPoint(line(1,1,1,-1))
    assert_equal point(0.5,0.5), line(0,0,1,1).getCrossPoint(line(0,1,1, 0))
    assert_equal point(0.5,0.5), line(0,0,1,1).getCrossPoint(line(1,0,0, 1))
  end
  def test_distance_between_segments_CGL_2_D
    assert_equal 1, line(0,0,1,0).getDistance(line(0,1,1,1))
    # 小数点未満でエラーがでてしまう。誤差だと思う。たぶん答えが√2
    # assert_equal 1.414213562373095048, line(0,0,1,0).getDistance(line(2,1,1,2))
    assert_equal 0, line(-1,0,1,0).getDistance(line(0,1,1,-1))
  end
  def test_area_CGL_3_A
    assert_equal 2.0, triangle(0,0,2,2,-1,1).area
    assert_equal 1.5, Polygon.new([point(0,0),point(1,1),point(1,2),point(0,2)]).area
  end
  def test_convex_CGL_4_A
    assert  Polygon.new([point(0,0),point(3,1),point(2,3),point(0,3)]).convex?
    assert !Polygon.new([point(0,0),point(2,0),point(1,1),point(2,2),point(0,2)]).convex?
  end
  def test_diameter_CGL_4_B
    assert_equal 4,triangle(0, 0,  4, 0,  2, 2).diameter
    assert_equal 1.414213562373095048, Polygon.new([point(0,0),point(1,0),point(1,1),point(0,1)]).diameter
  end
end

# x,y = gets.to_s.split.map{|t|t.to_f}
# xc,yc,r = gets.to_s.split.map{|t|t.to_f}
# xc1,yc1,r1 = gets.to_s.split.map{|t|t.to_f}
# v = Point.new(x,y)
# c = Circle.new(xy(xc,yc), r)

# ans = c.common_tangent(v)
# puts ans

# q = gets.to_s.to_i

# q.times do
#   xs,ys,xt,yt = gets.to_s.split.map{|t|t.to_f}
#   ln = line(xs,ys,xt,yt)

#   ans = c.getCrossPoints(ln)
#   puts "#{ans[0]} #{ans[1]}"
# end


# n = gets.to_s.to_i

# g = Polygon.new
# n.times do
#   x,y = gets.to_s.split.map{|t|t.to_f}
#   g.add_point(xy(x,y))
# end
# # p g.area
# q = gets.to_s.to_i
# q.times do
#   xs,ys,xt,yt = gets.to_s.split.map{|t|t.to_f}
#   l = line(xs,ys,xt,yt)
#   # p l
#   # g.cut(l).pout
#   puts g.cut(l).area
# end
