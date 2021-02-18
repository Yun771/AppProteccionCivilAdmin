import 'dart:async';
import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proteccion_civil_admin/src/models/reporte_model.dart';

class ReporteProvider {
  final _url = 'https://dbpcpr-default-rtdb.firebaseio.com';

  List<ReporteModel> _reportes = new List();

  final _reportesStreamController =
      StreamController<List<ReporteModel>>.broadcast();

  Function(List<ReporteModel>) get reportesSink =>
      _reportesStreamController.sink.add;

  Stream<List<ReporteModel>> get reportesStream =>
      _reportesStreamController.stream;

  void dispoStream() {
    _reportesStreamController?.close();
  }

  Future<bool> enviarReporte(ReporteModel reporte) async {
    final url = '$_url/Reportes.json';
    final resp = await http.post(url, body: reporteModelToJson(reporte));

    final decodata = json.decode(resp.body);

    return true;
  }

  Future<List<ReporteModel>> cargarReportes() async {
    final url = '$_url/Reportes.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedata = json.decode(resp.body);

    if (decodedata == null) return [];

    decodedata.forEach((id, reporte) {
      final reporteTemp = ReporteModel.fromJson(reporte);

      reporteTemp.id = id;

      _reportes.add(reporteTemp);
    });

    reportesSink(_reportes);

    return _reportes;
  }

  Future borrarReporte(String id) async {
    final url = '$_url/Reportes/$id.json';

    final resp = await http.delete(url);

    print(resp.body);
  }
}
