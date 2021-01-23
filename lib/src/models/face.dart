import 'enums.dart';
import 'vector.dart';
import 'vertice.dart';

class Face {
  List<Vertice> vertices = List();

  void addVertice(Vertice v) => vertices.add(v);

  void vertices_reversed() => vertices = vertices.reversed.toList();

  double calculateZFromPoint(int x, int y) {
    Vector normal = calculateSurfaceNormal().normalized();
    Vertice p = vertices[0];
    double d = (normal.x * p.x + normal.y * p.y + normal.z * p.z);
    if (normal.z == 0) return 0;
    return (d - normal.x * x - normal.y * y) / normal.z;
  }

  Point_Position point_position(double x, double y, double z) {
    Vector normal = calculateSurfaceNormal();
    Vertice p = vertices[0];
    double d = -(normal.x * p.x + normal.y * p.y + normal.z * p.z);
    double res = normal.x * x + normal.y * y + normal.z * z + d;
    if (res < 0) return Point_Position.dentro;
    return Point_Position.fuera;
  }

  Vector calculateSurfaceNormal() {
    Vertice normal = Vertice.fromPoints(0, 0, 0);
    for (var i = 0; i < vertices.length; i++) {
      Vertice current = vertices[i];
      Vertice next = vertices[(i + 1) % vertices.length];
      normal.x = normal.x + ((current.y - next.y) * (current.z + next.z));
      normal.y = normal.y + ((current.z - next.z) * (current.x + next.x));
      normal.z = normal.z + ((current.x - next.x) * (current.y + next.y));
    }
    return Vector.fromVertice(normal);
  }

  @override
  String toString() {
    String res = "f";
    for (var vertice in vertices) {
      res += ' ${vertice.id}';
    }
    return res;
  }
}
