import 'package:chat_ai/constants/pallete.dart';
import 'package:flutter/cupertino.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key, required this.categoryName, required this.isSelected});

  final String categoryName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? Pallete.buttonColor : Pallete.greyColor,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13),
        child: Text(
          categoryName,
          style: TextStyle(
              fontFamily: 'Cera Pro',
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Pallete.whiteColor : const Color(0xFF555252)),
        ),
      ),
    );
  }
}
