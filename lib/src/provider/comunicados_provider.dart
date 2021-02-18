import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proteccion_civil_admin/src/models/card_model.dart';

class ComunicadosProvider {
  final _url = 'https://dbpcpr-default-rtdb.firebaseio.com';

  final List<CardModel> _comunicados = new List();

  final _comunicadoStreamController =
      StreamController<List<CardModel>>.broadcast();

  Function(List<CardModel>) get comunicadoSink =>
      _comunicadoStreamController.sink.add;

  Stream<List<CardModel>> get comunicadosStream =>
      _comunicadoStreamController.stream;

  void dispoStream() {
    _comunicadoStreamController?.close();
  }

  Future<List<CardModel>> cargarComunicados() async {
    final url = '$_url/Comunicados.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedata = json.decode(resp.body);

    // print(decodedata);

    if (decodedata == null) return [];

    decodedata.forEach((id, comunicado) {
      final comuTemp = CardModel.fromJson(comunicado);

      comuTemp.id = id;

      _comunicados.add(comuTemp);
    });

    comunicadoSink(_comunicados);

    return _comunicados;
  }

  Future<bool> crearComunicado(CardModel comunicado) async {
    final url = '$_url/Comunicados.json';

    final resp = await http.post(url, body: cardModelToJson(comunicado));

    final decodedata = json.decode(resp.body);

    return true;
  }

  Future<int> borrarComunidado(String id) async {
    final url = '$_url/Comunicados/$id.json';

    final resp = await http.delete(url);
    return 1;
  }
}
