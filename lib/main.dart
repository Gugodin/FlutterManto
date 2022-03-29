import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinariamanto/pages/login.dart';
import 'package:veterinariamanto/pages/mascotas.dart';
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
        initialRoute: 'Mascotas',
        routes: {
          '/': (context) => Login(),
          'Medicamentos': (context) => Medicamentos(),
          'Mascotas': (context) => Mascotas(),
        },
      ),
    );
  }
}


// Expanded(
//             child: SizedBox(
//               height: 300,
//               child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, position){
//                 return _cards(width,height);
//               },
//             ),
//             )

//           )
// Widget _cards(double width, double height) {
//   return Card(
//     elevation: 5,

//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     child: Row(
//       children: [

//               Container(
//                 padding: EdgeInsets.only(top:30,left: 30,right: 30),
//                 height: height0.15,
//                 child: const Text('01'),
//               ),
//               Container(
//                 padding: EdgeInsets.only(top:30,left: 30,right: 30),
//                 height: height0.15,
//                 child: const Text('Edgar'),
//               ),
//               Container(
//                 padding: EdgeInsets.only(top:30,left: 30,right: 30),
//                 height: height0.15,
//                 child: const Text('Empleado'),
//               ),
//               Container(
//                 padding: EdgeInsets.only(left:30,top: 30),
//                 height: height0.15,
//                 child: const Text('Edgar'),
//               ),
//       ],
//     ),
//   );
// }

