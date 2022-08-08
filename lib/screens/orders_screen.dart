import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/components/app_drawer.dart';
import 'package:shop_gerenciamento_estado/components/order_item_widget.dart';
import 'package:shop_gerenciamento_estado/models/orders_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrdersList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Meus Pedidos")),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, index) => OrderItemWidget(order: orders.items[index]),
      ),
    );
  }
}
