import 'dart:io';

import 'enums.dart';
import 'face.dart';
import 'object_3d.dart';
import 'raster.dart';
import 'vertice.dart';

class Space3D {
  List<Object3D> objetos3d = List();
  double focal = 3;
  void cargarObjetos(String path) {
    final file = File(path);
    String content = file.readAsStringSync();
    RegExp exp = new RegExp(r"\s\d*");
    List<String> fileContent = content.split('\n');
    Object3D obj;
    int verices = 1;
    for (String line in fileContent) {
      if (line.trim().startsWith('v')) {
        int id = verices;
        obj.vertices.add(Vertice.fromLine(line.trim(), id));
        verices += 1;
      } else if (line.trim().startsWith('f')) {
        List<int> vertices_id = exp.allMatches(line).map((e) => int.parse(e[0].substring(1))).toList();
        Face aux_face = Face();
        for (int id in vertices_id) {
          aux_face.addVertice(obj.getVerticeById(id));
        }
        obj.caras.add(aux_face);
      } else if (line.trim().startsWith('o')) {
        if (objetos3d.length > 0) obj.calculateMaxMinCenter();
        String name = line.split(' ')[1];
        objetos3d.add(Object3D(name));
        obj = objetos3d.last;
      }
    }
  }

  Object3D getObject3DByName(String name) => objetos3d.firstWhere((element) => element.name == name);

  void rotate(double ax, double ay, double az) {
    for (Object3D obj in objetos3d) {
      obj..rotate(ax, ay, az);
    }
  }

  void scale(double sx, double sy, double sz) {
    for (Object3D obj in objetos3d) {
      obj..rotate(sx, sy, sz);
    }
  }

  void traslate(double tx, double ty, double tz) {
    for (Object3D obj in objetos3d) {
      obj..rotate(tx, ty, tz);
    }
  }

  void scaleUnifrom(double scale) {
    for (Object3D obj in objetos3d) {
      obj.scaleUnifrom(scale);
    }
  }

  void draw(FHDRaster raster, ViewFace viewFace, DrawMode draw_mode) {
    _preparateProyection();
    for (Object3D obj in objetos3d) {
      obj.draw(raster, viewFace, draw_mode);
    }
  }

  void _preparateProyection() {
    double center_x;
    double center_y;

    double max_x;
    double max_y;

    double min_x;
    double min_y;
    double min_z;
    Object3D base = objetos3d.first;
    max_x = base.max_x;
    max_y = base.max_y;
    min_x = base.min_x;
    min_y = base.min_y;
    min_z = base.min_z;
    for (Object3D obj in objetos3d) {
      if (obj.max_x > max_x) max_x = obj.max_x;
      if (obj.max_y > max_y) max_y = obj.max_y;
      if (obj.min_x < min_x) min_x = obj.min_x;
      if (obj.min_y < min_y) min_y = obj.min_y;
      if (obj.min_z < min_z) min_z = obj.min_z;
    }
    center_x = (max_x + min_x) / 2;
    center_y = (max_y + min_y) / 2;
    traslate(-center_x, -center_y, -min_z + focal);
  }
}
