import 'package:flutter/material.dart';

class SesionInfo with ChangeNotifier {
  int id = 0;

  String token = '';
  String rol = '';

  void saveData({required List<dynamic> datos}) {
    id = datos[0];
    token = datos[1].toString();
    rol = datos[2];
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 6000000), () {
      id = 0;
      token = '';
      rol =  '';
      notifyListeners();
    });
  }
}
