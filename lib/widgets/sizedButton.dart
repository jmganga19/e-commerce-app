import 'package:flutter/material.dart';

class SizeButton extends StatefulWidget {
  final String size;

  const SizeButton({required this.size});

  @override
  _SizeButtonState createState() => _SizeButtonState();
}

class _SizeButtonState extends State<SizeButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: _isSelected ? Colors.red : Colors.grey[200],
          border: Border.all(
            width: 1.0,
            color: Colors.grey[300]!,
          ),
        ),
        child: Center(
          child: Text(
            widget.size,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Cera Pro',
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
