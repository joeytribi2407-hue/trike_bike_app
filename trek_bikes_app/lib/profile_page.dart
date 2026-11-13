import 'package:flutter/material.dart';
import 'package:trek_bikes_app/member.dart';
import 'package:trek_bikes_app/member_repository.dart';
import 'package:trek_bikes_app/session_helper.dart';

class ProfilePage extends StatefulWidget {
  final String _title;
  const ProfilePage({super.key, required this._title});
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Member? _member;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    String? token = await SessionHelper.token;
    if (token != null) {
      var data = await MemberRepository.getMember(token);
      setState(() {
        _member = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._title)),
      body: Table(
        children: [
          TableRow(
            children: [
              TableCell(child: Text('Email')),
              TableCell(child: Text(_member!.email)),
            ],
          ),
          TableRow(
            children: [
              TableCell(child: Text('Given Name')),
              TableCell(child: Text(_member!.givenName)),
            ],
          ),
        ],
      ),
    );
  }
}