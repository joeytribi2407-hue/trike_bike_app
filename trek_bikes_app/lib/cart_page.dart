import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trek_bikes_app/cart_ext.dart';
import 'package:trek_bikes_app/cart_repository.dart';
import 'package:trek_bikes_app/helper.dart';
import 'package:trek_bikes_app/invoice.dart';
import 'package:trek_bikes_app/invoice_repository.dart';
import 'package:trek_bikes_app/session_helper.dart';

class CartPage extends StatefulWidget {
  final String _title;
  const CartPage({super.key, required this._title});
  @override
  State<StatefulWidget> createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
  List<CartExt> _carts = [];
  String? _error;
  @override
  void initState() {
    super.initState();
    _loadCarts();
  }
  void _loadCarts() async {
    String? token = await SessionHelper.token;
    if (token != null) {
      var data = await CartRepository.getCarts(token);
      setState(() {
        _carts = data;
      });
    }
  }
  Widget _loadTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Bike')),
        DataColumn(label: Text('Image')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Command')),
      ],
      rows: _carts
          .map(
            (p) =>new DataRow(
              cells: [
                DataCell(Text(p.name)),
                DataCell(
                  Image.network(
                    '${dotenv.env['API_URL']}/bikes/${p.imageUrl}',
                    width:64,
                    )
                  ),
                DataCell(Text(p.price.toString())),
                DataCell(Text(p.quantity.toString())),
                DataCell(Text((p.price * p.quantity).toString())),
                DataCell(
                  ElevatedButton.icon(
                    onPressed:()=> _onDelete(p.id),
                    label: Text('Delete'),
                    icon: Icon(Icons.delete),
                  ),
                )
              ],
            ),
          )
          .toList(),
    );
  }
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(widget._title)),
        body: Column(children: [
          _loadTable(),
          ElevatedButton.icon(
            onPressed: _onCheckout,
            label: Text('Checkout'),
            icon: Icon(Icons.shopping_cart_checkout),
          ),
          if (_error != null) Text(_error!),
        ]),
      );
    }
  void _onDelete(int id) async {
    String? token = await SessionHelper.token;
    if (token != null && token.isNotEmpty) {
      int ret = await CartRepository.delete(id, token);
      if (ret > 0) {
        _loadCarts();
      } else {
        setState(() {
          _error = 'Insert failed $ret';
        });
      }
    } else {
      setState(() {
        _error = 'You must login';
      });
    }
  }

  void _onCheckout() async {
    String? token = await SessionHelper.token;
    if (token != null) {
      Random random=Random();
      Invoice obj = Invoice(id: random.nextInt(99999)+99999, statusId: 1, memberId: null, dated:null);
      int ret = await InvoiceRepository.add(obj,token);
      if (ret > 0) {
        if(!mounted) return;
        showMessage(context, 'Checkout success');
        setState((){
          _error=null;
        });
        ///_loadCarts();
        Navigator.popAndPushNamed(context, '/invoice/details',
        arguments:obj.id,
        );
      } else {
        setState(() {
          _error = 'Checkout failed $ret';
        });
      }
    }
  }
}
