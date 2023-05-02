import 'package:flutter/material.dart';
class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}
class _CartCounterState extends State<CartCounter> {
  int numbOfItem = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlineButton(
            icon: Icons.remove,
            press: () {
              if (numbOfItem > 1) {
                setState(() {
                  numbOfItem--;
                });
              }
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            //if item is less that 10 then it show 01 02 ....
            numbOfItem.toString().padLeft(2, '0'),
            style: const TextStyle(fontFamily: 'Cera Pro', fontSize: 18),
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numbOfItem++;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData? icon, void Function()? press}) {
    return SizedBox(
        height: 32,
        width: 40,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13))),
          onPressed: press,
          child: Icon(icon),
        ));
  }
}
