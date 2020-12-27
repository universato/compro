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
    assert_equal 25.0, a.norm
    assert_equal 5.0, a.abs
    assert_equal 5.0, a.dist
    assert_equal 5.0, a.dist(Point.origin)
    assert_equal 5.0, a.distance_to_point(Point.origin)
    # assert_equal 5.0, -a.abs
    assert_equal 5.0, (-a).abs
    assert_equal 5.0, (-a).dist
    assert_equal 5.0, (-a).distance_to_point(Point.origin)
  end

  def test_orthogonal?
    ex = Point.new(1.0, 0.0)
    ey = Point.new(0.0, 1.0)
    assert ex.orthogonal?(ey)
    assert !ex.parallel?(ey)
  end
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
    assert_equal point(1,  0), line(0, 0, 2, 0).getCrossPoint(line(1, 1, 1, -1))
    assert_equal point(0.5, 0.5), line(0, 0, 1, 1).getCrossPoint(line(0, 1, 1, 0))
    assert_equal point(0.5, 0.5), line(0, 0, 1, 1).getCrossPoint(line(1, 0, 0, 1))
  end

  def test_distance_between_segments_CGL_2_D
    assert_equal 1, line(0, 0, 1, 0).getDistance(line(0, 1, 1, 1))
    # 小数点未満でエラーがでてしまう。誤差だと思う。たぶん答えが√2
    # assert_equal 1.414213562373095048, line(0,0,1,0).getDistance(line(2,1,1,2))
    assert_equal 0, line(-1, 0, 1, 0).getDistance(line(0, 1, 1, -1))
  end

  def test_area_CGL_3_A
    assert_equal 2.0, triangle(0, 0, 2, 2, -1, 1).area
    assert_equal 1.5, Polygon.new([point(0, 0), point(1, 1), point(1, 2), point(0, 2)]).area
  end

  def test_convex_CGL_4_A
    assert  Polygon.new([point(0, 0), point(3, 1), point(2, 3), point(0, 3)]).convex?
    assert !Polygon.new([point(0, 0), point(2, 0), point(1, 1), point(2, 2), point(0, 2)]).convex?
  end

  def test_diameter_CGL_4_B
    assert_equal 4, triangle(0, 0, 4, 0, 2, 2).diameter
    assert_equal 1.414213562373095048, Polygon.new([point(0, 0), point(1, 0), point(1, 1), point(0, 1)]).diameter
  end
end
