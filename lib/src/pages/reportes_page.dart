import 'package:flutter/material.dart';

import 'package:proteccion_civil_admin/src/models/reporte_model.dart';
import 'package:proteccion_civil_admin/src/provider/reportes_provider.dart';
import 'package:proteccion_civil_admin/src/utils/utils.dart';

class ReportePage extends StatefulWidget {
  @override
  _ReportePageState createState() => _ReportePageState();
}

class _ReportePageState extends State<ReportePage> {
  String direccion;
  final reportesProvider = ReporteProvider();

  @override
  void initState() {
    reportesProvider.cargarReportes();
    super.initState();
  }

  @override
  void dispose() {
    reportesProvider.dispoStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getDate();

    return Scaffold(
      body: Container(child: _listadoReportes()),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _listadoReportes() {
    return StreamBuilder(
      stream: reportesProvider.reportesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ReporteModel>> snapshot) {
        if (snapshot.hasData) {
          final reportes = snapshot.data;

          return ListView.builder(
              itemCount: reportes.length,
              itemBuilder: (context, i) {
                return _crearItem(reportes[i]);
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
        elevation: 5.0,
        backgroundColor: Color(0xFFFB6409),
        child: Icon(Icons.add_comment_rounded),
        onPressed: () {
          Navigator.of(context).pushNamed('reportForm');
        });
  }

  Widget _crearItem(ReporteModel reporte) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('reporteDetalle', arguments: reporte);
      },
      title: Text(
        reporte.tipoReporte,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      subtitle: Text(
        reporte.fecha,
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14.0),
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
