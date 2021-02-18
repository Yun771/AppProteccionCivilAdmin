import 'package:flutter/material.dart';

import 'package:proteccion_civil_admin/src/models/card_model.dart';
import 'package:proteccion_civil_admin/src/utils/utils.dart';
import 'package:proteccion_civil_admin/src/widgets/app_bar.dart';

class CardDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CardModel _cardData = ModalRoute.of(context).settings.arguments;
    int _tipoCard;

    if (_cardData.tipoCard == 'Comunicado') {
      _tipoCard = 2;
    } else {
      _tipoCard = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_cardData.tipoCard),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              onPressed: () {
                mostrarAlert(context, '¿Desea Eliminar ${_cardData.tipoCard}?',
                    _cardData.id, _tipoCard);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(_cardData.titulo,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5.0,
              ),
              Text(_cardData.fecha,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0)),
              SizedBox(
                height: 20.0,
              ),
              Text(
                _cardData.descripcion,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
