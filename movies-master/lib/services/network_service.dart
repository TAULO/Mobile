import 'dart:convert';

import 'package:flutter/services.dart';

class NetworkService {
  static dynamic loadJsonData({required String path}) async {
    var jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }
}
