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
    final isDesktop = MediaQuery.of(context).size.width >= 900;
  
  if(!isDesktop) {


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
  return Container(
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  child: Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          product.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: Text(
          product.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.edit),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.PRODUCTS_FORM,
            arguments: product,
          );
        },
      ),
      const SizedBox(width: 8),
      IconButton(
        icon: const Icon(Icons.delete),
        color: Theme.of(context).colorScheme.error,
        onPressed: () {
          Provider.of<ProductList>(context, listen: false)
              .deleteProduct(product);
        },
      ),
    ],
  ),
);
  }
}