import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> readJsonFromAssets(String path) async {
  final String jsonString = await rootBundle.loadString(path);
  final jsonData = json.decode(jsonString) as List<dynamic>;
  return jsonData.map((item) => item as Map<String, dynamic>).toList();
}