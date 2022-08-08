import 'package:flutter/material.dart';
import 'package:shop_gerenciamento_estado/models/cart_product.dart';
import 'package:shop_gerenciamento_estado/models/product.dart';

class Cart with ChangeNotifier {
  // id do produto e item do carrinho
  final Map<String, CartProduct> _items = {};

  Map<String, CartProduct> get items {
    return {
      ..._items
    };
  }

  void addProduct(Product product, int newQuantity) {
    // verifica se existe e incrementa quantidade
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (actualProduct) => CartProduct(
          id: actualProduct.id,
          product: product,
          quantity: actualProduct.quantity + newQuantity,
        ),
      );
    } else {
      // insere se não existe.
      _items.putIfAbsent(
        product.id,
        () => CartProduct(
          id: CartProduct.cartItemId,
          product: product,
          quantity: newQuantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeAllProducts(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleProduct(Product product) {
    // verifica se produto está na lista
    if (_items.containsKey(product.id)) {
      if (_items[product.id]?.quantity == 1) {
        _items.remove(product.id);
      } else {
        _items.update(
          product.id,
          (actualProduct) => CartProduct(
            id: actualProduct.id,
            product: product,
            quantity: actualProduct.quantity - 1,
          ),
        );
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int get productsCount {
    return _items.length;
  }

  int get totalQuantityProducts {
    int totalQuantity = 0;
    _items.forEach((key, cartItem) {
      totalQuantity += cartItem.quantity;
    });
    return totalQuantity;
  }

  double get totalAmount {
    double totalAmount = 0;
    _items.forEach((key, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }
}
