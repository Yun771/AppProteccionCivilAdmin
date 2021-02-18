import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

import 'package:proteccion_civil_admin/src/models/reporte_model.dart';
import 'package:proteccion_civil_admin/src/provider/reportes_provider.dart';
import 'package:proteccion_civil_admin/src/utils/utils.dart';

class ReporteDetallePage extends StatefulWidget {
  ReporteDetallePage({Key key}) : super(key: key);

  @override
  _ReporteDetallePageState createState() => _ReporteDetallePageState();
}

class _ReporteDetallePageState extends State<ReporteDetallePage> {
  final _reporteProvider = ReporteProvider();
  @override
  Widget build(BuildContext context) {
    ReporteModel _reporte = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reporte'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                onPressed: () {
                  mostrarAlert(
                      context, '¿Desea Eliminar este Reporte?', _reporte.id, 1);
                })
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: _datos(_reporte),
        )));
  }

  Widget _datos(ReporteModel reporte) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(
        reporte.tipoReporte,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 5.0),
      Text(
        reporte.fecha,
        textAlign: TextAlign.center,
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 10.0),
      ),
      Divider(),
      SizedBox(height: 15.0),
      Text(
        'Nombre del Reportante: ${reporte.nombreReportante}',
        style: TextStyle(),
      ),
      SizedBox(height: 15.0),
      Text('Teléfono: ${reporte.telefono}'),
      SizedBox(height: 10.0),
      Text('Lat-Lng: ${reporte.direccion}'),
      SizedBox(height: 10.0),
      _direccion(reporte.direccion)
    ]);
  }

  Widget _direccion(String location) {
    return FutureBuilder(
      future: _transforLocationToAdress(location),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Address direccion = snapshot.data;
          return Text('Direccion: ${direccion.addressLine}');
        }
        return Text('');
      },
    );
  }

  Future<Address> _transforLocationToAdress(String location) async {
    final _location = location.substring(0).split(',');

    final lat = double.parse(_location[0]);
    final lng = double.parse(_location[1]);

    final coordinates = new Coordinates(lat, lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    return first;
  }
}
