import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/AppDrawer.dart';
import 'package:shop/components/ProductGrid.dart';
import 'package:shop/enum/FilterOptions.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/models/ProductList.dart';
import 'package:shop/utils/AppRoutes.dart';

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      try {
        await Provider.of<ProductList>(context, listen: false).loadProducts();
      } catch (error) {
        _hasError = true;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: isDesktop
          ? const Padding(
              padding: EdgeInsets.only(left: 350),
              child: Text('Minha loja'),
            )
          : const Text('Minha loja'),
        actions: [
              Padding(
                padding: EdgeInsets.only(right: isDesktop ? 120 : 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: FilterOptions.FAVORITE,
                          child: Text('Somente Favoritos'),
                        ),
                        const PopupMenuItem(
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
                    ),
                  ],
                ),
              ),
            ],
      ),
      drawer: isDesktop ? null : AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? const Center(child: Text('Erro ao carregar produtos'))
                : isDesktop
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
                      child: ProductGrid(),
                    ),
                  ),
                ],
              )
                : const ProductGrid(),
                );
  }
}