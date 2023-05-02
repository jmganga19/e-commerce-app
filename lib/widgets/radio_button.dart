import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? allText;

  CustomRadioButton({
    required this.value,
    required this.onChanged,
    this.allText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Radio<bool?>(
            value: value,
            groupValue: true,
            onChanged: (bool? newValue) => onChanged(newValue),
          ),
          allText != null
              ? Text(allText!)
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
