import 'dart:io';

import 'Modelo.dart';
import 'Transporte.dart';

void main(List<String> args) async {
  String json = await getStringFromJsonFile("ejemplos.json");
  Ejemplos ejemplos = ejemplosFromJson(json);
  List<Modelo> modelos_ejemplo = ejemplos.modelos;

  var solucionador = transporte(modelos_ejemplo[0].costos,
      modelos_ejemplo[0].demanda, modelos_ejemplo[0].producciones);
  solucionador.esquina_noroeste_modelo();
}

Future<String> getStringFromJsonFile(String path) async {
  var archivo_ejemplo = File(path);
  return archivo_ejemplo.readAsString();
}

void ingresoModelo() {
  print("Ingrese cantidad de origenes:");
  int? n = int.parse(stdin.readLineSync()!);

  print("Ingreso de producciones de los origenes:");
  //Restricciones
  List<int> of = [];
  for (var i = 0; i < n; i++) {
    print("Ingrese la producción del origen ${i + 1}");
    int? valor = int.parse(stdin.readLineSync()!);
    of.add(valor);
  }

  print("Ingrese cantidad de destinos:");
  int? m = int.parse(stdin.readLineSync()!);

  print("Ingreso de demanda de los destinos:");
  List<int> dd = [];
  for (var i = 0; i < m; i++) {
    print("Ingrese la demanda del destino ${i + 1}");
    int? valor = int.parse(stdin.readLineSync()!);
    dd.add(valor);
  }

  print("Ingreso de los costes asociados al tranporte\n" +
      "desde cada origen a cada destino:");

  //Funcion objeto
  List<List<int>> matrix = [];
  for (var i = 0; i < n; i++) {
    List<int> list = [];

    for (var j = 0; j < m; j++) {
      print("Ingrese el costo para transportar desde\n" +
          "el origen ${i + 1} al destino ${j + 1}");
      int? coef = int.parse(stdin.readLineSync()!);
      list.add(coef);
    }
    matrix.add(list);
  }

  var modelo = new transporte(matrix, dd, of);
  modelo.esquina_noroeste_modelo();
}
