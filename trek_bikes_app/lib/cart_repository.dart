import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trek_bikes_app/cart.dart';
import 'package:trek_bikes_app/cart_ext.dart';

class CartRepository {
  static final String baseUrl = "http://localhost:5000/api/cart";

  static Future<int> add(Cart obj, String token) async {
    var rs = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: jsonEncode(obj.toMap()),
    );

    if (rs.statusCode == 200) {
      return int.parse(rs.body);
    }

    return -2;
  }
  static Future<int> delete(int id, String token) async {
    var rs = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    if (rs.statusCode == 200) {
      return int.parse(rs.body);
    }
    return -2;
  }
  static Future<List<CartExt>> getCarts(String token) async {
    var rs = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'content-type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    if (rs.statusCode == 200) {
      List<dynamic> data = jsonDecode(rs.body);
      return data.map((p) => CartExt.fromMap(p)).toList();
    }

    throw Exception('Not found $baseUrl');
  }
}