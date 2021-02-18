import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Información',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          SizedBox(
            height: 20.0,
          ),
          _aboutApp(),
          SizedBox(
            height: 40.0,
          ),
          _aboutDesarroladores()
        ],
      ),
    );
  }
}

Widget _aboutApp() {
  return Text(
    '''Esta aplicación móvil fue desarrollada con el objetivo de implementar los envíos de reportes por medio de dicha App, sobre eventos los cuales requieren la atención del departamento de Protección Civil, y así poder ayudar al departamento a tener otra vía de recepción de dichos reportes.''',
    textAlign: TextAlign.center,
  );
}

Widget _aboutDesarroladores() {
  return Text(
    'Esta Aplicación fue desarrollada por alumnos de la Universidad Veracruzana como trabajo recepcional de la Carrera de Ingeniería en Tecnologías Computacionales ',
    textAlign: TextAlign.center,
  );
}
