import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proteccion_civil_admin/src/pages/card_form.dart';
import 'package:proteccion_civil_admin/src/pages/reporte_form.dart';
import 'package:proteccion_civil_admin/src/pages/reportes_detalles_page.dart';
import 'package:proteccion_civil_admin/src/pages/reportes_page.dart';
import 'package:proteccion_civil_admin/src/provider/ui_provider.dart';
import 'package:proteccion_civil_admin/src/pages/card_detalle_page.dart';
import 'package:proteccion_civil_admin/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => new UIProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Protección Civil',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => HomePage(),
          'comunicadoDetalle': (BuildContext context) => CardDetallePage(),
          'reporte': (BuildContext context) => ReportePage(),
          // 'consejo': (BuildContext context) => Consejo(),
          // 'info': (BuildContext context) => Info()
          'reportForm': (BuildContext context) => FormReporte(),
          'cardForm': (BuildContext context) => ComunicadosForm(),
          'reporteDetalle': (BuildContext context) => ReporteDetallePage()
        },
        theme: ThemeData(primaryColor: Color(0xFFFB6409)),
      ),
    );
  }
}
