import 'dart:math';

import 'Modelo.dart';

class transporte {
  late List<List<int>> costes_transporte;
  late List<int> demanda;
  late List<int> oferta;
  late List<List<int>> solucion_inicial;
  List<List<List<int>>> iteraciones_solucion_inicial = [];

  //constructor
  transporte(this.costes_transporte, this.demanda, this.oferta);

  transporte.from(Modelo modelo) {
    this.costes_transporte = modelo.costos;
    this.demanda = modelo.demanda;
    this.oferta = modelo.producciones;
  }

  //Metodo de la esquina noroeste
  void esquina_noroeste_modelo() {
    //crear matriz del modelo
    List<List<int>> matriz = [];
    crear_matriz(matriz);
    //Recorrer matriz
    //oferta-demanda total
    int oferta_total = 0;
    for (int k = 0; k < this.oferta.length; k++) {
      oferta_total += oferta[k];
    }
    //inicializar las variables
    int i = 0;
    int j = 0;
    int costo_demanda = 0;
    int costo_oferta = 0;
    int costo_parcial = 0;
    while (costo_parcial != oferta_total) {
      //satisface demanda?
      if (recorrer_matriz(matriz, j, matriz.length, this.demanda[j])) {
        costo_oferta += matriz[i][j];
        j++;
        costo_demanda = 0;
      }
      //satisface oferta?
      if (recorrer_matriz2(matriz, i, matriz[0].length, this.oferta[i])) {
        costo_demanda += matriz[i][j];
        i++;
        costo_oferta = 0;
      }
      matriz[i][j] =
          min(this.demanda[j] - costo_demanda, this.oferta[i] - costo_oferta);
      var copia = copiarMatriz(matriz);
      iteraciones_solucion_inicial.add(copia);
      costo_parcial += matriz[i][j];
    }
    //calculo del costo total
    solucion_inicial = copiarMatriz(matriz);
  }

  void mostrarIteraciones() {
    for (var i = 0; i < iteraciones_solucion_inicial.length; i++) {
      print("Iteración ${i + 1}:");
      _mostrarMatriz(iteraciones_solucion_inicial[i]);
    }
  }

  void mostrarSolucionInicial() {
    print("Solución Inicial:");
    _mostrarMatriz(solucion_inicial);
    int costo = calcular_costo(solucion_inicial, costes_transporte);
    print('\tCosto asociado a la solución: \$$costo');
  }

  List<List<int>> copiarMatriz(List<List<int>> matriz) {
    List<List<int>> resultado = [];
    for (var fila in matriz) {
      resultado.add(new List.from(fila));
    }
    return resultado;
  }

  int calcular_costo(
      List<List<int>> matriz, List<List<int>> costes_transporte) {
    int rdo = 0;
    for (var i = 0; i < matriz.length; i++) {
      for (var j = 0; j < matriz[0].length; j++) {
        rdo += costes_transporte[i][j] * matriz[i][j];
      }
    }
    return rdo;
  }

  bool recorrer_matriz(
      List<List<int>> matriz, int indexConstante, int tamanio, int valor_max) {
    int demanda = 0;
    for (int i = 0; i < tamanio; i++) {
      demanda += matriz[i][indexConstante];
    }
    return demanda == valor_max;
  }

  bool recorrer_matriz2(
      List<List<int>> matriz, int indexConstante, int tamanio, int valor_max) {
    int oferta = 0;
    for (int i = 0; i < tamanio; i++) {
      oferta += matriz[indexConstante][i];
    }
    return oferta == valor_max;
  }

  void crear_matriz(List<List<int>> matriz) {
    for (var i = 0; i < this.costes_transporte.length; i++) {
      List<int> list = [];

      for (var j = 0; j < this.costes_transporte[0].length; j++) {
        list.add(0);
      }
      //list.add(this.oferta[i]);
      // print(list);
      matriz.add(list);
    }
    //matriz.add(this.demanda);
  }

  void _mostrarMatriz(List<List<int>> m) {
    for (var fila in m) {
      print("\t$fila");
    }
  }
}
