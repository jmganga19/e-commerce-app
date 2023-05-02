import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool isLoading = false;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
