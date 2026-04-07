import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/models/Product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }

      _isInit = false;
    }
  }

  @override
  void dispose() {
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void updateImage() {
    if (_imageUrlFocus.hasFocus) {
      return;
    }
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['title']?.toString(),
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onSaved: (title) => _formData['title'] = title ?? '',
                validator: (_title) {
                  final title = _title ?? '';

                  if (title.trim().isEmpty) {
                    return 'Nome obrigatório';
                  }

                  if (title.trim().length < 4) {
                    return 'Nome inválido, é preciso ter 4 ou mais caracteres';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSaved: (price) {
                  _formData['price'] = double.tryParse(price ?? '0') ?? 0.0;
                },
                validator: (price) {
                  final priceValue = double.tryParse(price ?? '');

                  if (price == null || price.trim().isEmpty) {
                    return 'Preço obrigatório';
                  }

                  if (priceValue == null) {
                    return 'Informe um preço válido';
                  }

                  if (priceValue <= 0) {
                    return 'Informe um preço maior que zero';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: const InputDecoration(labelText: 'Descrição'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                validator: (description) {
                  final desc = description ?? '';

                  if (desc.trim().isEmpty) {
                    return 'Descrição obrigatória';
                  }

                  if (desc.trim().length < 10) {
                    return 'Descrição deve ter pelo menos 10 caracteres';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'URL da imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocus,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                      validator: (imageUrl) {
                        final url = imageUrl ?? '';

                        if (url.trim().isEmpty) {
                          return 'URL obrigatória';
                        }

                        final isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
                        final hasValidImageExtension = url.endsWith('.png') ||
                            url.endsWith('.jpg') ||
                            url.endsWith('.jpeg');

                        if (!isValidUrl || !hasValidImageExtension) {
                          return 'Informe uma URL válida';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a Url')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlController.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}