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

    return LayoutBuilder(
      builder: (context, constraints) {
        int gridCount = 2;

        if (constraints.maxWidth > 1800) {
          gridCount = 5;
        } else if (constraints.maxWidth > 1200) {
          gridCount = 4;
        } else if (constraints.maxWidth > 800) {
          gridCount = 3;
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: loadedProducts.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: loadedProducts[i],
            child: ProductGridItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      },
    );
  }
}