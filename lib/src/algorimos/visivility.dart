import '../models/face.dart';
import '../models/vector.dart';

class Visibility {
  static bool visibilityFaceTest(Face face) {
    Vector normal = face.calculateSurfaceNormal().normalized();
    if (normal.z <= 0) {
      return true;
    }
    return false;
  }
}
