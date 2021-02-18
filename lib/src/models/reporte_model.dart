import 'dart:convert';

ReporteModel reporteModelFromJson(String str) =>
    ReporteModel.fromJson(json.decode(str));

String reporteModelToJson(ReporteModel data) => json.encode(data.toJson());

class ReporteModel {
  ReporteModel({
    this.id,
    this.direccion,
    this.nombreReportante,
    this.telefono,
    this.tipoReporte,
    this.fecha,
  });

  String id;
  String direccion;
  String nombreReportante;
  int telefono;
  String tipoReporte;
  String fecha;

  factory ReporteModel.fromJson(Map<String, dynamic> json) => ReporteModel(
        id: json["id"],
        direccion: json["Direccion"],
        nombreReportante: json["NombreReportante"],
        telefono: json["Telefono"],
        tipoReporte: json["tipoReporte"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "Direccion": direccion,
        "NombreReportante": nombreReportante,
        "Telefono": telefono,
        "tipoReporte": tipoReporte,
        "fecha": fecha,
      };
}
