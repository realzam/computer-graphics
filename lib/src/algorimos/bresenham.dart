import 'dart:math';

class Bresenham {
  static List<Point> linePoints(int x1, int y1, int x2, int y2) {
    List<Point> puntos = List();
    if (x1 == x2 && y1 == y2) {
      puntos.add(Point(x1, y1));
      return puntos;
    }
    int x, y;
    int dx = (x1 - x2).abs();
    int dy = (y1 - y2).abs();
    if ((dy > dx && y2 < y1) || (dx > dy && x2 < x1)) {
      int auxX = x1;
      int auxY = y1;
      x1 = x2;
      x2 = auxX;
      y1 = y2;
      y2 = auxY;
    }
    puntos.add(Point(x1, y1));
    puntos.add(Point(x2, y2));

    bool sentidoPostitivo;
    int updateUp, updateRight, p;
    if (dy > dx) {
      updateUp = 2 * dx - 2 * dy;
      updateRight = 2 * dx;
      p = 2 * dx - dy;
      x = x1;
      if (x1 < x2)
        sentidoPostitivo = true;
      else
        sentidoPostitivo = false;
      for (y = y1 + 1; y < y2; y++) {
        if (p < 0) {
          p += updateRight;
        } else {
          if (sentidoPostitivo)
            x++;
          else
            x--;
          p += updateUp;
        }
        puntos.add(Point(x, y));
      }
    } else {
      updateUp = 2 * dy - 2 * dx;
      updateRight = 2 * dy;
      p = 2 * dy - dx;
      y = y1;
      if (y1 < y2)
        sentidoPostitivo = true;
      else
        sentidoPostitivo = false;
      for (x = x1 + 1; x < x2; x++) {
        if (p < 0) {
          p += updateRight;
        } else {
          if (sentidoPostitivo)
            y++;
          else
            y--;
          p += updateUp;
        }
        puntos.add(Point(x, y));
      }
    }
    return puntos;
  }
}
