import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:trek_bikes_app/login.dart';
import 'package:trek_bikes_app/login_response.dart';
import 'package:trek_bikes_app/member.dart';

class MemberRepository {
  static Future<int> add(Member obj) async {
    String path = 'http://localhost:5000/api/auth/register';
    var response = await post(
      Uri.parse(path),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(obj.toMap()),
    );
    if (response.statusCode == 200) {
      return int.parse(response.body);
    }
    return -2;
  }


  static Future<LoginResponse?> login(Login obj) async {
    String path = 'http://localhost:5000/api/auth/login';
    var response = await post(
      Uri.parse(path),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(obj.toMap()),
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromMap(jsonDecode(response.body));
    }
    return null;
  }


static Future<Member?> getMember(String token) async {
    String path = 'http://localhost:5000/api/auth';
    var response = await http.get(
      Uri.parse(path),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return Member.fromMap(jsonDecode(response.body));
    }
    return null;
  }
}