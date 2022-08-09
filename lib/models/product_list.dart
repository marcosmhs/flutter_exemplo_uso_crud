import 'package:flutter/material.dart';
import 'package:shop_gerenciamento_estado/data/dummy_data.dart';
import 'package:shop_gerenciamento_estado/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  void saveProduct({required Map<String, Object> data}) {
    final product = Product(
      // se o id não foi informado deve ser gerado um novo, se ele está presende deve ser usado
      id: data['id'] == null ? Product.productNewId : data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      urlImage: data['urlImage'] as String,
    );
    if (data['id'] == null) {
      _addProduct(product: product);
    } else {
      _updateProduct(product: product);
    }
  }

  void removeProduct(Product product) {
    int index = _products.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _products.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  void _updateProduct({required Product product}) {
    int index = _products.indexWhere((p) => p.id == product.id);
    // se encontrou algum index com o produto (0 ou mais) substitui ele na lista pelo
    // produto que foi informado.
    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void _addProduct({required Product product}) {
    _products.add(product);
    // retorna à todos os que estão ouvindo esta classe sejam notificados
    notifyListeners();
  }

  List<Product> get favoriteProducts => [
        ...products.where((p) => p.isFavorite)
      ];

  List<Product> get products => [
        ..._products
      ];

  int get itemsCount {
    return _products.length;
  }
}
