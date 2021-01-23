import 'vertice.dart';
import 'matrix.dart';

class HomogeneousPoint extends Matrix {
  double get x => data[0][0];
  double get y => data[1][0];
  double get z => data[2][0];
  double get w => data[3][0];

  void set x(double x) => data[0][0] = x;
  void set y(double y) => data[1][0] = y;
  void set z(double z) => data[2][0] = z;
  void set w(double w) => data[3][0] = w;

  HomogeneousPoint(Vertice v) : super(columns: 1, rows: 4) {
    data[0][0] = v.x;
    data[1][0] = v.y;
    data[2][0] = v.z;
    data[3][0] = 1;
  }
  Vertice get vertice3D => Vertice.fromPoints(x / w, y / w, z / w);

  void multiplyMatrix(Matrix m) {
    Matrix result = m * this;
    x = result[0][0];
    y = result[1][0];
    z = result[2][0];
    w = result[3][0];
  }
}
