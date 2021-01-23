import 'dart:math';

import 'package:space_3d/src/models/color.dart';

import 'package:space_3d/src/models/light.dart';

class LigthProsess {
  static Color processLight(int x, int y, int z, Color pixelColor, List<Light> luces) {
    for (var luz in luces) {
      if (luz is SpotLight) {
        if (luz.isFocus(x, y, z)) luz.illuminate(x, y, z, pixelColor);
      } else {
        luz.illuminate(x, y, z, pixelColor);
      }
    }
  }
}
