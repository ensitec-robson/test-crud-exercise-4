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
        title: Text('Meus Pedidos'),
        actions: [
          if (isDesktop) ...[
          TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                },
                child: const Text(
                  'Loja',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
              },
              child: const Text(
                'Pedidos',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
              },
              child: const Text(
                'Gerenciar Produtos',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      drawer: isDesktop ? null : AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
      ),
    );
  }
}