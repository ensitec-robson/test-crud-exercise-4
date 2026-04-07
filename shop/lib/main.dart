import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/models/Order_list.dart';
import 'package:shop/models/Product_list.dart';
import 'package:shop/pages/Cart_page.dart';
import 'package:shop/pages/Product_detail_page.dart';
import 'package:shop/pages/Product_form_page.dart';
import 'package:shop/pages/Products_overview_page.dart';
import 'package:shop/pages/Manage_products.dart';
import 'package:shop/pages/orders_page.dart';
import 'utils/App_routes.dart';

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
        // home: ProductsOverviewPage(),
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