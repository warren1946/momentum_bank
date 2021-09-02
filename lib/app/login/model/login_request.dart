class LoginRequest {
  String email;
  String password;
  bool returnSecureToken;

  LoginRequest({this.email, this.password, this.returnSecureToken});

  LoginRequest.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
    returnSecureToken = json['returnSecureToken'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['returnSecureToken'] = returnSecureToken;
    return map;
  }
}
