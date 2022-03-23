import 'package:flutter/material.dart';

class Medicamentos extends StatefulWidget {
  Medicamentos({Key? key}) : super(key: key);

  @override
  State<Medicamentos> createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Regístrate'),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Container(
            padding: const EdgeInsets.only(left: 90),
            height: 60,
            width: 170,
            child: Image.asset('assets/images/splash.png'),
          )
        ],
        backgroundColor: Colors.blue,
      ),
    );

  }
}