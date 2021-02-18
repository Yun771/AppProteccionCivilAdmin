import 'package:flutter/material.dart';
import 'package:proteccion_civil_admin/src/provider/recomendaciones_provider.dart';
import 'package:proteccion_civil_admin/src/widgets/cards_personalizadas.dart';

class RecomendacionesPage extends StatefulWidget {
  @override
  _RecomendacionesPageState createState() => _RecomendacionesPageState();
}

class _RecomendacionesPageState extends State<RecomendacionesPage> {
  final recomendacionesProvider = new RecomendacionProvider();

  final keyrecomendacion = 'Recomendacion';

  @override
  void initState() {
    recomendacionesProvider..cargarRecomendaciones();
    super.initState();
  }

  @override
  void dispose() {
    recomendacionesProvider.dispoStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Navigator.of(context)
              .pushNamed('cardForm', arguments: keyrecomendacion);
        });
  }

  Widget _cardsBuilder() {
    return StreamBuilder(
      stream: recomendacionesProvider.recomendacionesStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          final recomendaciones = snapshot.data;
          return CardsPersonalizada(cardsdata: recomendaciones);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
