import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/Dummy_data.dart';
import 'package:shop/models/Product.dart';

class ProductList with ChangeNotifier {
  final List <Product> _items = dammyProducts;
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

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;


    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['title'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if(hasId) {
      updateProduct(newProduct);
    } else {
    addProduct(newProduct);
    }
  }

    void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

    void deleteProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}