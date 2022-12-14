import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/app_routes.dart';
import 'package:shop_gerenciamento_estado/models/cart.dart';
import 'package:shop_gerenciamento_estado/models/product.dart';

class ProdutctGridItem extends StatelessWidget {
  const ProdutctGridItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      // indica se esta tela irá escutar todas as alterações realizadas em Product.
      // será mantido false pois queremos apenas os dados de product.
      // Faremos o controle da atualização dos dados através do Consumer diretamente no botão
      // de favoritos
      listen: false,
    );

    final cart = Provider.of<Cart>(context, listen: false);

    // ClipRRect corta de forma arredondada um determinado elemento
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        // gesture detector será o responsável por captar o toque
        // ignore: sort_child_properties_last
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productDetail,
              arguments: product,
            );
          },
          // imagem
          child: Image.network(
            product.urlImage,
            fit: BoxFit.cover,
          ),
        ),
        // rodapé (barra escura)
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          // botão favorito
          // o Consumer é o responsável por escutar alterações em Product e refletí-la na tela
          leading: Consumer<Product>(
            // builder possui um parâmetro de contexto, um parâmetro para a variável que é escutada
            // e um terceiro com child (indicado com _ neste exemplo) que pode ser um widget que será
            // incluído no código
            builder: (ctx, product, _) => IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                product.toggleFavorite();
              },
            ),
          ),
          // nome do produto
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          // botão comprar
          trailing: IconButton(
            icon: const Icon(Icons.shopping_bag),
            onPressed: () {
              // retorna o scaffold mais próximo deste local.
              // neste caso ProductOverviewScreen.
              // Neste exemplo estamos abrindo o drawer da tela principal
              //Scaffold.of(context).openDrawer();

              // remove o snackbar anterior
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              // mostra o snakbar (mensagem no rodapé da tela)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} adicionado ao carrinho'),
                  duration: const Duration(seconds: 3),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    textColor: Colors.white,
                    onPressed: () {
                      cart.removeSingleProduct(product);
                    },
                  ),
                ),
              );

              cart.addProduct(product, 1);
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
