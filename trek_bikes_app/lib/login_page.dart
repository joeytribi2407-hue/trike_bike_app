import 'package:flutter/material.dart';
import 'package:trek_bikes_app/login.dart';
import 'package:trek_bikes_app/login_response.dart';
import 'package:trek_bikes_app/member_repository.dart';
import 'package:trek_bikes_app/session_helper.dart';

class LoginPage extends StatefulWidget {
  final String _title;
  const LoginPage({super.key, required this._title});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._title)),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton.icon(
              onPressed: _login,
              icon: Icon(Icons.check),
              label: Text('Login'),
            ),
            if (_error != null && _error!.isNotEmpty) Text(_error!),
          ],
        ),
      ),
    );
  }

  void _login() async {
    String email = _emailController.text.trim();
    var obj = Login(email: email, password: _passwordController.text);
    LoginResponse? result = await MemberRepository.login(obj);
    if (result != null) {
      if (result.success) {
        await SessionHelper.save(email, result.token!);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login Success')));
        Navigator.pop(context, true);
      }
      setState(() {
        _error = result.message;
      });
    } else {
      setState(() {
        _error = "Login Failed";
      });
    }
  }
}