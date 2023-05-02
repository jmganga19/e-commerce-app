import 'package:chat_ai/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/pallete.dart';
import '../providers/app_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/loading.dart';
import '../widgets/sizedButton.dart';
import 'cart_screen.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(
          widget.product.name!,
          style: const TextStyle(fontFamily: 'Cera Pro', fontSize: 23),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()
                        )
                        );
              },
              icon: const Icon(Icons.shopping_cart_checkout,
                  color: Pallete.buttonColor))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            widget.product.images ?? Pallete.imagePlaceholder),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name!,
                    style: const TextStyle(
                        fontFamily: 'Cera Pro',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tsh ${widget.product.price}',
                    style: const TextStyle(
                        fontFamily: 'Cera Pro',
                        fontSize: 16,
                        color: Color(0xFF595757),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Size',
                style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: widget.product.sizes!.isNotEmpty
                    ? [
                        SizedBox(
                          height: 28.0,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.sizes!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final size = widget.product.sizes![index];
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 0.0 : 8.0),
                                  child: SizeButton(size: size));
                            },
                          ),
                        ),
                      ]
                    : [],
              ),
              //  const SizedBox(height: 30),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
              onPressed: () async {
                appProvider.changeIsLoading();
                bool success = await userProvider.addToCart(
                  product: widget.product,
                  size: 'L',
                  color: 'blue',
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item added to cart')));
                  userProvider.reloadUserModel();
                  appProvider.changeIsLoading();

                  return;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Failed to add item to cart')));
                  appProvider.changeIsLoading();
                  return;
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.buttonColor),
              child: appProvider.isLoading
                  ? const Loading()
                  : const Text('Add to cart',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          fontSize: 20,
                          color: Colors.white)))
        ],
      ),
    );
  }
}
