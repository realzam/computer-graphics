import 'dart:math';

import 'vertice.dart';
import 'matrix.dart';

class Vector extends Matrix {
  double get x => data[0][0];
  double get y => data[1][0];
  double get z => data[2][0];

  void set x(double x) => data[0][0] = x;
  void set y(double y) => data[1][0] = y;
  void set z(double z) => data[2][0] = z;

  Vector.fromVertice(Vertice v1) : super(columns: 1, rows: 3) {
    this.x = v1.x;
    this.y = v1.y;
    this.z = v1.z;
  }
  Vector.fromPoint(double x, double y, double z) : super(columns: 1, rows: 3) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  Vector.from2Vertice(Vertice p1, Vertice p2) : super(columns: 1, rows: 3) {
    this.x = p1.x - p2.x;
    this.y = p1.y - p2.y;
    this.z = p1.z - p2.z;
  }
  Vector operator -(Vector other) {
    double x, y, z;
    x = this.x - other.x;
    y = this.y - other.y;
    z = this.z - other.z;
    return Vector.fromPoint(x, y, z);
  }

  Vector cross(Vector b) {
    double x;
    double y;
    double z;
    x = (this.y * b.z) - (this.z * b.y);
    y = (this.z * b.x) - (this.x * b.z);
    z = (this.x * b.y) - (this.y * b.x);
    if (x.isNegative && x == -0.0) x = -x;
    if (y.isNegative && y == -0.0) y = -y;
    if (z.isNegative && z == -0.0) z = -z;
    return Vector.fromPoint(x, y, z);
  }

  double dot(Vector b) {
    return x * b.x + y * b.y + z * b.z;
  }

  double get magnitud {
    return sqrt((x * x + y * y + z * z));
  }

  Vector normalized() {
    this / magnitud;
    return this;
  }

  void operator /(double div) {
    x = x / div;
    y = y / div;
    z = z / div;
  }

  double angle(Vector other) {
    final cos = (this.dot(other)) / (this.magnitud * other.magnitud);
    final angulo_rad = acos(cos);
    return (angulo_rad * 360) / (2 * pi);
  }
}
