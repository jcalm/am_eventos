import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:am_eventos/add_user_dialog.dart';
import 'package:am_eventos/database/model/user.dart';
import 'package:am_eventos/home_presenter.dart';

class UserList extends StatelessWidget {
  List<User> country;
  HomePresenter homePresenter;

  UserList(
    List<User> this.country,
    HomePresenter this.homePresenter, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: country == null ? 0 : country.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
                child: new Center(
                  child: new Row(
                    children: <Widget>[
                      new CircleAvatar(
                        radius: 17.0,
                        child: new Text(getShortName(country[index])),
                        backgroundColor: const Color(0xFF20283e),
                      ),
                      new Expanded(
                        child: new Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(country[index].evento,
                                  // set some style to text
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.blueAccent.shade700)),
                              new Text(country[index].lugar_evento,
                                  // set some style to text
                                  style: new TextStyle(
                                      fontSize: 16.0, color: Colors.black87)),
                              new Text(
                                "Fecha del evento: " +
                                    country[index].fecha_evento,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.teal.shade800),
                              ),
                              /*new Text(
                                "Precio Pactado: " +
                                    country[index].precio_pactado,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                              ),*/
                              /*new Text(
                                "Adelanto: " + country[index].adelanto,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                              ),
                              new Text(
                                "Saldo: " + country[index].saldo,
                                // set some style to text
                                style: new TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: const Color(0xFF167F67),
                            ),
                            onPressed: () => edit(country[index], context),
                          ),
                          new IconButton(
                            icon: const Icon(Icons.delete_forever,
                                color: Colors.red),
                            onPressed: () =>
                                homePresenter.delete(country[index]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
          );
        });
  }

  displayRecord() {
    homePresenter.updateScreen();
  }

  edit(User user, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddUserDialog().buildAboutDialog(context, this, true, user),
    );
    homePresenter.updateScreen();
  }

  String getShortName(User user) {
    String shortName = "";
    if (!user.evento.isEmpty) {
      shortName = user.evento.substring(0, 1) + ".";
    }

    if (!user.lugar_evento.isEmpty) {
      shortName = shortName + user.lugar_evento.substring(0, 1);
    }
    return shortName;
  }
}
