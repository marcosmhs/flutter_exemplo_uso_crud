import 'package:flutter/material.dart';
import 'package:shop_gerenciamento_estado/components/app_drawer.dart';
import 'package:shop_gerenciamento_estado/components/cart/cart_button.dart';
import '../components/product_grid/product_grid.dart';

enum FilterOptions { all, onlyFavorites }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Minha Loja")),
        actions: [
          const CartButton(),
          // menu lateral
          PopupMenuButton(
            icon: const Icon(Icons.more_horiz_sharp),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                _showOnlyFavorites = selectedValue == FilterOptions.onlyFavorites;
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.all,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.apps_rounded, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 5),
                    const Text('Todos', textAlign: TextAlign.left),
                  ],
                ),
              ),
              PopupMenuItem(
                value: FilterOptions.onlyFavorites,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.favorite_border_rounded, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 5),
                    const Text('Somente favoritos', textAlign: TextAlign.left),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      body: ProductGrid(showOnlyFavorites: _showOnlyFavorites),
      drawer: const AppDrawer(),
    );
  }
}
