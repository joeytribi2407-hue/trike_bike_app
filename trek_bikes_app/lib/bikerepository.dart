import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trek_bikes_app/bike.dart';


class BikeRepository {
  static Future<Bike> getBike(int id) async {
    String url = '${dotenv.env['API_URL']}/api/bike/details/$id';
    var response = await http.get(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return Bike.fromMap(data);
    }
    throw Exception('Not found $url');
  }
  static Future<List<Bike>> getBikes() async {
    String url = '${dotenv.env['API_URL']}/api/bike';
    var response = await http.get(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((p) => Bike.fromMap(p)).toList();
    }
    throw Exception('Not found $url');
  }

  static Future<List<Bike>> getBikesByCategory(int id) async {
    String url = '${dotenv.env['API_URL']}/api/bike/category/$id';
    var response = await http.get(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((p) => Bike.fromMap(p)).toList();
    }
    throw Exception('Not found $url');
  }

  static Future<List<Bike>> getBikesBySubCategories(List<int> ids) async {
    String url = '${dotenv.env['API_URL']}/api/bike/subcategories';
    var response = await http.get(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((p) => Bike.fromMap(p)).toList();
    }
    throw Exception('Not found $url');
  }
  
}