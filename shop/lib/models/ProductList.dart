import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/Product.dart';

class ProductList with ChangeNotifier {
  final String _baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8080/products'
      : 'http://localhost:8080/products';

  List<Product> _items = [];
  bool _showFavoriteOnly = false;

  List<Product> get items => _showFavoriteOnly
      ? _items.where((prod) => prod.isFavorite).toList()
      : [..._items];

  int get itemsCount {
    return _items.length;
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode >= 400) {
      throw Exception('Erro ao carregar produtos.');
    }

    final List<dynamic> data = jsonDecode(response.body);

    _items = data.map((item) {
      return Product(
        id: item['id'],
        title: item['title'],
        description: item['description'],
        price: (item['price'] as num).toDouble(),
        imageUrl: item['imageUrl'],
        isFavorite: item['isFavorite'] ?? false,
      );
    }).toList();

    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) async {
    final bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : '',
      title: data['title'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      await updateProduct(product);
    } else {
      await addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception('Erro ao adicionar produto.');
    }

    final data = jsonDecode(response.body);

    final newProduct = Product(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'],
      isFavorite: data['isFavorite'] ?? false,
    );

    _items.add(newProduct);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index < 0) return;

    final response = await http.put(
      Uri.parse('$_baseUrl/${product.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception('Erro ao atualizar produto.');
    }

    final data = jsonDecode(response.body);

    _items[index] = Product(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'],
      isFavorite: data['isFavorite'] ?? false,
    );

    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index < 0) return;

    final removedProduct = _items[index];

    _items.removeAt(index);
    notifyListeners();

    final response = await http.delete(
      Uri.parse('$_baseUrl/${product.id}'),
    );

    if (response.statusCode >= 400) {
      _items.insert(index, removedProduct);
      notifyListeners();
      throw Exception('Erro ao deletar produto.');
    }
  }

  Future<void> updateFavorite(Product product) async {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index < 0) return;

    final bool newFavoriteValue = !product.isFavorite;

    final response = await http.patch(
      Uri.parse('$_baseUrl/${product.id}/favorite'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'isFavorite': newFavoriteValue,
      }),
    );

    if (response.statusCode >= 400) {
      throw Exception('Erro ao atualizar favorito.');
    }

    final data = jsonDecode(response.body);

    _items[index] = Product(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'],
      isFavorite: data['isFavorite'] ?? false,
    );

    notifyListeners();
  }
}