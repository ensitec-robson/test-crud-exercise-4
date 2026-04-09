import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/AppDrawer.dart';
import 'package:shop/components/ProductItem.dart';
import 'package:shop/models/ProductList.dart';
import 'package:shop/utils/AppRoutes.dart';

class ManageProducts extends StatelessWidget {
  const ManageProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

        final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
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
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCTS_FORM
                );
              },
            )
        ],
      ),
      drawer: isDesktop ? null : AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(products.items[i]),
              Divider(),
            ],
          ),
        ),
        ),
    );
  }
}