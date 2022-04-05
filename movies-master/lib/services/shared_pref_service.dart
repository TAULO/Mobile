import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  dynamic get(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String json = sharedPreferences.getString(key) ?? "";
    dynamic objects;

    if (json != "") {
      objects = jsonDecode(json);
    }

    return objects;
  }

  save(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }
}
