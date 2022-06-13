import 'dart:math';

class transporte {
  List<List<int>> matrix;
  List<int> demanda;
  List<int> oferta;
  //constructor
  transporte(this.matrix, this.demanda, this.oferta);
  //Metodo de la esquina noroeste
  int esquina_noroeste_modelo() {
    int costo_final = 0;
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
      costo_parcial += matriz[i][j];
    }
    //calculo del costo total
    costo_final = calcular_costo(matriz, this.matrix);
    print('Costo final del coso:{$costo_final}');
    return costo_final;
  }

  int calcular_costo(List<List<int>> matriz, List<List<int>> matrix) {
    int rdo = 0;
    for (var i = 0; i < matriz.length; i++) {
      for (var j = 0; j < matriz[0].length; j++) {
        rdo = rdo + matrix[i][j] + matriz[i][j];
      }
    }
    return rdo;
  }

  bool recorrer_matriz(
      List<List<int>> matriz, int rep, int tamanio, int valor_max) {
    int demanda = 0;
    for (int i = 0; i < tamanio; i++) {
      demanda += matriz[i][rep];
    }
    return demanda == valor_max;
  }

  bool recorrer_matriz2(
      List<List<int>> matriz, int rep, int tamanio, int valor_max) {
    int oferta = 0;
    for (int i = 0; i < tamanio; i++) {
      oferta += matriz[rep][i];
    }
    return oferta == valor_max;
  }

  void crear_matriz(List<List<int>> matriz) {
    for (var i = 0; i < this.matrix.length; i++) {
      List<int> list = [];

      for (var j = 0; j < this.matrix[0].length; j++) {
        list.add(0);
      }
      //list.add(this.oferta[i]);
      print(list);
      matriz.add(list);
    }
    //matriz.add(this.demanda);
  }

  // // int esquina_noroeste() {
  //   //List<List<int>> matriz = [];
  //   int costo_final = 0;
  //   //se define las variables incrementales afuera para ir desplazandose acorde a los costos
  //   int i = 0;
  //   int j = 0;
  //   List<int> list = [];
  //   int aux = 0;
  //   while (i < this.oferta.length) {
  //     int costo_parcial = 0;
  //     int suma_costos = 0;
  //     while (j < this.demanda.length) {
  //       int minimo = min(this.oferta[i] - costo_parcial, this.demanda[j] - aux);
  //       suma_costos += minimo;
  //       if (this.demanda[j] - minimo == 0) {
  //         costo_parcial += minimo;
  //         list.add(minimo);
  //         j++;
  //       }
  //       if (suma_costos == this.oferta[i]) {
  //         list.add(minimo);
  //         aux += minimo;
  //         i++;
  //         break;
  //       }
  //     }
  //   }
  //   return costo_final;
  // }
}
