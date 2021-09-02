import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences _sharedPrefs;
  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  read({String key}) {
    return json.decode(_sharedPrefs.getString(key));
  }

  save({String key, value}) {
    _sharedPrefs.setString(key, json.encode(value));
  }

  remove({String key}) {
    _sharedPrefs.remove(key);
  }
}

final appPreferences = AppPreferences();
