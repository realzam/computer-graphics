class Matrix {
  List<List<double>> data = new List<List<double>>();
  int columns;
  int rows;

  Matrix({this.columns, this.rows}) {
    for (int x = 0; x < rows; x++) {
      List<double> row = List.filled(columns, 0.0);
      data.add(row);
    }
  }

  List<double> getcolumn(int n) {
    List<double> colum = List();
    for (var i = 0; i <= rows - 1; i++) {
      colum.add(data[i][n]);
    }
    return colum;
  }

  Matrix operator -() {
    for (int x = 0; x < rows; x++) {
      List<double> row = data[x];
      for (var y = 0; y < columns; y++) {
        row[y] = -row[y];
      }
    }
    return this;
  }

  Matrix operator *(Matrix other) {
    if (this.columns == other.rows) {
      Matrix res = Matrix(rows: this.rows, columns: other.columns);
      for (var i = 0; i <= this.rows - 1; i++) {
        List<double> a_row = this.data[i];
        for (var j = 0; j <= other.columns - 1; j++) {
          List<double> b_column = other.getcolumn(j);
          double c = 0;
          for (var k = 0; k < a_row.length; k++) {
            c = c + a_row[k] * b_column[k];
          }
          res.data[i][j] = c;
        }
      }
      return res;
    }
    throw Exception('El número de columnas de la primera matriz debe coincidir con el número de filas de la segunda matriz.');
  }

  List<double> operator [](int a) {
    return data[a];
  }

  @override
  String toString() {
    List<int> columnLengthCharacters = List(columns);
    for (var i = 0; i < columns; i++) {
      List<double> column = getcolumn(i);
      int max = 0;
      for (var j = 0; j < rows; j++) {
        if (max < column[j].toString().length) max = column[j].toString().length;
      }
      columnLengthCharacters[i] = max;
    }
    String res = '';
    for (var i = 0; i < this.rows; i++) {
      res += '|';
      List<double> column_i = data[i];
      for (var j = 0; j < columns; j++) {
        double dato = column_i[j];

        res += ' $dato' + ' ' * (columnLengthCharacters[j] - dato.toString().length);
      }
      if (i == this.rows - 1)
        res += ' |';
      else
        res += ' |\n';
    }
    return res;
  }
}
