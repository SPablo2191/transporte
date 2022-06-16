// To parse this JSON data, do
//
//     final ejemplos = ejemplosFromJson(jsonString);

import 'dart:convert';

Ejemplos ejemplosFromJson(String str) => Ejemplos.fromJson(json.decode(str));

String ejemplosToJson(Ejemplos data) => json.encode(data.toJson());

class Ejemplos {
  Ejemplos({
    required this.modelos,
  });

  List<Modelo> modelos;

  factory Ejemplos.fromJson(Map<String, dynamic> json) => Ejemplos(
        modelos:
            List<Modelo>.from(json["modelos"].map((x) => Modelo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "modelos": List<dynamic>.from(modelos.map((x) => x.toJson())),
      };
}

class Modelo {
  Modelo({
    required this.producciones,
    required this.demanda,
    required this.costos,
  });

  List<int> producciones;
  List<int> demanda;
  List<List<int>> costos;

  factory Modelo.fromJson(Map<String, dynamic> json) => Modelo(
        producciones: List<int>.from(json["producciones"].map((x) => x)),
        demanda: List<int>.from(json["demanda"].map((x) => x)),
        costos: List<List<int>>.from(
            json["costos"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "producciones": List<dynamic>.from(producciones.map((x) => x)),
        "demanda": List<dynamic>.from(demanda.map((x) => x)),
        "costos": List<dynamic>.from(
            costos.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
