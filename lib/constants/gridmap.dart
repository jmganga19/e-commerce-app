// import 'dart:convert';

// import 'package:flutter/material.dart';

// import '../models/product_model.dart';

// final List<Map<String, dynamic>> gridmap = [
//   {
//     'productName': 'Rolex Watch',
//     'price': '15000',
//     'productImage': 'assets/images/2.png',
//     'sizes': ['Small', 'Medium', 'Large'],
//     'colors': [Colors.blue.value, Colors.white.value,Colors.black.value],
//   },
//   {
//     'productName': 'LV Bag',
//     'price': '20000',
//     'productImage': 'assets/images/4.png',
//     'sizes': ['One Size'],
//     'colors': [Colors.red.value, Colors.black.value],
//   },
//   {
//     'productName': 'High Hills',
//     'price': '14000',
//     'productImage': 'assets/images/1.png',
//     'sizes': ['US 5', 'US 6', 'US 7'],
//     'colors': [Colors.blue.value, Colors.black.value],
//   },
//   {
//     'productName': 'Laptop bag',
//     'price': '17000',
//     'productImage': 'assets/images/3.png',
//     'sizes': ['Small', 'Medium', 'Large'],
//     'colors': [Colors.grey.value, Colors.black.value],
//   }
// ];

// List<ProductModel> products = gridmap.map((productMap) =>
//   ProductModel(
//     productName: productMap['productName'],
//     price: productMap['price'],
//     productImage: productMap['productImage'],
//     sizes: List<String>.from(productMap['sizes']),
//     colors: List<int>.from(productMap['colors']),
//   ),
// ).toList();

