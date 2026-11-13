import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trek_bikes_app/category.dart';

class CategoryRepository {
  static final String baseUrl = "http://localhost:5000/api/category";
  static Future<List<Category>?> getCategories() async {
    var rs = await http.get(Uri.parse(baseUrl), headers: {'content-type': "application/json"});
    if (rs.statusCode == 200) {
      List<dynamic> body = jsonDecode(rs.body);
      return body.map((p) => Category.fromMap(p)).toList();
    }
    return null;
  }
}