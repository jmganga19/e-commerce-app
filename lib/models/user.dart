import 'package:chat_ai/models/cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = 'uid';
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const STRIPE_ID = 'stripeId';
  static const CART = 'cart';

  String? _name;
  String? _email;
  String? _stripeId;
  String? _id;
  int _priceSum = 0;

  //getters
  String? get name => _name;
  String? get email => _email;
  String? get stripeId => _stripeId;
  String? get id => _id;

  List<CartItemModel>? cart;
  int? totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.get(NAME);
    _email = snapshot.get(EMAIL);
    _stripeId = snapshot.get(STRIPE_ID) ?? "";
    _id = snapshot.get(ID);
    cart = _convertCartItem(snapshot.get(CART) ?? []);
    _convertCartItem(snapshot.get(CART) ?? []);
    totalCartPrice = snapshot.get(CART) == null
        ? 0
        : getTotalPrice(cart: snapshot.get(CART));
  }

  List<CartItemModel> _convertCartItem(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  int getTotalPrice({List? cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      int temp = cartItem["price"];
      _priceSum += temp;
    }

    int total = _priceSum;
    return total;
  }
}
