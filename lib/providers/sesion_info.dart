import 'package:flutter/material.dart';

class SesionInfo with ChangeNotifier {
  int id = 0;

  String token = '';

  void saveData({required List<dynamic> datos}) {
    token = datos[1].toString();
    id = datos[0];
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 6000000), () {
      id = 0;
      token = '';
    });
  }
}
