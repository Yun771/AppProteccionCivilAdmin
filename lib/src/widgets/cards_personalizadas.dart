import 'package:flutter/material.dart';

import 'package:proteccion_civil_admin/src/models/card_model.dart';

class CardsPersonalizada extends StatelessWidget {
  final List<CardModel> cardsdata;

  CardsPersonalizada({@required this.cardsdata});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: ListView.builder(
        itemCount: cardsdata.length,
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _cardsPersonalizada(context, cardsdata[i]),
              SizedBox(
                height: 20.0,
              )
            ],
          );
        },
      ),
    );
  }

  Widget _cardsPersonalizada(BuildContext context, CardModel cardData) {
    final card = Container(
      height: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _titulo(cardData.titulo),
          SizedBox(
            height: 10.0,
          ),
          _fecha(cardData.fecha),
          SizedBox(
            height: 10.0,
          ),
          _descripcion(cardData.descripcion),
          SizedBox(height: 10.0),
          _boton(context, cardData)
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
      child: card,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 10.0))
          ]),
    );
  }

  Widget _titulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _fecha(String fecha) {
    return Text(
      fecha,
      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),
    );
  }

  Widget _descripcion(String descripcion) {
    return Text(
      descripcion,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(),
      textAlign: TextAlign.justify,
      maxLines: 5,
    );
  }

  Widget _boton(BuildContext context, CardModel carddata) {
    return FlatButton(
      onPressed: () => Navigator.pushNamed(context, 'comunicadoDetalle',
          arguments: carddata),
      child: Text(
        'Ver mas...',
        style: TextStyle(color: Colors.white),
      ),
      color: Color(0xFFFB6409),
    );
  }
}
