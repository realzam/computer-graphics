import 'dart:math';

import 'package:space_3d/src/models/vector.dart';
import 'package:space_3d/src/models/vertice.dart';

import 'color.dart';

class Light {
  Color _color;
  double _x;
  double _y;
  double _z;
  Light(this._color, this._x, this._y, this._z);
  Color get color => this._color;
  double get x => this._x;
  double get y => this._y;
  double get z => this._z;

  double attenuation(int x, int y, int z) {
    return 1.0;
    double distance = sqrt(pow(x - _x, 2) + pow(y - _y, 2) + pow(z - _z, 2));
    double a = 0.0 * pow(distance, 2);
    double b = 0.1 * distance;
    double c = 1.0;
    double att = 1 / (a + b + c);
    return att;
  }

  void illuminate(int x, int y, int z, Color pixelColor) {
    Color add = _color * attenuation(x, y, z);
    pixelColor.r = (pixelColor.r + add.r).clamp(0, 255);
    pixelColor.g = (pixelColor.g + add.g).clamp(0, 255);
    pixelColor.b = (pixelColor.b + add.b).clamp(0, 255);
  }
}

class AmbientLight extends Light {
  AmbientLight(Color color, double x, double y, double z) : super(color, x, y, z);

  @override
  void illuminate(int x, int y, int z, Color pixelColor) {
    pixelColor.r = (pixelColor.r + color.r).clamp(0, 255);
    pixelColor.g = (pixelColor.g + color.g).clamp(0, 255);
    pixelColor.b = (pixelColor.b + color.b).clamp(0, 255);
  }
}

class SpotLight extends Light {
  Vector _direccion;
  double _anguloAperturaGrados;
  double _cosMyAngle;
  SpotLight(Color color, double x, double y, double z, this._direccion, this._anguloAperturaGrados) : super(color, x, y, z) {
    _cosMyAngle = cos((pi / 180) * (_anguloAperturaGrados / 2));
  }

  Vector get direccion => this._direccion;
  double get angulo => this._anguloAperturaGrados;

  bool isFocus(int x, int y, int z) {
    Vector p = Vector.from2Vertice(Vertice.fromPoints(x.toDouble(), y.toDouble(), z.toDouble()), Vertice.fromPoints(_x, _y, _z));
    double cosTheta = _direccion.normalized().dot(p.normalized());
    if (cosTheta >= _cosMyAngle) return true;
    return false;
  }
}
