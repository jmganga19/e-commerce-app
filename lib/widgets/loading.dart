import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/pallete.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.whiteColor,
      child: const SpinKitFadingCircle(color: Pallete.blackColor, size: 30),
    );
  }
}
