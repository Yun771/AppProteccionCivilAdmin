import 'package:flutter/material.dart';
import 'package:proteccion_civil_admin/src/models/card_model.dart';
import 'package:proteccion_civil_admin/src/provider/comunicados_provider.dart';
import 'package:proteccion_civil_admin/src/provider/recomendaciones_provider.dart';
import 'package:proteccion_civil_admin/src/utils/utils.dart';
import 'package:proteccion_civil_admin/src/widgets/app_bar.dart';

class ComunicadosForm extends StatefulWidget {
  @override
  _ComunicadosFormState createState() => _ComunicadosFormState();
}

class _ComunicadosFormState extends State<ComunicadosForm> {
  final formKey = GlobalKey<FormState>();
  final scaffKeyCo = GlobalKey<ScaffoldState>();

  String _tipoCard;
  ComunicadosProvider _comunicadoProvider;
  RecomendacionProvider _recomendacionProvider;

  CardModel _cardModel = new CardModel();

  @override
  Widget build(BuildContext context) {
    _tipoCard = ModalRoute.of(context).settings.arguments;


    if (_tipoCard == 'Comunicado') {
      _comunicadoProvider = new ComunicadosProvider();
    } else {
      _recomendacionProvider = new RecomendacionProvider();
    }

    return Scaffold(
      key: scaffKeyCo,
      appBar: AppBarCustom(),
      body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Crear $_tipoCard',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    _crearTitulo(),
                    SizedBox(height: 20.0),
                    _crearDescripcion(),
                    SizedBox(height: 20.0),
                    _crearBoton()
                  ],
                ),
              ))),
    );
  }

  Widget _crearTitulo() {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onSaved: (newValue) => _cardModel.titulo = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Ingrese el título';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Título del $_tipoCard',
          hintText: 'Título',
          helperText: 'Título del $_tipoCard',
          icon: Icon(Icons.title)),
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      onSaved: (newValue) => _cardModel.descripcion = newValue,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          labelText: 'Inserte la descripción',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Descripción',
          helperText: 'Descripción',
          icon: Icon(Icons.text_snippet)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor ingrese el cuerpo de la descripción';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
        textColor: Colors.white,
        color: Color(0xFFFB6409),
        onPressed: _submit,
        icon: Icon(Icons.send_outlined),
        label: Text('Enviar'));
  }

  _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    _cardModel.tipoCard = _tipoCard;

    _cardModel.fecha = getDate();

    switch (_tipoCard) {
      case 'Comunicado':
        _comunicadoProvider.crearComunicado(_cardModel);

        FocusScope.of(context).requestFocus(FocusNode());

        Navigator.pop(context);
        break;

      case 'Recomendacion':
        _recomendacionProvider.crearRecomendacion(_cardModel);
        FocusScope.of(context).requestFocus(FocusNode());

        Navigator.pop(context);

        break;
    }

    void mostrarSnackBar(String mensaje) {
      final snacbark = SnackBar(
        content: Text(
          mensaje,
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1500),
      );

      scaffKeyCo.currentState.showSnackBar(snacbark);
    }
  }
}
