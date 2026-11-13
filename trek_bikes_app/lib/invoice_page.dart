import 'package:flutter/material.dart';
import 'package:trek_bikes_app/helper.dart';
import 'package:trek_bikes_app/invoice.dart';
import 'package:trek_bikes_app/invoice_repository.dart';
import 'package:trek_bikes_app/session_helper.dart';
import 'package:trek_bikes_app/status.dart';
import 'package:trek_bikes_app/status_repository.dart';

class InvoicePage extends StatefulWidget {
  final String _title;
  const InvoicePage({super.key, required this._title});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  List<Invoice> _invoices = [];
  List<Status> _status = [];
  int? _id;
  int? _statusId;

  void _loadStatuses() async {
    var data = await StatusRepository.getStatuses();
    setState(() {
      _status = data;
    });
  }

  void _loadInvoices() async {
    String? token = await SessionHelper.token;
    if (token != null) {
      var data = await InvoiceRepository.getInvoices(token);
      setState(() {
        _invoices = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInvoices();
    _loadStatuses();
  }

  Widget _loadListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          Invoice item = _invoices[index];
          return ListTile(
            leading: Text(item.id.toString()),
            title: Text(item.dated.toString()),
            subtitle: Text(item.statusId.toString()),
            trailing: ElevatedButton.icon(
              onPressed: () => _onDetails(item),
              label: Text('Details'),
              icon: Icon(Icons.details),
            ), // ElevatedButton.icon
          ); // ListTile
        },
      ), // ListView.builder
    ); // Expanded
  }

  void _onDetails(Invoice obj) async {
    _id = obj.id;
    _statusId = obj.statusId;

    var result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_id.toString()),
          content: Column(
            children: [
              DropdownButtonFormField<int>(
                initialValue: _statusId,
                items: _status.map((Status p) {
                  return DropdownMenuItem<int>(
                    value: p.id,
                    child: Text(p.name),
                  ); // DropdownMenuItem
                }).toList(),
                onChanged: (int? val) {
                  setState(() {
                    _statusId = val;
                  });
                },
              ), // DropdownButtonFormField
            ],
          ), // Column
          actions: [
            ElevatedButton.icon(onPressed: _onCancel, label: Text('Cancel')),
            ElevatedButton.icon(onPressed: _onSave, label: Text('Save')),
          ],
        ); // AlertDialog
      },
    );
    if (result == true) {
      _loadInvoices();
    }
  }

  void _onCancel() async {
    Navigator.pop(context, false);
  }

  void _onSave() async {
    String? token = await SessionHelper.token;
    if (token != null) {
      int ret = await InvoiceRepository.updateStatus(_id!, _statusId!, token);
      if (!mounted) return;
      if (ret > 0) {
        showMessage(context, 'Update success');
      } else {
        showMessage(context, "Update failed");
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._title)),
      body: Column(
        children: [
          if (_invoices.isNotEmpty) ...[_loadListView()],
        ],
      ), // Column
    ); // Scaffold
  }
}