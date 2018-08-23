class User {

  int id;
  String _evento;
  String _lugar_evento;
  String _fecha_evento;
  //String _precio_pactado;
/*  String _adelanto;
  String _saldo;*/

  //User(this._evento, this._lugar_evento, this._fecha_evento, this._precio_pactado, this._adelanto, this._saldo);
  User(this._evento, this._lugar_evento, this._fecha_evento);

  User.map(dynamic obj) {
    this._evento = obj["evento"];
    this._lugar_evento = obj["lugar_evento"];
    this._fecha_evento = obj["fecha_evento"];
    //this._precio_pactado = obj["precio_pactado"];
/*    this._adelanto = obj["adelanto"];
    this._saldo = obj["saldo"];*/
  }

  String get evento => _evento;
  String get lugar_evento => _lugar_evento;
  String get fecha_evento => _fecha_evento;

  //String get precio_pactado => _precio_pactado;
/*  String get adelanto => _adelanto;
  String get saldo => _saldo;*/

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["evento"] = _evento;
    map["lugar_evento"] = _lugar_evento;
    map["fecha_evento"] = _fecha_evento;
    //map["precio_pactado"] = _precio_pactado;
/*    map["adelanto"] = _adelanto;
    map["saldo"] = _saldo;*/

    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}