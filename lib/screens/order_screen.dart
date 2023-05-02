import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../constants/pallete.dart';
import '../models/order_model.dart';
import '../providers/app_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_text.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Pallete.blackColor),
        backgroundColor: Pallete.whiteColor,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
       
      ),
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index){
            OrderModel _order = user.orders[index];
            return ListTile(
              leading: CustomText(
                text: "\Tsh ${_order.total }",
                weight: FontWeight.bold,
              ),
              title: Text(_order.description!),
              subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_order.createdAt!).toString()),
              trailing: CustomText(text: _order.status!, color: Colors.green,),
            );
          }),
    );
  }
}