import 'dart:math';

import 'package:space_3d/space_3d.dart';
import 'package:space_3d/src/algorimos/visivility.dart';

import 'package:space_3d/src/models/color.dart';

import '../algorimos/matrix_trasform.dart';
import 'homogeneous_point.dart';
import 'face.dart';
import 'raster.dart';
import 'vertice.dart';
import 'matrix.dart';
import 'enums.dart';

class Object3D {
  String name;
  List<Vertice> vertices = List();
  List<Face> caras = List();
  List<double> zDepht = List();

  double center_x;
  double center_y;
  double center_z;

  double max_x;
  double max_y;
  double max_z;

  double min_x;
  double min_y;
  double min_z;
  Color color = Color(255, 255, 255);
  Object3D(this.name);

  void calculateMaxMinCenter() {
    Vertice ini = vertices[0];
    max_x = ini.x;
    max_y = ini.y;
    max_z = ini.z;
    min_x = ini.x;
    min_y = ini.y;
    min_z = ini.z;

    for (var vertice in vertices) {
      if (vertice.x > max_x) max_x = vertice.x;
      if (vertice.y > max_y) max_y = vertice.y;
      if (vertice.z > max_z) max_z = vertice.z;
      if (vertice.x < min_x) min_x = vertice.x;
      if (vertice.y < min_y) min_y = vertice.y;
      if (vertice.z < min_z) min_z = vertice.z;
    }
    center_x = (max_x + min_x) / 2;
    center_y = (max_y + min_y) / 2;
    center_z = (max_z + min_z) / 2;
  }

  void orientedFaces() {
    for (Face face in caras) {
      Point_Position pos = face.point_position(center_x, center_y, center_z);
      if (pos == Point_Position.fuera) face.vertices_reversed();
    }
  }

  void applyTransformMatrix(Matrix transform) {
    for (Vertice vertice in vertices) {
      HomogeneousPoint hpoint = HomogeneousPoint(vertice);
      hpoint.multiplyMatrix(transform);
      vertice.x = hpoint.vertice3D.x;
      vertice.y = hpoint.vertice3D.y;
      vertice.z = hpoint.vertice3D.z;
    }
    calculateMaxMinCenter();
  }

  void proyeccion(double focal) {
    zDepht = List();
    for (Vertice vertice in vertices) {
      zDepht.add(vertice.z);
    }
    applyTransformMatrix(MatrixTrasform.proyection(focal));
  }

  void rotate(double ax, double ay, double az) => applyTransformMatrix(MatrixTrasform.rotate(ax, ay, az));

  void scale(double sx, double sy, double sz) => applyTransformMatrix(MatrixTrasform.scale(sx, sy, sz));

  void traslate(double tx, double ty, double tz) => applyTransformMatrix(MatrixTrasform.traslate(tx, ty, tz));

  void scaleUnifrom(double scale) => applyTransformMatrix(MatrixTrasform.scale(scale, scale, scale));

  void centerToOrgin() => traslate(-center_x, -center_y, -center_z);

  void maxscale(int heigth, int width) {
    double dx = (this.max_x - this.min_x).abs();
    double dy = (this.max_y - this.min_y).abs();
    double dz = (this.max_z - this.min_z).abs();
    double factor_x = (width - 4) / dx;
    double factor_y = (heigth - 4) / dy;
    double factor_z = (heigth - 4) / dz;
    double min_a = min(factor_x, factor_y);
    double min_b = min(min_a, factor_z);
    scaleUnifrom(min_b);
  }

  Vertice getVerticeById(int id) => vertices.firstWhere((element) => element.id == id);

  void draw(FHDRaster raster, ViewFace viewFace, DrawMode draw_mode) {
    for (var i = 0; i < this.caras.length; i++) {
      Face face = this.caras[i];
      if (!Visibility.visibilityFaceTest(face)) continue;
      List<Point> borde;
      if (draw_mode == DrawMode.wire)
        borde = Scanline.faceBorderPoints(face, viewFace);
      else
        borde = Scanline.scanlineFacePoints(face, viewFace);
      for (Point pixel in borde) {
        double z = face.calculateZFromPoint(pixel.x, pixel.y);
        raster.setPixel(pixel.x, pixel.y, z, color);
        //raster.write('./image/top.ppm');
      }
    }
  }
}
