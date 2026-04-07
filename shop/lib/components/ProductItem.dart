import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/models/ProductList.dart';
import 'package:shop/utils/AppRoutes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem(
    this.product, {
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTS_FORM,
                  arguments: product,
                );
              },
            ),
            
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,

              onPressed: () {
                Provider.of<ProductList>(context, listen: false).deleteProduct(product);
              },
            )
          ],
        ),
      ),
    );
  }
}