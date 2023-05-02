import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart.dart';
import '../models/user.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "users";

  void createUser(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(data["uid"]).set(data);
      print('USER WAS CREATED');
    } catch (e) {
      print('ERROR:${e.toString()}');
    }
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        print(doc.data());
        return UserModel.fromSnapshot(doc);
      });

  void addTocart({String? userId, CartItemModel? cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem!.toMap()])
    });
  }

  void removeItemFromcart({String? userId, CartItemModel? cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem!.toMap()])
    });
  }
}
