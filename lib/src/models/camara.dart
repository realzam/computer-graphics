import 'package:space_3d/space_3d.dart';

class Camara {
  double _x;
  double _y;
  double _z;

  Vector _direccion;

  double get x => this._x;
  double get y => this._y;
  double get z => this._z;

  void set x(double x) => this._x = x;
  void set y(double y) => this._y = y;
  void set z(double z) => this._z = z;

  Camara(this._x, this._y, this._z, this._direccion);
}
