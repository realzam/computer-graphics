class Color {
  int r;
  int g;
  int b;

  Color(this.r, this.g, this.b);

  Color operator *(double mul) {
    int nr = (this.r * mul).toInt();
    int ng = (this.g * mul).toInt();
    int nb = (this.b * mul).toInt();

    return Color(nr, ng, nb);
  }

  @override
  String toString() {
    return "$r, $g, $b";
  }

  bool operator ==(other) => other is Color && r == other.r && g == other.g && b == other.b;
}
