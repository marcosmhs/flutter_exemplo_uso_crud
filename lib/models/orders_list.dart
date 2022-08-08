import 'package:flutter/widgets.dart';
import 'package:shop_gerenciamento_estado/models/cart.dart';
import 'package:shop_gerenciamento_estado/models/order.dart';

class OrdersList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [
      ..._items
    ];
  }

  int get ordersCount {
    return _items.length;
  }

  void addOrder({required Cart cart, required bool clearCart}) {
    _items.insert(
      0,
      // como cart.items retorna uma lista de produtos, ela se encaixa com o que queremos para as ordern;
      Order(
        id: Order.orderId,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
      ),
    );

    if (clearCart) {
      cart.clear();
    }

    notifyListeners();
  }
}
