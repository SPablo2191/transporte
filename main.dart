import 'dart:io';

void main(List<String> args) {
  print("ingrese cantidad de origenes");
  int? n = int.parse(stdin.readLineSync()!);
  print("ingrese cantidad de destinos");
  int? m = int.parse(stdin.readLineSync()!);

  //Funcion objeto
  List<List<int>> matrix = [];
  for (var i = 0; i < n; i++) {
    List<int> list = [];

    for (var j = 0; j < m; j++) {
      print("ingrese coeficiente:");
      int? coef = int.parse(stdin.readLineSync()!);
      list.add(coef);
    }
    print(list);
    matrix.add(list);
  }
  print(matrix);
  //Restricciones
  List<int> rhs = [];
  for (var i = 0; i < n; i++) {
    print("ingrese restricciones del lado derecho para originarios:");
    int? valor = int.parse(stdin.readLineSync()!);
    rhs.add(valor);
  }
  for (var i = 0; i < m; i++) {
    print("ingrese restricciones del lado derecho para destinarios:");
    int? valor = int.parse(stdin.readLineSync()!);
    rhs.add(valor);
  }
}
