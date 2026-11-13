import 'package:flutter/material.dart';
import 'package:trek_bikes_app/member.dart';
import 'package:trek_bikes_app/member_repository.dart';

class RegisterPage extends StatefulWidget {
  final String _title;
  const RegisterPage({super.key, required this._title});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _givenNameController = TextEditingController();
  final _surnameController = TextEditingController();
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
            TextFormField(
              controller: _givenNameController,
              decoration: InputDecoration(labelText: 'Given Name'),
            ),
            TextFormField(
              controller: _surnameController,
              decoration: InputDecoration(labelText: 'Surname'),
            ),
            ElevatedButton.icon(
              onPressed: _register,
              icon: Icon(Icons.check),
              label: Text('Register'),
            ),
            if (_error != null && _error!.isNotEmpty) Text(_error!),
          ],
        ),
      ),
    );
  }

  void _register() async {
    Member obj = Member(
      id: null,
      email: _emailController.text,
      password: _passwordController.text,
      givenName: _givenNameController.text,
      surname: _surnameController.text,
      role: 0,
    );
    int ret = await MemberRepository.add(obj);
    debugPrint("Error: $ret");
    if (!mounted) return;
    if (ret > 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Register Success')));
      Navigator.pop(context, true);
    } else {
      setState(() {
        _error = "Insert failed with code: $ret";
      });
    }
  }
}
