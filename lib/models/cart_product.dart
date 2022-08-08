import 'dart:math';

import 'package:shop_gerenciamento_estado/models/product.dart';

class CartProduct {
  final String id;
  late final String productId;
  late final String productName;
  late final double productPrice;
  late final String productUrlImage;
  final int quantity;

  CartProduct({
    required this.id,
    required Product product,
    required this.quantity,
  }) {
    productId = product.id;
    productName = product.name;
    productPrice = product.price;
    productUrlImage = product.urlImage;
  }

  static String get cartItemId {
    return 'ci${Random().nextDouble().toString()}';
  }
}
