import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proteccion_civil_admin/src/models/card_model.dart';

class RecomendacionProvider {
  final _url = 'https://dbpcpr-default-rtdb.firebaseio.com';

  final List<CardModel> _recomendaciones = new List();

  final _recomendacionestreamController =
      StreamController<List<CardModel>>.broadcast();

  Function(List<CardModel>) get recomendacionesink =>
      _recomendacionestreamController.sink.add;

  Stream<List<CardModel>> get recomendacionesStream =>
      _recomendacionestreamController.stream;

  void dispoStream() {
    _recomendacionestreamController?.close();
  }

  Future<List<CardModel>> cargarRecomendaciones() async {
    final url = '$_url/Recomendaciones.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedata = json.decode(resp.body);

    if (decodedata == null) return [];

    decodedata.forEach((id, comunicado) {
      final comuTemp = CardModel.fromJson(comunicado);

      comuTemp.id = id;

      _recomendaciones.add(comuTemp);
    });

    recomendacionesink(_recomendaciones);

    return _recomendaciones;
  }

  Future<bool> crearRecomendacion(CardModel recomendacion) async {
    final url = '$_url/Recomendaciones.json';

    final resp = await http.post(url, body: cardModelToJson(recomendacion));

    final decodedata = json.decode(resp.body);

    return true;
  }

  Future<int> borrarRecomendacion(String id) async {
    final url = '$_url/Recomendaciones/$id.json';

    final resp = await http.delete(url);
    return 1;
  }
}
