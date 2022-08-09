import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/app_routes.dart';
import 'package:shop_gerenciamento_estado/components/util/custom_dialog.dart';
import 'package:shop_gerenciamento_estado/components/util/snackbar_message.dart';
import 'package:shop_gerenciamento_estado/models/product.dart';
import 'package:shop_gerenciamento_estado/models/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      elevation: 1,
      child: ListTile(
        leading: SizedBox(
          width: 90,
          height: 90,
          child: Image.network(
            product.urlImage,
            alignment: Alignment.center,
          ),
        ),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.productForm, arguments: product);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => CustomDialog(context).confirmationDialog(message: 'Confirma a exclusão do produto?', yesButtonHighlight: true).then((confirmed) {
                  if (confirmed ?? false) {
                    Provider.of<ProductList>(context, listen: false).removeProduct(product);
                    SnackBarMessage(
                      context: context,
                      iconImage: Icons.check_circle_outline,
                      messageText: 'Exclusão realizada',
                    );
                  } else {
                    SnackBarMessage(
                      context: context,
                      iconImage: Icons.cancel_outlined,
                      messageText: 'Exclusão cancelada',
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
