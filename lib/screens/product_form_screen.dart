import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_gerenciamento_estado/components/util/snackbar_message.dart';
import 'package:shop_gerenciamento_estado/models/product.dart';
import 'package:shop_gerenciamento_estado/models/product_list.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({Key? key}) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  // utilizado para o controle de foco
  final _descriptionFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final imageUrlController = TextEditingController();

  // formKey irá ajudar a controlar o estado do form
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateUrlImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments != null) {
        Product product = arguments as Product;

        _formData["id"] = product.id;
        _formData["name"] = product.name;
        _formData["description"] = product.description;
        _formData["price"] = product.price;
        _formData["urlImage"] = product.urlImage;

        // força a execução do controller e preenchimento da imagem
        imageUrlController.text = product.urlImage;
      }
    }
  }

  // libera recursos da tela quando ela é fechada
  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateUrlImage);
    _imageUrlFocus.dispose();
  }

  void updateUrlImage() {
    setState(() {});
  }

  dynamic _validator({required ProductEnum field, required String? value}) {
    // ao retornar null campo foi validado com sucesso
    // se retornar alguma mensagem essa mensagem será considerada um erro
    if (field == ProductEnum.name) {
      if ((value ?? '').trim().isEmpty) {
        return 'Informe o nome do produto';
      } else if ((value ?? '').trim().length < 3) {
        return 'Nome deve ter mais de 3 caracteres';
      }
      return null;
    } else if (field == ProductEnum.description) {
      if ((value ?? '').trim().isEmpty) {
        return 'Informe a descrição do produto';
      } else if ((value ?? '').trim().length < 3) {
        return 'A descrição deve ter mais de 3 caracteres';
      }
      return null;
    } else if (field == ProductEnum.price) {
      if ((value ?? '').trim().isEmpty || double.tryParse(value ?? '0') == 0) {
        return 'Informe o valor do produto';
      }
      return null;
    } else if (field == ProductEnum.urlImage) {
      if ((value ?? '').trim().isEmpty) {
        return 'Informe a URL do produto';
      } else if (!(Uri.tryParse(value!)?.hasAbsolutePath ?? false)) {
        return 'A URL é inválida';
      }
      return null;
    }
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    final String msg;
    bool sucess = false;

    if (!isValid) {
      msg = 'Erros foram encontrados';
    } else {
      _formKey.currentState?.save();
      // listen deve ser false pois ele está fora do método build.
      Provider.of<ProductList>(context, listen: false).saveProduct(data: _formData);
      // vamos tirar agora a tela de produto da pilha, para que ele retorne para a tela de lista
      Navigator.of(context).pop();
      msg = '${_formData['name']} salvo com sucesso';
      sucess = true;
    }

    SnackBarMessage(
      context: context,
      iconImage: sucess ? Icons.info : Icons.error,
      messageText: msg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário de produtos')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                // valor inicial do campo, só será prenchido quando for edição.
                // método didChangeDependencies é executado no carregamento da tela.
                initialValue: _formData['name']?.toString(),
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                // informa qual focusNode deve ser ativado
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocus),
                // indica que _formData['name'] deve receber name ou '' se for nulo
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (value) => _validator(field: ProductEnum.name, value: value),
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: const InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                // informa quantidade de linhas que serão liberadas para digitação
                maxLines: 3,
                // indica qual o focusNode do componente
                focusNode: _descriptionFocus,
                // informa qual focusNode deve ser ativado
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocus),
                onSaved: (value) => _formData['description'] = value ?? '',
                validator: (value) => _validator(field: ProductEnum.description, value: value),
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                // indica qual o focusNode do componente
                focusNode: _priceFocus,
                // informa qual focusNode deve ser ativado
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_imageUrlFocus),
                onSaved: (value) => _formData['price'] = double.parse(value ?? '0'),
                validator: (value) => _validator(field: ProductEnum.price, value: value),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      //initialValue: _formData['urlImage']?.toString(),
                      decoration: const InputDecoration(labelText: 'Url Imagem'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      // indica qual o focusNode do componente
                      focusNode: _imageUrlFocus,
                      controller: imageUrlController,
                      onSaved: (value) => _formData['urlImage'] = value ?? '',
                      onFieldSubmitted: (_) => _submitForm(),
                      validator: (value) => _validator(field: ProductEnum.urlImage, value: value),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.purple,
                      width: 1,
                    )),
                    alignment: Alignment.center,
                    child: imageUrlController.text.isEmpty
                        ? const Text("Infome a URL")
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(imageUrlController.text),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => _submitForm(),
        child: const Icon(Icons.save),
      ),
    );
  }
}
