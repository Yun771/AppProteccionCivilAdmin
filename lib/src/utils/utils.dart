import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:proteccion_civil_admin/src/provider/comunicados_provider.dart';
import 'package:proteccion_civil_admin/src/provider/recomendaciones_provider.dart';

import 'package:proteccion_civil_admin/src/provider/reportes_provider.dart';

String getDate() {
  var now = new DateTime.now();

  var formatter = new DateFormat.yMd().add_jm();
  String formattedDate = formatter.format(now);

  return formattedDate;
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition();
}

void mostrarAlert(BuildContext context, String msj, String id, int opc) {
  final _reporteProvider = ReporteProvider();
  final _comunicadoProvider = ComunicadosProvider();
  final _recomendacioProvider = RecomendacionProvider();

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('¡Mensaje!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(msj),
              Icon(Icons.warning, color: Color(0xFFFB6409), size: 40.0),
            ],
          ),
          actionsOverflowButtonSpacing: 20,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar')),
            FlatButton(
                onPressed: () {
                  switch (opc) {
                    case 1:
                      _reporteProvider.borrarReporte(id);
                      break;
                    case 2:
                      _comunicadoProvider.borrarComunidado(id);
                      break;
                    case 3:
                      _recomendacioProvider.borrarRecomendacion(id);
                  }
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: Text('Ok'))
          ],
        );
      });
}
