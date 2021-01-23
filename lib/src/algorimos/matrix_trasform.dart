import 'dart:math';

import '../models/matrix.dart';

class MatrixTrasform {
  static Matrix traslate(double tx, double ty, double tz) {
    Matrix traslate = Matrix(columns: 4, rows: 4);
    traslate[0][0] = 1;
    traslate[0][1] = 0;
    traslate[0][2] = 0;
    traslate[0][3] = tx;

    traslate[1][0] = 0;
    traslate[1][1] = 1;
    traslate[1][2] = 0;
    traslate[1][3] = ty;

    traslate[2][0] = 0;
    traslate[2][1] = 0;
    traslate[2][2] = 1;
    traslate[2][3] = tz;

    traslate[3][0] = 0;
    traslate[3][1] = 0;
    traslate[3][2] = 0;
    traslate[3][3] = 1;
    return traslate;
  }

  static Matrix scale(double sx, double sy, double sz) {
    Matrix scaling = Matrix(columns: 4, rows: 4);
    scaling[0][0] = sx;
    scaling[0][1] = 0;
    scaling[0][2] = 0;
    scaling[0][3] = 0;

    scaling[1][0] = 0;
    scaling[1][1] = sy;
    scaling[1][2] = 0;
    scaling[1][3] = 0;

    scaling[2][0] = 0;
    scaling[2][1] = 0;
    scaling[2][2] = sz;
    scaling[2][3] = 0;

    scaling[3][0] = 0;
    scaling[3][1] = 0;
    scaling[3][2] = 0;
    scaling[3][3] = 1;
    return scaling;
  }

  static Matrix rotate(double ax, double ay, double az) {
    double dx = (ax * 2 * pi) / 360;
    double dy = (ay * 2 * pi) / 360;
    double dz = (az * 2 * pi) / 360;

    Matrix rx = Matrix(columns: 4, rows: 4);
    Matrix ry = Matrix(columns: 4, rows: 4);
    Matrix rz = Matrix(columns: 4, rows: 4);

    rx[0][0] = 1;
    rx[0][1] = 0;
    rx[0][2] = 0;
    rx[0][3] = 0;

    rx[1][0] = 0;
    rx[1][1] = cos(dx);
    rx[1][2] = -sin(dx);
    rx[1][3] = 0;

    rx[2][0] = 0;
    rx[2][1] = sin(dx);
    rx[2][2] = cos(dx);
    rx[2][3] = 0;

    rx[3][0] = 0;
    rx[3][1] = 0;
    rx[3][2] = 0;
    rx[3][3] = 1;

    ry[0][0] = cos(dy);
    ry[0][1] = 0;
    ry[0][2] = -sin(dy);
    ry[0][3] = 0;

    ry[1][0] = 0;
    ry[1][1] = 1;
    ry[1][2] = 0;
    ry[1][3] = 0;

    ry[2][0] = sin(dy);
    ry[2][1] = 0;
    ry[2][2] = cos(dy);
    ry[2][3] = 0;

    ry[3][0] = 0;
    ry[3][1] = 0;
    ry[3][2] = 0;
    ry[3][3] = 1;

    rz[0][0] = cos(dz);
    rz[0][1] = -sin(dz);
    rz[0][2] = 0;
    rz[0][3] = 0;

    rz[1][0] = sin(dz);
    rz[1][1] = cos(dz);
    rz[1][2] = 0;
    rz[1][3] = 0;

    rz[2][0] = 0;
    rz[2][1] = 0;
    rz[2][2] = 1;
    rz[2][3] = 0;

    rz[3][0] = 0;
    rz[3][1] = 0;
    rz[3][2] = 0;
    rz[3][3] = 1;
    return (rx * ry * rz);
  }

  static Matrix proyection(double focal) {
    Matrix proyection = Matrix(columns: 4, rows: 4);
    proyection[0][0] = focal;
    proyection[0][1] = 0;
    proyection[0][2] = 0;
    proyection[0][3] = 0;

    proyection[1][0] = 0;
    proyection[1][1] = focal;
    proyection[1][2] = 0;
    proyection[1][3] = 0;

    proyection[2][0] = 0;
    proyection[2][1] = 0;
    proyection[2][2] = focal;
    proyection[2][3] = 0;

    proyection[3][0] = 0;
    proyection[3][1] = 0;
    proyection[3][2] = 1;
    proyection[3][3] = 0;
    return proyection;
  }
}
