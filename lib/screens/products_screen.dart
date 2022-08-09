import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/app_routes.dart';
import 'package:shop_gerenciamento_estado/components/app_drawer.dart';
import 'package:shop_gerenciamento_estado/components/product_item.dart';
import 'package:shop_gerenciamento_estado/models/product_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (cti, index) => ProductItem(product: products.products[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.productForm),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
