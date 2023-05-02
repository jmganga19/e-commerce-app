import 'package:chat_ai/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> myCartItems = [];
  int price = 0;

  void addTocart(ProductModel product) {
    myCartItems.add(product);
    print(myCartItems);
    notifyListeners();
  }

  void removeTocart(ProductModel product) {
    myCartItems.remove(product);
    notifyListeners();
  }

  Future<List<ProductModel>> getCartItems() async {
    await Future.delayed(const Duration(seconds: 10)); // delay for 2 seconds
    return myCartItems; // return the list of cart items
  }

  Future<int> calculateTotal() async {
    await Future.delayed(const Duration(seconds: 10));
    for (var i = 0; i < myCartItems.length; i++) {
      // int data =int.parse(myCartItems[i].price);
      // price += data;
    }
    print(price);
    notifyListeners();
    return price;
  }
}
