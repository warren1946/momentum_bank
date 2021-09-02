class LoginResponse {
  String kind;
  String localId;
  String email;
  String displayName;
  String idToken;
  bool registered;
  String refreshToken;
  String expiresIn;

  LoginResponse({this.kind, this.localId, this.email, this.displayName, this.idToken, this.registered, this.refreshToken, this.expiresIn});

  LoginResponse.fromJson(dynamic json) {
    kind = json['kind'];
    localId = json['localId'];
    email = json['email'];
    displayName = json['displayName'];
    idToken = json['idToken'];
    registered = json['registered'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['kind'] = kind;
    map['localId'] = localId;
    map['email'] = email;
    map['displayName'] = displayName;
    map['idToken'] = idToken;
    map['registered'] = registered;
    map['refreshToken'] = refreshToken;
    map['expiresIn'] = expiresIn;
    return map;
  }
}
