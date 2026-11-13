import 'package:flutter/material.dart';
import 'package:trek_bikes_app/invoice.dart';
import 'package:trek_bikes_app/invoice_repository.dart';
import 'package:trek_bikes_app/session_helper.dart';

class InvoiceDetailsPage extends StatefulWidget {
  final String _title;
  const InvoiceDetailsPage({super.key, required this._title});

  @override
  State<StatefulWidget> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  Invoice? _invoice;
  @override
  void didChangeDependencies(){
  super.didChangeDependencies();
  int id = ModalRoute.of(context)!.settings.arguments as int;
  _loadInvoice(id);
  }

  void _loadInvoice(int id) async {
    String? token = await SessionHelper.token;
    if(token != null){
      var data = await InvoiceRepository.getInvoice(id, token);
      setState(() {
        _invoice = data;
      });
    }
  }


  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._title)),
      body: Column(
        children: [
          if(_invoice !=null)...[
            Text(_invoice!.id.toString()),
            Text(_invoice!.dated.toString()),
            Text(_invoice!.statusId.toString()),
          ]else
          Text('Not found data'),
        ],
      ),
    );
  }
}