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
        title: isDesktop ?
        Padding(
          padding: EdgeInsets.only(left: 350),
          child: Text('Gerenciar Produtos')
          ) : Text('Gerenciar Produtos'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isDesktop ? 120 : 0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTS_FORM
                  );
                },
              ),
          )
        ],
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
                itemCount: products.itemsCount,
                itemBuilder: (ctx, i) => Column(
                  children: [
                    ProductItem(products.items[i]),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    : Padding(
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