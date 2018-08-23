import 'dart:async';

import 'package:flutter/material.dart';
import 'package:am_eventos/database/database_helper.dart';
import 'package:am_eventos/database/model/user.dart';

class AddUserDialog {
  final teEvento = TextEditingController();
  final teLugarEvento = TextEditingController();
  final teFechaEvento = TextEditingController();
  //final tePrecioPactado = TextEditingController();
/*  final teAdelanto = TextEditingController();
  final teSaldo = TextEditingController();*/

  User user;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(
      BuildContext context, _myHomePageState, bool isEdit, User user) {
    if (user != null) {
      this.user=user;
      teEvento.text = user.evento;
      teLugarEvento.text = user.lugar_evento;
      teFechaEvento.text = user.fecha_evento;
      //tePrecioPactado.text = user.precio_pactado;
/*      teAdelanto.text = user.adelanto;
      teSaldo.text = user.saldo;*/
    }

    return new AlertDialog(
      title: new Text(isEdit ? 'Editar Evento' : 'Ingresar Nuevo Evento'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Nombre del Evento", teEvento),
            getTextField("Lugar del Evento", teLugarEvento),
            getTextField("Fecha del Evento", teFechaEvento),
            //getTextField("Precio Pactado", tePrecioPactado),
/*            getTextField("Adelanto", teAdelanto),
            getTextField("Saldo", teSaldo),*/
            new GestureDetector(
              onTap: () {
                addRecord(isEdit);
                _myHomePageState.displayRecord();
                Navigator.of(context).pop();
              },
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(
                    isEdit?"Editar":"Ingresar", EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  Future addRecord(bool isEdit) async {
    var db = new DatabaseHelper();
    //var user = new User(teEvento.text, teLugarEvento.text, teFechaEvento.text, tePrecioPactado.text, teAdelanto.text, teSaldo.text);
    var user = new User(teEvento.text, teLugarEvento.text, teFechaEvento.text);
    if (isEdit) {
      user.setUserId(this.user.id);
      await db.update(user);
    } else {
      await db.saveUser(user);
    }
  }
}
