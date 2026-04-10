import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/models/ProductList.dart';

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

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    );
  }

  Widget _buildImagePreview(bool isDesktop) {
    return Container(
      height: isDesktop ? 220 : 100,
      width: isDesktop ? 220 : 100,
      margin: const EdgeInsets.only(top: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: _imageUrlController.text.isEmpty
          ? const Text(
              'Informe a Url',
              textAlign: TextAlign.center,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                _imageUrlController.text,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
    );
  }

  Widget _buildFormFields(bool isDesktop) {
    return Column(
      children: [
        TextFormField(
          initialValue: _formData['title']?.toString(),
          decoration: _buildInputDecoration('Nome'),
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
        const SizedBox(height: 20),
        TextFormField(
          initialValue: _formData['price']?.toString(),
          decoration: _buildInputDecoration('Preço'),
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
        const SizedBox(height: 20),
        TextFormField(
          initialValue: _formData['description']?.toString(),
          decoration: _buildInputDecoration('Descrição'),
          keyboardType: TextInputType.multiline,
          maxLines: isDesktop ? 5 : 3,
          onSaved: (description) => _formData['description'] = description ?? '',
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
        const SizedBox(height: 20),
if (isDesktop) ...[
  TextFormField(
    decoration: _buildInputDecoration('URL da imagem'),
    keyboardType: TextInputType.url,
    textInputAction: TextInputAction.done,
    controller: _imageUrlController,
    focusNode: _imageUrlFocus,
    onFieldSubmitted: (_) => _submitForm(),
    onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
    validator: (imageUrl) {
      final url = imageUrl ?? '';

      if (url.trim().isEmpty) {
        return 'URL obrigatória';
      }

      final isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
      final hasValidImageExtension =
          url.endsWith('.png') ||
          url.endsWith('.jpg') ||
          url.endsWith('.jpeg');

      if (!isValidUrl || !hasValidImageExtension) {
        return 'Informe uma URL válida';
      }

      return null;
    },
  ),

  const SizedBox(height: 20),

  Center(
    child: _buildImagePreview(true),
  ),
      ] else ...[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                decoration: _buildInputDecoration('URL da imagem'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageUrlController,
                focusNode: _imageUrlFocus,
                onFieldSubmitted: (_) => _submitForm(),
                onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                validator: (imageUrl) {
                  final url = imageUrl ?? '';

                  if (url.trim().isEmpty) {
                    return 'URL obrigatória';
                  }

                  final isValidUrl =
                      Uri.tryParse(url)?.hasAbsolutePath ?? false;
                  final hasValidImageExtension =
                      url.endsWith('.png') ||
                      url.endsWith('.jpg') ||
                      url.endsWith('.jpeg');

                  if (!isValidUrl || !hasValidImageExtension) {
                    return 'Informe uma URL válida';
                  }

                  return null;
                },
              ),
            ),
            _buildImagePreview(false),
          ],
        ),
      ],
      ],
    );
  }

  Widget _buildMobileBody() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _buildFormFields(false),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopBody() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Formulário de Produto',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Preencha os dados do produto abaixo.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildFormFields(true),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Salvar Produto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: isDesktop
            ? []
            : [
                IconButton(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.save),
                ),
              ],
      ),
      body: isDesktop ? _buildDesktopBody() : _buildMobileBody(),
    );
  }
}