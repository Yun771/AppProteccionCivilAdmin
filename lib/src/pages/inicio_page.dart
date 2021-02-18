import 'package:flutter/material.dart';
import 'package:proteccion_civil_admin/src/provider/comunicados_provider.dart';
import 'package:proteccion_civil_admin/src/utils/utils.dart';
import 'package:proteccion_civil_admin/src/widgets/cards_personalizadas.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final comunicadosProvider = new ComunicadosProvider();

  

  final keycomunicado = 'Comunicado';

  @override
  void initState() {
    comunicadosProvider.cargarComunicados();
    super.initState();
  }

  @override
  void dispose() {
    comunicadosProvider.dispoStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getDate();
    return Scaffold(
      body: Container(child: _cardsBuilder()),
      floatingActionButton: _crearBoton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
        elevation: 5.0,
        backgroundColor: Color(0xFFFB6409),
        child: Icon(Icons.add_comment_rounded),
        onPressed: () {
          Navigator.of(context).pushNamed('cardForm', arguments: keycomunicado);
        });
  }

  Widget _cardsBuilder() {
    return StreamBuilder(
      stream: comunicadosProvider.comunicadosStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          final comunidados = snapshot.data;
          return CardsPersonalizada(cardsdata: comunidados);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
