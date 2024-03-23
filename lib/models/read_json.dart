import 'dart:convert';
import 'package:flutter/services.dart' as root_bundle;

class ReadJsonFile{
  static Future<Map<String, dynamic>> readJsonData({required String path}) async {
    final jsondata = await root_bundle.rootBundle.loadString(path);
    return json.decode(jsondata);
  }
}
