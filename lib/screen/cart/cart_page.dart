import 'package:compras_full/models/cart/cart_item.dart';
import 'package:compras_full/models/cart/cart_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    late final List<CartItem> cart = context.watch<CartService>().cart;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your cart (${cart.length})"),
      ),
      body: ListView(
        children: cart
            .map(
              (CartItem e) => ListTile(
                title: Text(e.name ?? ''),
                subtitle: Text("USD ${e.price ?? ''}"),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    context.read<CartService>().removeFromCart(e);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
