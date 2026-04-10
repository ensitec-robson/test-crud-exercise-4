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
    final isDesktop = constraints.maxWidth >= 900;

        if (constraints.maxWidth > 1800) {
          gridCount = 5;
        } else if (constraints.maxWidth > 1200) {
          gridCount = 4;
        } else if (constraints.maxWidth > 800) {
          gridCount = 3;
        }

        return ListView(
          padding: const EdgeInsets.all(10),
          children: [
            if (isDesktop)
  const Padding(
    padding: EdgeInsets.only(top: 25, bottom: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vestuário',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Em promoção',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loadedProducts.length >= 4 ? 4 : loadedProducts.length,
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
            ),

            if (loadedProducts.length > 4) ...[
              const SizedBox(height: 20),

              if (isDesktop)
  const Padding(
    padding: EdgeInsets.only(top: 25, bottom: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eletrônicos',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Em promoção',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: loadedProducts.length - 4,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: loadedProducts[i + 4],
                  child: ProductGridItem(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}