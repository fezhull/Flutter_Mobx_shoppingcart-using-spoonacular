
// cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cart_store.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartStore = CartStore();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Observer(
        builder: (_) {
          return ValueListenableBuilder<Box<CartItem>>(
            valueListenable: Hive.box<CartItem>('cartBox').listenable(),
            builder: (context, box, _) {
              final cartItems = box.values.toList();
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () {
                        cartStore.removeFromCart(item.id);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


