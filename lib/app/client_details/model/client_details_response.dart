class ClientDetailsResponse {
  List<int> accounts;
  int age;
  String name;

  ClientDetailsResponse({this.accounts, this.age, this.name});

  ClientDetailsResponse.fromJson(dynamic json) {
    accounts = json['accounts'] != null ? json['accounts'].cast<int>() : [];
    age = json['age'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['accounts'] = accounts;
    map['age'] = age;
    map['name'] = name;
    return map;
  }
}
