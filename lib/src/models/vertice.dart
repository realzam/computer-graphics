class Vertice {
  int id;
  double _x;
  double _y;
  double _z;
  double get x => this._x;
  double get y => this._y;
  double get z => this._z;

  void set x(double x) => this._x = x;
  void set y(double y) => this._y = y;
  void set z(double z) => this._z = z;

  Vertice.fromLine(String line, int id) {
    this.id = id;
    List<String> aux = line.split(' ');
    this._x = double.parse(aux[1]);
    this._y = -double.parse(aux[3]);
    this._z = double.parse(aux[2]);
    if (this._x == -0.0) this._x = 0.0;
    if (this._y == -0.0) this._y = 0.0;
    if (this._z == -0.0) this._z = 0.0;
  }

  Vertice.fromPoints(this._x, this._y, this._z, [this.id]);

  @override
  String toString() {
    return '$_x, $_y, $_z';
  }
}
