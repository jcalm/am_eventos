import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:am_eventos/add_user_dialog.dart';
import 'package:am_eventos/database/database_helper.dart';
import 'package:am_eventos/database/model/user.dart';
import 'package:am_eventos/home_presenter.dart';
import 'package:am_eventos/list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements HomeContract {
  HomePresenter homePresenter;

  @override
  void initState() {
    super.initState();
    homePresenter = new HomePresenter(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
/*            new Text('Agua Marina - Eventos',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),*/
          ],
        ),
      ),
    );

  }


  Future _openAddUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddUserDialog().buildAboutDialog(context, this, false, null),
    );

    setState(() {});
  }

  List<Widget> _buildActions() {
    return <Widget>[
      new IconButton(
        icon: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
        onPressed: _openAddUserDialog,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
      ),

     body: new FutureBuilder<List<User>>(
        future: homePresenter.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData
              ? new UserList(data,homePresenter)
              : new Center(child: new CircularProgressIndicator());
        },
     ),
      );
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}


