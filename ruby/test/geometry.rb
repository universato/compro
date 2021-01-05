require_relative '../geometry.rb'

require 'minitest'
require 'minitest/autorun'

class PointTest < Minitest::Test
  def test_origin
    o = Point.new(0.0, 0.0)
    assert_equal o, o + o
    assert_equal o, o - o
    assert_equal o, o * 1
    assert_equal o, o / 2
    assert_equal o, -o

    a = Point.new(2.0, 3.0)
    assert_equal a, a + o
    assert_equal a, o + a
    assert_equal a, a - o
    assert_equal -a, o - a
    assert_equal Point(-2.0, -3.0), -a
    assert_equal o, a * 0.0
  end

  def test_parallel
    a = Point.new(2.0, 3.0)
    assert a.parallel?(a + a)
    assert a.parallel?(a * 2.0)
    assert a.parallel?(a * -1.0)
    assert a.parallel?(a * 0.0)
    assert a.parallel?(a / 10)
  end

  def test_abs
    a = Point.new(3.0, 4.0)
    assert_equal 25.0, a.abs2
    assert_equal 5.0, a.abs
    assert_equal 5.0, a.dist
    assert_equal 5.0, a.dist(Point.origin)
    assert_equal 5.0, a.distance_to_point(Point.origin)
    # assert_equal 5.0, -a.abs
    assert_equal 5.0, (-a).abs
    assert_equal 5.0, (-a).dist
    assert_equal 5.0, (-a).distance_to_point(Point.origin)
  end

  def test_dot
    ex = point(1, 0)
    ey = point(0, 1)
    assert_equal 1, ex.cross(ey)
    assert_equal -1, (ex).cross(-ey)
    assert_equal -1, (-ex).cross(ey)
    assert_equal 1, (-ex).cross(-ey)

    assert_equal 5, ex.cross(ey * 5)
    assert_equal 25, (ex * 5).cross(ey * 5)
  end

  def test_orthogonal?
    ex = Point.new(1.0, 0.0)
    ey = Point.new(0.0, 1.0)
    assert ex.orthogonal?(ey)
    assert !ex.parallel?(ey)
  end

  def test_distance
    o = Point.origin
    assert_equal 1, o.distance_to_line(line(1.0, 0.0, 1.0, 1.0))
    assert_equal 1, o.distance_to_line(line(0.0, 1.0, 1.0, 1.0))
    assert_equal 3, o.distance_to_line(line(3.0, 4.0, 3.0, 400))
    assert_equal 5, o.distance_to_segment(segment(3.0, 4.0, 3.0, 400))

    a = Point.new(1.0, 1.0)
    ex = Line.new(o, xy(1.0, 0.0))
    ey = Line.new(o, xy(0.0, 1.0))
    assert_equal 1, a.distance_to_line(ex)
    assert_equal 1, a.distance_to_line(ey)
    assert_equal 1, a.distance_to(ex)
    assert_equal 1, a.distance_to(ey)

    sx = Segment.new(o, xy(1.0, 0.0))
    sy = Segment.new(o, xy(0.0, 1.0))
    assert_equal 1, a.distance_to_segment(sx)
    assert_equal 1, a.distance_to_segment(sy)
    assert_equal 1, a.distance_to(sx)
    assert_equal 1, a.distance_to(sy)

    x = Point.new(-3, -4)
    assert_equal 4, x.distance_to(ex)
    assert_equal 3, x.distance_to(ey)
    assert_equal 5, x.distance_to(sx)
    assert_equal 5, x.distance_to(sy)
  end

  def test_reflect
    o = Point.origin
    ex = Line.new(o, xy(1.0, 0.0))
    ey = Line.new(o, xy(0.0, 1.0))

    a = Point.new(1.0, 1.0)
    assert_equal point(1.0, -1.0), a.reflect(ex)
    assert_equal point(-1.0, 1.0), a.reflect(ey)

    line45 = a.to_line
    assert_equal point(0.0, 1.0), point(1.0, 0.0).reflect(line45)
    assert_equal point(1.0, 0.0), point(0.0, 1.0).reflect(line45)
    assert_equal point(-1.0, 1.0), point(1.0, -1.0).reflect(line45)
  end

  include Math

  def test_polar
    assert_equal [sqrt(2), TAU / 8], point(1.0, 1.0).polar
    assert_equal [1, 0], point(1.0, 0.0).polar
    assert_equal [1, TAU / 4], point(0.0, 1.0).polar
  end
end

# Line
class LineTest < Minitest::Test
  def test_ccw
    # { COUNTER_CLOCKWISE: 1, CLOCKWISE: -1, ONLINE_BACK: 2, ONLINE_FRONT: -2, ON_SEGMENT: 0 }
    ex = line(0.0, 0.0, 1.0, 0.0)
    assert_equal 1, ex.ccw(point(1.0, 1.0))
    assert_equal -1, ex.ccw(point(1.0, -1.0))
    assert_equal -2, ex.ccw(point(2.0, 0.0))
    assert_equal 2, ex.ccw(point(-2.0, 0.0))
    assert_equal 0, ex.ccw(point(1.0, 0.0))
  end
end

# Segment
class SegmentTest < Minitest::Test
  def test_revese
    s = segment(0.0, 1.0, -2.0, -5.0)
    r = segment(-2.0, -5.0, 0.0, 1.0)
    assert_equal Segment, s.reverse.class
    assert_equal r, s.reverse
  end

  def test_distance
    # { COUNTER_CLOCKWISE: 1, CLOCKWISE: -1, ONLINE_BACK: 2, ONLINE_FRONT: -2, ON_SEGMENT: 0 }
    c = circle(0.0, 0.0, 1.0)
    s = segment(2.0, 0.0, 2.0, 50.0)
    assert_equal 1, s.distance_to_circle(c)
    assert_equal 1, s.reverse.distance_to_circle(c)
    assert_equal 1, s.reverse.distance_to_circle(c)

    s = segment(5.0, 0.0, 5.0, 9.0)
    assert_equal 4.0, s.distance_to_circle(c)
    assert_equal 4.0, s.reverse.distance_to_circle(c)

    s = segment(2.0, 0.0, 5.0, 9.0)
    assert_equal 1.0, s.distance_to_circle(c)
    assert_equal 1.0, s.reverse.distance_to_circle(c)
  end
end

# Polygon
class PolygonTest < Minitest::Test
  def test_area
    g = Polygon.new([0, 0, 1, 0, 0, 1].to_points)
    assert_equal 0.5, g.area

    g = Polygon.new([0.0, 0.0, 1.0, 0.0, 0.0, 1.0].to_points)
    assert_equal 0.5, g.area
  end

  def test_center_of_gravity
    g = Polygon.new([0, 0, 1, 0, 1, 1, 0, 1].to_points)
    assert_equal xy(0.5, 0.5), g.center_of_gravity

    g = Polygon.new([0.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0].to_points)
    assert_equal xy(0.5, 0.5), g.center_of_gravity
  end
end

# Triangle
class TriagngleTest < Minitest::Test
  def test_area
    t = triangle(0, 0, 1, 0, 0, 1)
    assert_equal 0.5, t.area

    t = triangle(0.0, 0.0, 1.0, 0.0, 0.0, 1.0)
    assert_equal 0.5, t.area

    t = triangle(0, 0, 1, 0, 0, -1)
    assert_equal 0.5, t.area

    t = triangle(0, 0, 2, 0, 0, -1)
    assert_equal 1, t.area
  end
end

# Circle
class CircleTest < Minitest::Test
  include Math

  def test_area
    assert_equal PI, circle(0, 0, 1).area
    assert_equal PI, circle(9, 9, 1).area
    assert_equal 4 * PI, circle(0, 0, 2).area
  end

  def test_length
    assert_equal TAU, circle(0, 0, 1).length
    assert_equal TAU, circle(9, 9, 1).length
    assert_equal TAU * 10, circle(0, 0, 10).length
  end

  def test_area_of_intersection
    c0 = circle(0, 0, 1)
    c1 = circle(0, 0, 2)
    c2 = circle(9, 0, 1)
    assert_equal PI, c0.area_of_intersection_with_circle(c1)
    assert_equal PI, c1.area_of_intersection_with_circle(c0)
    assert_equal 0, c2.area_of_intersection_with_circle(c0)
    assert_equal 0, c0.area_of_intersection_with_circle(c2)
  end
end

def naive_closest_pair(points)
  points.permutation(2).min_by{ |x, y| x.dist(y) }
end
class GeometryTest < Minitest::Test
  def test_projection_CGL_1_A
    o = point(0, 0)
    a = point(3, 4)
    b = point(2, 5)
    assert_equal point(3.12, 4.16), line(o, a).project(b)
    c = point(2, 0)
    assert_equal point(-1.0, 0.0), line(o, c).project(xy(-1, 1))
    assert_equal point(0.0, 0.0), line(o, c).project(xy(0, 1))
    assert_equal point(1.0, 0.0), line(o, c).project(xy(1, 1))
    x_axis = line(0, 0, 1, 0)
    y_axis = line(0, 0, 0, 1)
    assert_equal point(5, 0), x_axis.project(point(5, 5))
    assert_equal point(0, 5), y_axis.project(point(5, 5))
  end

  def test_reflection_CGL_1_B
    l = line(0, 0, 3, 4)
    x_axis = line(0, 0, 1, 0)
    y_axis = line(0, 0, 0, 1)
    assert_equal point(4.24, 3.32), l.reflect(point(2, 5))
    assert_equal point(3.56, 2.08), l.reflect(point(1, 4))
    assert_equal point(2.88, 0.84), l.reflect(point(0, 3))
    assert_equal point(5, -5), x_axis.reflect(point(5, 5))
    assert_equal point(-5, 5), y_axis.reflect(point(5, 5))
  end

  def test_counter_clockwise_CGL_1_C
    # { COUNTER_CLOCKWISE: 1, CLOCKWISE: -1, ONLINE_BACK: 2, ONLINE_FRONT: -2, ON_SEGMENT: 0 }
    l = line(0, 0, 2, 0)
    assert_equal COUNTER_CLOCKWISE, l.ccw(point(-1, 1))
    assert_equal CLOCKWISE, l.ccw(point(-1, -1))
    assert_equal ON_SEGMENT, l.ccw(point(0, 0))
    assert_equal ONLINE_BACK, l.ccw(point(-1, 0))
    assert_equal ONLINE_FRONT, l.ccw(point(3, 0))
  end

  def test_lines_relation_CGL_2_A
    l = line(0, 0, 3, 0)
    assert l.parallel?(line(0, 2, 3, 2))
    assert !l.orthogonal?(line(0, 2, 3, 2))
    assert l.orthogonal?(line(1, 1, 1, 4))
    assert !l.parallel?(line(1, 1, 1, 4))
    assert !l.parallel?(line(1, 1, 2, 2))
    assert !l.orthogonal?(line(1, 1, 2, 2))
  end

  def test_segments_relation_CGL_2_B
    s = line(0, 0, 3, 0)
    assert s.intersect?(line(1, 1, 2, -1))
    assert s.intersect?(line(3, 1, 3, -1))
    assert !s.intersect?(line(3, -2, 5, 0))
  end

  def test_cross_point_CGL_2_C
    assert_equal point(1, 0), line(0, 0, 2, 0).cross_point(line(1, 1, 1, -1))
    assert_equal point(0.5, 0.5), line(0, 0, 1, 1).cross_point(line(0, 1, 1, 0))
    assert_equal point(0.5, 0.5), line(0, 0, 1, 1).cross_point(line(1, 0, 0, 1))
  end

  def test_distance_between_segments_CGL_2_D
    assert_equal 1, segment(0, 0, 1, 0).distance_to(segment(0, 1, 1, 1))
    assert EPS > (1.41421356237309504880 - line(0, 0, 1, 0).distance_to(line(2, 1, 1, 2))).abs
    assert EPS > (Math.sqrt(2) - line(0, 0, 1, 0).distance_to(line(2, 1, 1, 2))).abs
    assert_equal 0, line(-1, 0, 1, 0).distance_to(line(0, 1, 1, -1))
  end

  def test_area_CGL_3_A
    assert_equal 2.0, triangle(0, 0, 2, 2, -1, 1).area
    assert_equal 1.5, Polygon.new([point(0, 0), point(1, 1), point(1, 2), point(0, 2)]).area
  end

  def test_convex_CGL_3_B
    assert  Polygon.new([point(0, 0), point(3, 1), point(2, 3), point(0, 3)]).convex?
    assert !Polygon.new([point(0, 0), point(2, 0), point(1, 1), point(2, 2), point(0, 2)]).convex?
  end

  def test_contain_point_CGL_3_C
    points = [0, 0, 3, 1, 2, 3, 0, 3].to_points
    assert_equal 2, Polygon.new(points).contain(point(2, 1))
    assert_equal 1, Polygon.new(points).contain(point(0, 2))
    assert_equal 0, Polygon.new(points).contain(point(3, 2))
  end

  def test_convex_full_CGL_4_A
    g = Polygon.new([2, 1, 0, 0, 1, 2, 2, 2, 4, 2, 1, 3, 3, 3].to_points)
    h = Polygon.new([0, 0, 2, 1, 4, 2, 3, 3, 1, 3].to_points)
    assert_equal h, g.andrew_scan
  end

  def test_diameter_CGL_4_B
    assert_equal 4, triangle(0, 0, 4, 0, 2, 2).diameter
    g = Polygon.new([point(0, 0), point(1, 0), point(1, 1), point(0, 1)])
    assert_equal 1.414213562373095048, g.diameter
  end

  def test_diameter_CGL_4_C
    g = Polygon.new([1, 1, 4, 1, 4, 3, 1, 3].to_points)
    assert_equal 2, g.cut(line(2, 0, 2, 4)).area
    assert_equal 4, g.cut(line(2, 4, 2, 0)).area
  end

  def test_closest_pair_CGL_5_A
    g = Polygon.new([0.0, 0.0, 1.0, 0.0].to_points)
    x, y = g.closest_pair
    assert_equal 1.0, x.dist(y)

    g = Polygon.new([0.0, 0.0, 2.0, 0.0, 1.0, 1.0].to_points)
    x, y = g.closest_pair
    assert_equal Math.sqrt(2), x.dist(y)

    # testcase #7
    points = [[0.002169, 0.002932], [0.002256, 0.003119], [0.004711, 0.003351], [0.004800, 1.000000], [0.004862, 0.003484]].flatten.to_points
    g = Polygon.new(points)
    x, y = g.closest_pair
    assert_equal 0.00020624742422634015, x.dist(y)
  end

  def test_diameter_CGL_7_A
    assert_equal 4, circle(1, 1, 1).relation(circle(6, 2, 2))
    assert_equal 3, circle(1, 2, 1).relation(circle(4, 2, 2))
    assert_equal 2, circle(1, 2, 1).relation(circle(3, 2, 2))
    assert_equal 1, circle(0, 0, 1).relation(circle(1, 0, 2))
    assert_equal 0, circle(0, 0, 1).relation(circle(0, 0, 2))
  end

  def test_inscribed_circle_CGL_7_B
    t = triangle(1, -2, 3, 2, -2, 0)
    x, y, r = [0.53907943898209422325, -0.26437392711448356856, 1.18845545916395465278]
    assert_equal circle(x, y, r), t.inscribed_circle

    t = triangle(0, 3, 4, 0, 0, 0)
    x, y, r = [1.0, 1.0, 1.0]
    assert_equal circle(x, y, r), t.inscribed_circle
  end

  def test_circumscribed_circle_CGL_7_C
    t = triangle(1, -2, 3, 2, -2, 0)
    x, y, r = [0.6250, 0.68750, 2.71353666826155124291]
    assert_equal circle(x, y, r), t.circumscribed_circle

    t = triangle(0, 3, 4, 0, 0, 0)
    x, y, r = [2.0, 1.5, 2.5]
    assert_equal circle(x, y, r), t.circumscribed_circle

    # testcase #25
    t = triangle(-10_000, -10_000, 10_000, -10_000, 10_000, 10_000)
    x, y, r = [-0.0, -0.0, 14142.13562373095048840810]
    assert_equal circle(x, y, r), t.circumscribed_circle

    # testcase #27
    t = triangle(-10_000, 10_000, 10_000, -9999, 9999, -10_000)
    x, y, r = [-0.24999374984374609366, 0.24999374984374609366, 14_141.78207917941295512776]
    assert_equal circle(x, y, r), t.circumscribed_circle

    # testcase #29 # Floatで計算し始めると誤差でWA
    # @r=18000002.27777764までは一致するけど、18000002.27777764060は本当なのか謎。
    # t = triangle(-10_000, 0, -8000, 1, 10_000, 0)
    # x, y, r = [-0.0, -17999999.5, 18000002.27777764060374465771]
    # assert_equal circle(x, y, r), t.circumscribed_circle
  end

  def test_cross_points_CGL_7_D
    c = Circle.new(xy(2, 1), 1)

    l = Line.new(xy(0, 1), xy(4, 1))
    points = [xy(1.00000000, 1.00000000), xy(3.00000000, 1.00000000)]
    assert_equal points, c.cross_points(l)

    l = Line.new(xy(3, 0), xy(3, 3))
    points = [xy(3.00000000, 1.00000000), xy(3.00000000, 1.00000000)]
    assert_equal points, c.cross_points(l)
  end

  def test_cross_points_CGL_7_E
    c1 = Circle.new(xy(0, 0), 2)
    c2 = Circle.new(xy(2, 0), 2)
    points = [xy(1.0000000, -1.73205080), xy(1.000000, 1.73205080)]
    # assert_equal points, c1.cross_points(c2)

    c1 = Circle.new(xy(0, 0), 2)
    c2 = Circle.new(xy(0, 3), 1)
    points = [xy(0.0, 2.0), xy(0.0, 2.0)]
    assert_equal points, c1.cross_points(c2)
  end

  def test_cross_points_CGL_7_F
    o = Point.new(0.0, 0.0)
    c = Circle.new(xy(2, 2), 2)
    points = [xy(0.0, 2.0), xy(2.0, 0.0)]
    assert_equal points, c.contact_points(o).sort
    assert_equal points, c.contact_points_with_point(o).sort

    v = Point.new(-3.0, 0.0)
    c = Circle.new(xy(2, 2), 2)
    points = [xy(0.6206896552, 3.4482758621), xy(2.0, 0.0)]
    assert_equal points, c.contact_points(v).sort
    assert_equal points, c.contact_points_with_point(v).sort
  end

  def test_cross_points_CGL_7_G
    c1 = circle(1, 1, 1)
    c2 = circle(6, 2, 2)
    actual = c1.common_tangent_to_circle(c2).map{ |line| line.s }.sort
    expected = [
      0.6153846154, 1.9230769231,
      1.0000000000, 0.0000000000,
      1.4183420913, 1.9082895434,
      1.7355040625, 0.3224796874,
    ].to_points
    assert_equal expected, actual

    c1 = circle(1, 2, 1)
    c2 = circle(4, 2, 2)
    actual = c1.common_tangent_to_circle(c2).map{ |line| line.s }.sort
    expected = [
      0.6666666667, 1.0571909584,
      0.6666666667, 2.9428090416,
      2.0000000000, 2.0000000000,
    ].to_points
    assert_equal expected, actual

    c1 = circle(1, 2, 1)
    c2 = circle(3, 2, 2)
    actual = c1.common_tangent_to_circle(c2).map{ |line| line.s }.sort
    expected = [
      0.5, 1.1339745962,
      0.5, 2.8660254038,
    ].to_points
    assert_equal expected, actual

    c1 = circle(0, 0, 1)
    c2 = circle(1, 0, 2)
    actual = c1.common_tangent_to_circle(c2).map{ |line| line.s }.sort
    expected = [-1.0, 0.0].to_points
    assert_equal expected, actual

    c1 = circle(0, 0, 1)
    c2 = circle(0, 0, 2)
    actual = c1.common_tangent_to_circle(c2).map{ |line| line.s }.sort
    expected = [].to_points
    assert_equal expected, actual

    c1 = circle(0, 5, 2)
    c2 = circle(3, 0, 1)
    actual = c1.common_tangent_to_circle(c2).map{ |line| line.s }.sort
    expected = [
      -1.5131066607, 3.6921360036,
      -0.9411764706, 3.2352941176,
      1.8660478372, 5.7196287023,
      2.0000000000, 5.0000000000,
    ].to_points
    assert_equal expected, actual
  end

  def test_cross_points_CGL_7_I
    c1 = circle(0, 0, 1)
    c2 = circle(2, 0, 2)
    assert_equal 1.40306643968573875104, c1.area_of_intersection_with_circle(c2)

    c1 = circle(1, 0, 1)
    c2 = circle(0, 0, 3)
    assert_equal 3.14159265358979311600, c1.area_of_intersection_with_circle(c2)

    c1 = circle(1, 0, 1)
    c2 = circle(50, 50, 3)
    assert_equal 0.0, c1.area_of_intersection_with_circle(c2)
  end
end
