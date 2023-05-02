import 'package:chat_ai/providers/cart_provider.dart';
import 'package:chat_ai/services/order.dart';
import 'package:chat_ai/widgets/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/pallete.dart';
import '../providers/app_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/cart_bottom_navbar.dart';
import '../widgets/cart_counter.dart';
import '../widgets/loading.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  final OrderServices _orderServices = OrderServices();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Cart',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Cera Pro',
                    fontWeight: FontWeight.bold)),
            // Text('(${data.myCartItems.length})')
          ],
        ),
      ),
      body: appProvider.isLoading
          ? const Loading()
          : ListView.builder(
              itemCount: userProvider.userModel?.cart?.length??0,
              itemBuilder: (context, index) {
                return Card(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 180,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFBC901D),
                          image: DecorationImage(
                              image: NetworkImage(userProvider
                                      .userModel!.cart![index].picture ??
                                  Pallete.imagePlaceholder))),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              userProvider.userModel!.cart![index].name!,
                              style: const TextStyle(
                                  color: Pallete.blackColor,
                                  fontSize: 20,
                                  fontFamily: 'Cera Pro',
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(' ${userProvider.userModel!.cart![index].price}',
                            style: const TextStyle(
                              color: Pallete.textColor,
                              fontSize: 18,
                              fontFamily: 'Cera Pro',
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'L',
                              style: TextStyle(
                                color: Pallete.blackColor,
                                fontFamily: 'Cera Pro',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CartCounter(),
                      ],
                    ),
                    IconButton(
                        onPressed: () async {
                          appProvider.changeIsLoading();
                          bool success = await userProvider.removeFromCart(
                              cartItem: userProvider.userModel!.cart![index]);

                          if (success) {
                            userProvider.reloadUserModel();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Item removed from cart')));
                            appProvider.changeIsLoading();

                            return;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Failed to add item to cart')));
                            appProvider.changeIsLoading();
                            return;
                          }
                        },
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                          size: 50,
                        ))
                  ],
                ));
              }),
      bottomNavigationBar: const CartBottomNav(),
    );
  }
}
