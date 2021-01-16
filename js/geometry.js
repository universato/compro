PI        = Math.PI
HALF_PI   = Math.PI / 2
QUATER_PI = Math.PI / 4
TAU       = Math.PI * 2
TWO_PI    = Math.PI * 2

EPS = 1e-10

class Point {
  constructor(x = 0, y = 0) {
      this.x = x;
      this.y = y;
  }
  add(other) {
    return new Point(this.x + other.x, this.y + other.y);
  }
  sub(other) {
    return new Point(this.x - other.x, this.y - other.y);
  }
  clone() {
    return new Point(this.x, this.y);
  }

  // factor
  times(k) {
    return new Point(this.x * k, this.y * k);
  }
  div(k) {
    return new Point(this.x / k, this.y / k);
  }
  dot(other) {
    return this.x * other.x +  this.y * other.y;
  }
  cross(other) {
    return this.x * other.y -  this.y * other.x;
  }
  get abs2() {
    return this.x * this.x +  this.y * this.y;
  }
  get abs() {
    return Math.sqrt(this.x * this.x +  this.y * this.y);
  }

  isOrthogonal(other) {
    return Math.abs(this.dot(other)) < EPS;
  }

  isParallel(other) {
    return Math.abs(this.cross(other)) < EPS;
  }
}

class Line {
  constructor(s = new Point(), t = new Point()) {
      this.s = s;
      this.t = t;
  }
}

module.exports = {
  Point,
  Line,
}
