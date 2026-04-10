import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/AppDrawer.dart';
import 'package:shop/components/Order.dart';
import 'package:shop/models/OrderList.dart';
import 'package:shop/utils/AppRoutes.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);

    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: isDesktop ?
        Padding(
          padding: EdgeInsets.only(left: 350),
          child: Text('Meus Pedidos'),
          ) 
        :
        Text('Meus Pedidos'),
      ),
      drawer: isDesktop ? null : AppDrawer(),
      body: isDesktop
    ? Row(
        children: [
                  const SizedBox(
                    width: 250,
                    child: AppDrawer(),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110),
                      child: ListView.builder(
                        itemCount: orders.itemsCount,
                        itemBuilder: (ctx, i) =>
                            OrderWidget(order: orders.items[i]),
                      ),
                    ),
                  ),
                ],
              )
              : ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) =>
                      OrderWidget(order: orders.items[i]),
                ),
    );
  }
}