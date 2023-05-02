// import 'package:flutter/material.dart';

// class ColorSizeButton extends StatefulWidget {
 
//   final int color;
//   final Function onPressed;

//   const ColorSizeButton({
//     Key? key,
   
//     required this.color,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   _ColorSizeButtonState createState() => _ColorSizeButtonState();
// }

// class _ColorSizeButtonState extends State<ColorSizeButton> {
//   bool _isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _isSelected = !_isSelected;
//         });
//         widget.onPressed();
//       },
//       child: Container(
//         margin: const EdgeInsets.only(right: 10.0),
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           color: _isSelected ? Colors.red : Colors.white,
//           borderRadius: BorderRadius.circular(30.0),
//           border: Border.all(color: Colors.grey),
//         ),
       
//       ),
//     );
//   }
// }
