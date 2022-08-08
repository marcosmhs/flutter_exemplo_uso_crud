import 'dart:math';

import 'package:shop_gerenciamento_estado/models/cart_product.dart';

class Order {
  final String id;
  final double total;
  final List<CartProduct> products;
  late DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
  }) {
    date = DateTime.now();
  }

  static String get orderId {
    return 'or${Random().nextDouble().toString()}';
  }
}
