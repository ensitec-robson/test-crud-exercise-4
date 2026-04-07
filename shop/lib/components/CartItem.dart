import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/models/CartItem.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({
    super.key,
    required this.cartItem,
    });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (_) {
          return showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Tem Certeza?'),
              content: Text('Deseja remover o item do carrinho?'),
              actions: [
                TextButton(
                child: Text('Não'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  ),
                TextButton(
                child: Text('Sim'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  )
              ],
            )
            
            );
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false,).removeItem(cartItem.productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.name),
            subtitle: Text('Total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}