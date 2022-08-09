import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/app_routes.dart';
import 'package:shop_gerenciamento_estado/models/orders_list.dart';
import 'package:shop_gerenciamento_estado/models/product_list.dart';
import 'package:shop_gerenciamento_estado/my_theme.dart';
import 'package:shop_gerenciamento_estado/screens/cart_screen.dart';
import 'package:shop_gerenciamento_estado/screens/orders_screen.dart';
import 'package:shop_gerenciamento_estado/screens/product_detail_screen.dart';
import 'package:shop_gerenciamento_estado/screens/product_form_screen.dart';
import 'package:shop_gerenciamento_estado/screens/products_screen.dart';
import 'package:shop_gerenciamento_estado/screens/products_overview_screen.dart';
import 'package:shop_gerenciamento_estado/screens/screen_not_found.dart';

import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrdersList())
      ],
      child: MaterialApp(
        title: 'Store Demo',
        theme: MyTheme.theme,
        // remove o indicador de debug na tela
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.home: (ctx) => const ProductsOverviewScreen(),
          AppRoutes.productDetail: (ctx) => const ProductDetailScreen(),
          AppRoutes.cart: (ctx) => const CartScreen(),
          AppRoutes.orders: (ctx) => const OrdersScreen(),
          AppRoutes.products: (ctx) => const ProductsScreen(),
          AppRoutes.productForm: (ctx) => const ProductFormScreen(),
          //AppRoutes.productDetail: (ctx) => const CounterPage()
        },
        initialRoute: AppRoutes.home,
        // Executado quando uma tela não é encontrada
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) {
            return ScreenNotFound(settings.name.toString());
          });
        },
      ),
    );
  }
}
