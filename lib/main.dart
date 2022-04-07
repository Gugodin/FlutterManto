import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinariamanto/pages/editPet.dart';
import 'package:veterinariamanto/pages/editarDuenio.dart';
import 'package:veterinariamanto/pages/login.dart';
import 'package:veterinariamanto/pages/mascotas.dart';
import 'package:veterinariamanto/pages/registro.dart';
import 'package:veterinariamanto/providers/sesion_info.dart';
import 'package:veterinariamanto/pages/medicamentos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SesionInfo>(
          create: (context) => SesionInfo(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          'Medicamentos': (context) => Medicamentos(),
          'duenios': (_) => const duenios(),
          'edit_duenios': (_) => const edit_duenio(),
          'Mascotas': (_) => const Mascotas(),
          'EditPet': (_) => const EditPet(),
        },
      ),
    );
  }
}
