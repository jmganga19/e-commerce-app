import 'package:chat_ai/constants/pallete.dart';
import 'package:chat_ai/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/cart.dart';
import '../providers/cart_provider.dart';
import '../providers/user_provider.dart';
import '../services/order.dart';
import 'custom_text.dart';

class CartBottomNav extends StatefulWidget {
  const CartBottomNav({super.key});

  @override
  State<CartBottomNav> createState() => _CartBottomNavState();
}

class _CartBottomNavState extends State<CartBottomNav> {
  final OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return BottomAppBar(
        child: Container(
            height: 80,
            decoration: const BoxDecoration(color: Pallete.backgroundColor),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Total:',
                        style: TextStyle(fontFamily: 'Cera Pro', fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text('${userProvider.userModel?.totalCartPrice??0}',
                      
                        style: const TextStyle(
                            fontFamily: 'Cera Pro', fontSize: 25),
                      ),
                    ),
                    Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Pallete.greyColor),
                child: TextButton(
                    onPressed: () {
                      if (userProvider.userModel?.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: SizedBox(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const <Widget>[
                                            Text(
                                              'Your cart is emty',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)), //this right here
                              child: SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You will be charged Tsh ${userProvider.userModel?.totalCartPrice} upon delivery!',
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            var uuid = const Uuid();
                                            String id = uuid.v4();
                                            _orderServices.createOrder(
                                                userId: userProvider.user?.uid,
                                                id: id,
                                                description:
                                                    "Some random description",
                                                status: "complete",
                                                totalPrice: userProvider
                                                    .userModel?.totalCartPrice,
                                                cart: userProvider
                                                    .userModel?.cart);
                                            for (CartItemModel cartItem
                                                in userProvider
                                                    .userModel!.cart!) {
                                              bool value = await userProvider
                                                  .removeFromCart(
                                                      cartItem: cartItem);
                                              if (value) {
                                                userProvider.reloadUserModel();

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Removed from Cart!")));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Item was not removed!")));
                                              }
                                            }
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Order Created!")));
                                            Navigator.pop(context);
                                          },
                                          // color: const Color(0xFF1BC0C5),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF1BC0C5)),
                                          child: const Text(
                                            "Accept",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: const Text(
                                            "Reject",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "Check out",
                      size: 20,
                      color:Pallete.whiteColor,
                      weight: FontWeight.normal,
                    )),
              )
                  ],
                )
              ],
            )));
  }
}
