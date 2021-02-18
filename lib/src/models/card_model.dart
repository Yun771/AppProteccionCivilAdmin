import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    this.id,
    this.descripcion,
    this.fecha,
    this.titulo,
    this.tipoCard,
  });

  String id;
  String descripcion;
  String fecha;
  String titulo;
  String tipoCard;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json["id"],
        descripcion: json["descripcion"],
        fecha: json["fecha"],
        titulo: json["titulo"],
        tipoCard: json["tipoCard"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "fecha": fecha,
        "titulo": titulo,
        "tipoCard": tipoCard,
      };
}
