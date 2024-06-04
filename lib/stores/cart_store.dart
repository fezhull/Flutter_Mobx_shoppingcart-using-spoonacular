// cart_store.dart
import 'package:hive/hive.dart';
import 'package:mobxshoppingcart/models/product.dart';
import '../models/cart_item.dart';

class CartStore {
  static const _cartBoxName = 'cartBox';

  void addToCart(Product product) async {
    final box = await Hive.openBox<CartItem>(_cartBoxName);
    final cartItem = CartItem(id: product.id, name: product.name, price: product.price);
    if (box.containsKey(cartItem.id)) {
      final existingItem = box.get(cartItem.id)!;
      existingItem.quantity++;
      await box.put(existingItem.id, existingItem);
    } else {
      await box.put(cartItem.id, cartItem);
    }
  }

  void removeFromCart(int id) async {
    final box = await Hive.openBox<CartItem>(_cartBoxName);
    await box.delete(id);
  }
}
