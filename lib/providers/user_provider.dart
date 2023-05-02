import 'dart:async';
import 'package:uuid/uuid.dart';

import '../models/cart.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../services/order.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  BuildContext? context;
  final FirebaseAuth _auth;
  User? _user  ;
  Status _status = Status.Uninitialized;
  UserModel? _userModel;
 OrderServices _orderServices = OrderServices();
 List<OrderModel> orders = [];
  final UserServices _userServices = UserServices();

  //getter
  Status get status => _status;
  User? get user => _user;
  UserModel? get userModel => _userModel;

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _userModel = await _userServices.getUserById(value.user!.uid);
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;

      notifyListeners();
      print(e.toString());

      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        _userServices.createUser({
          'name': name,
          'email': email,
          'uid': user.user!.uid,
          'stripeId': ''
        });
       // _userModel = await _userServices.getUserById(user.user!.uid);
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;

      notifyListeners();
      print(e.toString());

      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User? user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      // _userModel = await _userServices.getUserById(_user!.uid);
      // print('Cart Item are:${userModel!.cart?.length ?? 0}');
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> addToCart(
      {ProductModel? product, String? size, String? color}) async {
    try {
      var uuid = const Uuid();
      String cartItemId = uuid.v4();
      // List<CartItemModel> cart = _userModel!.cart!;

      Map cartItem = {
        "id": cartItemId,
        "name": product!.name!,
        "images": product.images!,
        "productId": product.id,
        "price": product.price,
        "size": size,
        "color": color,
        //"quantity":quantity?? '01',
      };
      CartItemModel item = CartItemModel.fromMap(cartItem);

      _userServices.addTocart(userId: _user!.uid, cartItem: item);
      return true;
    } catch (e) {
      print('THE ERROR ${e.toString()}');
      return false;
    }
  }

  Future<bool> removeFromCart({CartItemModel? cartItem}) async {
    print("THE PRODUCT IS: ${cartItem.toString()}");

    try {
      _userServices.removeItemFromcart(userId: _user!.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user!.uid);
    notifyListeners();
  }


   getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user!.uid);
    notifyListeners();
  }
}
