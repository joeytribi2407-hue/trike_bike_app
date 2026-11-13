import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trek_bikes_app/invoice.dart';

class InvoiceRepository {
  static final String baseUrl = "http://localhost:5000/api/invoice";
  static Future<int> add(Invoice obj, String token) async {
    var rs = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'content-type': "application/json",
        "authorization": 'Bearer $token',
      },
      body: jsonEncode(obj.toMap()),
    );
    if (rs.statusCode == 200) {
      return int.parse(rs.body);
    }
    return -2;
  }
  
  static Future<int> updateStatus(int id, int statusId, String token) async {
    var rs = await http.put(
      Uri.parse('$baseUrl/status?id=$id&statusId=$statusId'),
      headers: {
        'content-type': "application/json",
        "authorization": 'Bearer $token',
      },
    );
    if (rs.statusCode == 200) {
      return int.parse(rs.body);
    }
    return -2;
  }
  

  static Future<Invoice> getInvoice(int id,String token) async {
    var rs = await http.get(
      Uri.parse('$baseUrl/details/$id'),
      headers: {
        'content-type': "application/json",
        "authorization": 'Bearer $token',
      },
    );
    if (rs.statusCode == 200) {
      dynamic data = await jsonDecode(rs.body);

      return Invoice.fromMap(data);
    }
    throw Exception('Not found $baseUrl');
  }
  
  static Future<List<Invoice>> getInvoices(String token) async {
    var rs = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'content-type': "application/json",
        "authorization": 'Bearer $token',
      },
    );
    if (rs.statusCode == 200) {
      List<dynamic> data = await jsonDecode(rs.body);

      return data.map((p) => Invoice.fromMap(p)).toList();
    }
    throw Exception('Not found $baseUrl');
  }
}