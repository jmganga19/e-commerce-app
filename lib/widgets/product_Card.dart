import 'package:chat_ai/constants/navigation.dart';
import 'package:chat_ai/models/product_model.dart';
import 'package:chat_ai/screens/details.dart';
import 'package:flutter/material.dart';

import '../constants/pallete.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFFD9D9D9)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              changeScreen(context, ProductDetails(product: product));
            },
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
                child: Image.network(
                  product.images ?? Pallete.imagePlaceholder,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: const TextStyle(fontFamily: 'Cera Pro', fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Tsh ${product.price}',
                  style: const TextStyle(fontFamily: 'Cera Pro', fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.shopping_cart,
                            color: Pallete.buttonColor)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
