import 'dart:io';

import '../models/object_3d.dart';
import '../models/enums.dart';
import '../models/raster.dart';
import 'matrix_trasform.dart';

class Animation {
  static void generate(Object3D obj, {int fps = 24, double angleStart = 0, double angleFinish, double anglePerSecond, bool clearImages = true, DrawMode draw_mode}) async {
    /*double z = angleStart;
    int i = 0;
    FHDRaster raster =
        FHDRaster(heigth: 1080, width: 1920, origin_x: 960, origin_y: 540);
    Object3D animated = obj.clone();
    animated.rotate(0, 0, 0);
    raster.write('./image/animation/a_$i.ppm');
    stdout.write(
        "fotograma generado $i /${((angleFinish - angleStart) / anglePerSecond) * fps} \r");
    i++;
    while (z < angleFinish) {
      double step = anglePerSecond / fps;
      animated.rotate(1, step, 0);
      animated.drawFaces(raster, ViewFace.xy, draw_mode, 255, 255, 255);
      raster.write('./image/animation/a_$i.ppm');
      stdout.write(
          "fotograma generado $i /${((angleFinish - angleStart) / anglePerSecond) * fps} \r");
      z += step;
      i++;
      raster.clearPixels();
    }
    print('\nGenerando video');
    await Process.run(
        "ffmpeg",
        [
          "-framerate",
          "$fps",
          "-i",
          "./image/animation/a_%d.ppm",
          "./image/animation/animation.avi",
          "-y"
        ],
        runInShell: true);
    if (clearImages) {
      for (var n = 0; n <= i; n++) {
        Process.runSync("rm", ["-f", "./image/animation/a_$n.ppm"]);
      }
    }*/
  }
}
