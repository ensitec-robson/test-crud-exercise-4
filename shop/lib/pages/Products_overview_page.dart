import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/App_drawer.dart';
import 'package:shop/components/Product_grid.dart';
import 'package:shop/enum/FilterOptions.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/models/Product_list.dart';
import 'package:shop/utils/App_routes.dart';


class ProductsOverviewPage extends StatelessWidget {

const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.FAVORITE,
                child: Text('Somente Favoritos'),
                ),
                PopupMenuItem(
                value: FilterOptions.ALL,
                child: Text('Todos'),
                ),
          ],
          onSelected: (FilterOptions selectedValue) {
            if (selectedValue == FilterOptions.FAVORITE) {
              provider.showFavoriteOnly();
            } else {
              provider.showAll();
            }
          },
          ),
            Consumer<Cart>(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.CART);
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              builder: (ctx, cart, child) => Badge(
                label: Text(cart.itemsCount.toString()),
                child: child!,
              ),
            )
        ]
      ),
      body: ProductGrid(),
      drawer: AppDrawer(),
    );
  }
}

