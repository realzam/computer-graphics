import 'dart:math';
import '../models/enums.dart';
import 'package:space_3d/space_3d.dart';
import 'bresenham.dart';
import '../list_api.dart';

class Scanline {
  static List<Point> faceBorderPoints(Face face, ViewFace viewFace) {
    List<Point> borderFace = List();

    for (var i = 0; i < face.vertices.length; i++) {
      Vertice a = face.vertices[i];
      Vertice b = face.vertices[(i + 1) % face.vertices.length];
      List<Point> arista;
      switch (viewFace) {
        case ViewFace.xy:
          arista = Bresenham.linePoints(
              a.x.toInt(), a.y.toInt(), b.x.toInt(), b.y.toInt());
          break;
        case ViewFace.xz:
          arista = Bresenham.linePoints(
              a.x.toInt(), a.z.toInt(), b.x.toInt(), b.z.toInt());
          break;
        case ViewFace.yz:
          arista = Bresenham.linePoints(
              a.y.toInt(), a.z.toInt(), b.y.toInt(), b.z.toInt());
          break;
      }
      borderFace.combineUnique(arista);
    }
    borderFace.sort((a, b) {
      int y = a.y.compareTo(b.y);
      if (y == 0)
        return a.x.compareTo(b.x);
      else
        return y;
    });
    return borderFace;
  }

  static List<Point> scanlineFacePoints(Face face, ViewFace viewFace) {
    List<Point> containPointsFace = List();
    List<Point> borderFace = faceBorderPoints(face, viewFace);

    int vertical = borderFace[0].y;
    int min_h = borderFace[0].x;
    int max_h = borderFace[0].x;
    for (var i = 1; i < borderFace.length; i++) {
      Point punto = borderFace[i];
      if (i == borderFace.length - 1)
        for (var i = min_h; i <= punto.x; i++)
          containPointsFace.add(Point(i, vertical));
      if (vertical != punto.y) {
        for (var i = min_h; i <= max_h; i++)
          containPointsFace.add(Point(i, vertical));
        vertical = punto.y;
        max_h = punto.x;
        min_h = punto.x;
      } else
        max_h = punto.x;
    }
    return containPointsFace;
  }
}
