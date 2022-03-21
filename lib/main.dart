import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinariamanto/pages/login.dart';
import 'package:veterinariamanto/providers/sesion_info.dart';

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
        },
      ),
    );
  }
}
