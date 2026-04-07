import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/AppDrawer.dart';
import 'package:shop/components/Order.dart';
import 'package:shop/models/OrderList.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
      ),
    );
  }
}