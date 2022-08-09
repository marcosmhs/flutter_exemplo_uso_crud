import 'package:flutter/material.dart';
import 'package:shop_gerenciamento_estado/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem Vindo'),
            // remove o botão do drawer quando ele está aberto
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.orders),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.mode_edit),
            title: const Text('Gerenciar Produtos'),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.products),
          ),
        ],
      ),
    );
  }
}
