import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/models/OrderList.dart';
import 'package:shop/models/ProductList.dart';
import 'package:shop/pages/CartPage.dart';
import 'package:shop/pages/ProductDetailPage.dart';
import 'package:shop/pages/ProductFormPage.dart';
import 'package:shop/pages/ProductsOverviewPage.dart';
import 'package:shop/pages/ManageProducts.dart';
import 'package:shop/pages/OrdersPage.dart';
import 'utils/AppRoutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            titleTextStyle: TextStyle(
              fontFamily: 'Lato',
              color: Colors.white,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        routes: {
          AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => ManageProducts(),
          AppRoutes.PRODUCTS_FORM: (ctx) => ProductFormPage(),

        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}