import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:meta/meta.dart';
import 'package:space_3d/src/algorimos/ligth_prosess.dart';
import 'package:space_3d/src/models/light.dart';
import '../algorimos/bresenham.dart';
import 'color.dart';

class Pixel {
  double zBuffer = -double.maxFinite;
  Color color = Color(0, 0, 0);
}

class FHDRaster {
  final int width;
  final int heigth;
  int origin_x;
  int origin_y;
  List<Pixel> pixeles;

  FHDRaster({@required this.heigth, @required this.width, this.origin_x, this.origin_y}) {
    if (this.origin_x == null) this.origin_x = (this.width / 2).toInt();
    if (this.origin_y == null) this.origin_y = (this.heigth / 2).toInt();

    pixeles = List(this.heigth * this.width);
    for (var i = 0; i < this.heigth * this.width; i++) {
      Pixel add = Pixel();
      pixeles[i] = add;
    }
  }

  void clearPixels() {
    pixeles = List(this.heigth * this.width);
    for (var i = 0; i < this.heigth * this.width; i++) {
      Pixel add = Pixel();
      pixeles[i] = add;
    }
  }

  void setOrigin(int x, int y) {
    this.origin_x = x;
    this.origin_y = y;
  }

  bool validPixel(int x, int y) {
    int posx = this.origin_x + x;
    int posy = this.origin_y - y;
    if (posx >= width || posy >= heigth) return false;

    if (posx < 0 || posy < 0) return false;

    return true;
  }

  void setPixel(int x, int y, double z, Color color) {
    if (!validPixel(x, y)) return;
    int pos_x = this.origin_x + x;
    int pos_y = this.origin_y - y;

    /*
    int pos_z = pos_y * this.width + pos_x;
    double current_z = zBuffer[pos_z];
    //print('$current_z | $z ');
    if (z >= current_z) return;
    zBuffer[pos_z] = z;
    int byte_pos = pos_y * this.width * 3 + pos_x * 3;
    data_bytes[byte_pos] = r;
    data_bytes[byte_pos + 1] = g;
    data_bytes[byte_pos + 2] = b;*/
    int pixel_num = pos_y * this.width + pos_x;
    Pixel pixel = pixeles[pixel_num];
    double current_z = pixel.zBuffer;
    if (z <= current_z) return;
    pixel.zBuffer = z;
    pixel.color.r = color.r;
    pixel.color.g = color.g;
    pixel.color.b = color.b;
  }

  void write(String path, {List<Light> luces}) {
    Uint8List data_bytes = Uint8List(this.heigth * this.width * 3);
    for (var y = 0; y < this.heigth; y++) {
      for (var x = 0; x < this.width; x++) {
        int i = y * this.width + x;
        Pixel pixel = pixeles[i];
        /*Color old = Color(pixel.color.r, pixel.color.g, pixel.color.b);
        if (luces != null && luces.length > 0) LigthProsess.processLight(x, y, pixel.zBuffer.toInt(), pixel.color, luces);
        //if (pixel.color == old) pixel.color = Color(0, 0, 0);*/
        data_bytes[i * 3] = pixel.color.r;
        data_bytes[i * 3 + 1] = pixel.color.g;
        data_bytes[i * 3 + 2] = pixel.color.b;
      }
    }

    final header = 'P6\n${width} ${heigth} 255\n';
    final listH = header.codeUnits;
    File(path).writeAsBytesSync(listH + data_bytes);
  }
}
