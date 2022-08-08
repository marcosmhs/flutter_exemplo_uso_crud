import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/app_routes.dart';
import 'package:shop_gerenciamento_estado/components/product_widget.dart';
import 'package:shop_gerenciamento_estado/models/orders_list.dart';

import '../models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: Column(
        children: [
          cartResume(context, cart),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) => ProductWidget(cartProduct: items[index]),
            ),
          ),
          cartResume(context, cart),
        ],
      ),
    );
  }

  // o resumo do carrinho fica melhor como uma função para que possa
  // ser colocada no começo e no final da lista de produtos
  Card cartResume(BuildContext context, Cart cart) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 10),
            Chip(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(
                'R\$${cart.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline6?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                // transformação do carrinho em um pedido
                Provider.of<OrdersList>(context, listen: false).addOrder(
                  cart: cart,
                  clearCart: true,
                );
                // limpa a pilha de telas e retorna para a tela inicial
                Navigator.restorablePushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
              child: const Text("Finalizar Compra"),
            )
          ],
        ),
      ),
    );
  }
}
