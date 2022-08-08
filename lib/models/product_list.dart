import 'package:flutter/cupertino.dart';
import 'package:shop_gerenciamento_estado/data/dummy_data.dart';
import 'package:shop_gerenciamento_estado/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  void addProduct(Product product) {
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

  //bool _showOnlyFavorites = false;
  //void showOnlyFavorites() {
  //  _showOnlyFavorites = true;
  //  notifyListeners();
  //}
  //void showAll() {
  //  _showOnlyFavorites = false;
  //  notifyListeners();
  //}
  //// retorna uma referência à lista de produtos, permitindo alteração nos dados base
  ////List<Product> get items => _items;
  //// o [...] realiza uma cópia da variável, o que permite isolamento dos dados base
  //List<Product> get products {
  //  if (_showOnlyFavorites) {
  //    return _products.where((p) => p.isFavorite).toList();
  //  }
  //  return [
  //    ..._products
  //  ];
  //}
}
