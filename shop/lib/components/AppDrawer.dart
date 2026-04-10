import 'package:flutter/material.dart';
import 'package:shop/utils/AppRoutes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return isDesktop
        ? Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Bem vindo Usuário!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Loja'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.HOME,
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Pedidos'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.ORDERS,
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Gerenciar Produtos'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.PRODUCTS,
                    );
                  },
                ),
              ],
            ),
          )
        : Drawer(
            child: Column(
              children: [
                AppBar(
                  title: Text('Bem vindo Usuário!'),
                  automaticallyImplyLeading: false,
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Loja'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.HOME,
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Pedidos'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.ORDERS,
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Gerenciar Produtos'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.PRODUCTS,
                    );
                  },
                ),
              ],
            ),
          );
  }
}