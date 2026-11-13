import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trek_bikes_app/status.dart';

class StatusRepository {
  static Future<List<Status>> getStatuses() async {
    String url = "${dotenv.env["API_URL"]}/api/status";
    var response = await http.get(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((p) => Status.fromMap(p)).toList();
    }
    throw Exception('Not found $url');
  }
}