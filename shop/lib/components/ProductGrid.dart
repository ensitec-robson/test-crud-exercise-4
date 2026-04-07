import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/ProductGridItem.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/models/ProductList.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});


  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<ProductList>(context);
  final List<Product> loadedProducts = provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductGridItem(),
        ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}