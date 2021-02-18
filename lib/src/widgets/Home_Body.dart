import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proteccion_civil_admin/src/pages/recomendaciones_page.dart';
import 'package:proteccion_civil_admin/src/pages/info_page.dart';
import 'package:proteccion_civil_admin/src/pages/inicio_page.dart';
import 'package:proteccion_civil_admin/src/pages/reportes_page.dart';
import 'package:proteccion_civil_admin/src/provider/ui_provider.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final currentindex = uiProvider.selectedMenuOpt;

    switch (currentindex) {
      case 0:
        return InicioPage();

      case 1:
        return ReportePage();

      case 2:
        return RecomendacionesPage();

      case 3:
        return InfoPage();

      default:
        return InicioPage();
    }
  }
}
