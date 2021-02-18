import 'package:flutter/material.dart';


import 'package:proteccion_civil_admin/src/widgets/Home_Body.dart';
import 'package:proteccion_civil_admin/src/widgets/Navigator_bar.dart';
import 'package:proteccion_civil_admin/src/widgets/app_bar.dart';

// * Son las imprtaciones de las otras pantallas

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: HomePageBody(),
      bottomNavigationBar: NavigatorBarCustom(),
    );
  }
}
