import 'dart:math';

class Vector2 {
  double x;
  double y;

  Vector2(this.x, this.y);

  Vector2.zero()
      : x = 0,
        y = 0;

  // Vector addition
  Vector2 operator +(Vector2 other) => Vector2(x + other.x, y + other.y);

  // Vector subtraction
  Vector2 operator -(Vector2 other) => Vector2(x - other.x, y - other.y);

  // Scalar multiplication
  Vector2 operator *(double scalar) => Vector2(x * scalar, y * scalar);

  // Scalar division
  Vector2 operator /(double scalar) => Vector2(x / scalar, y / scalar);

  // Vector magnitude (length)
  double get length => sqrt(x * x + y * y);

  // Normalize (unit vector)
  Vector2 normalized() {
    final len = length;
    return len == 0 ? Vector2.zero() : this / len;
  }

  Vector2 translate(double newX, double newY) {
    return Vector2(x + newX, y + newY);
  }

  // Dot product
  double dot(Vector2 other) => x * other.x + y * other.y;

  // Angle in radians
  double get angle => atan2(y, x);

  @override
  String toString() => 'Vector2($x, $y)';
}
