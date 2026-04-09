import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/models/ProductList.dart';
import 'package:shop/utils/AppRoutes.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);

    return Consumer<Product>(
      builder: (ctx, product, _) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading: IconButton(
                onPressed: () async {
                    await Provider.of<ProductList>(context, listen: false)
                        .updateFavorite(product);
                  },
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border ),
                color: Theme.of(context).colorScheme.error,
                ),
              title: Text(
                product.title,
                textAlign: TextAlign.center,
                ),
              trailing: IconButton(
                onPressed: () {
                  cart.addItem(product);

                  final messenger = ScaffoldMessenger.of(context);

                  messenger.hideCurrentSnackBar();

                  messenger.showSnackBar(
                    SnackBar(
                      content: const Text('Produto adicionado com sucesso.'),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        label: 'DESFAZER',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    messenger.hideCurrentSnackBar();
                  });
                },
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).colorScheme.error,
                ),
            ),
          child: GestureDetector(
            child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_DETAIL,
                  arguments: product,
              );
            } ,
          ),
        ),
      ),
    );
  }
}