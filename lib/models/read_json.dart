import 'dart:convert';
import 'package:flutter/services.dart' as root_bundle;

class ReadJsonFile{
  static Future<Map<String, dynamic>> readJsonData({required String path}) async {

    // read json file
    final jsondata = await root_bundle.rootBundle.loadString(path);

    // decode json data as list
    return json.decode(jsondata);
  }
}
