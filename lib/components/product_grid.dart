import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/components/product_item.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFavorites;
  // ignore: use_key_in_widget_constructors
  const ProductGrid({required this.showOnlyFavorites});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    final List<Product> loadedProducts = showOnlyFavorites ? provider.favoriteProducts : provider.products;
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // eixo vertical
        crossAxisCount: 2,
        // aspecto na divisão de altora e largura
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        // passagem do dado para o provider
        value: loadedProducts[index],
        child: const ProdutctItem(),
      ),
    );
  }
}
