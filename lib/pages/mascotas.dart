import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'package:veterinariamanto/assets/Colors/color.dart';
// import 'package:http/http.dart' as http;

// import 'package:veterinariamanto/providers/sesion_info.dart';
// import '../painter/login_painter.dart';


class Mascotas extends StatefulWidget {
  Mascotas({Key? key}) : super(key: key);

  @override
  State<Mascotas> createState() => _MascotasState();
}

class _MascotasState extends State<Mascotas> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_outlined),
        title: const Text('Vista de mascotas'),
        backgroundColor: ColorSelect.loginBackGround,
      ),
      body: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget> [
            Container(
              color: ColorSelect.barraTipo,
              width: double.infinity,
              height: height * 0.05,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  // const Text('Id'),
                  // const Text('Name'),
                  // const Text('Raza'),
                  // const Text('Fecha ingreso'),
                  // const Text('Razon'),
                  ElevatedButton(
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      print('boton');
                      //AQUI ES DONDE SE HACE LA LLAMADA CON EL BACK
                      // print(user);
                      // print(password);
                      final respuesta = await _callBackend('asd', 'asd');
                        // print(respuesta);
                      if (respuesta == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(("Usuario invalido"))),
                        );
                      } else {
                        // print('Usuario valido se guarda');
                        // loginInfo.saveData(datos: respuesta);
                      }
                    }
                  )
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              width: double.infinity,
              height: height * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView.builder(
                itemCount: 52,
                itemBuilder: (context, position){
                  return _cards(width,height);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future? _callBackend(nombre, password) async {
    Uri url = Uri.http('192.168.1.65:9998', '/listMascotas');
    // Uri url = Uri.http('192.168.1.65:9998', 'user/login');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.body == '') {
      // SI EL BODY VIENE VACIO ES PORQUE EL USUARIO NO EXISTE
      return null;
    } else {
      // SI NO ES PORQUE ENCONTRO EL USUARIO
      final respuesta = json.decode(response.body);
      return respuesta;
    }
  }
}

Widget _cards(double width, double height) {
  return Card(
    color: ColorSelect.colorCard,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.only(top:30,left: 30,right: 30),
          height: height * 0.15,
          child: const Text('01'),
        ),
        Container(
          padding: EdgeInsets.only(top:30,left: 30,right: 30),
          height: height * 0.15,
          child: const Text('Edgar'),
        ),
        Container(
          padding: EdgeInsets.only(top:30,left: 30,right: 30),
          height: height * 0.15,
          child: const Text('Empleado'),
        ),
        Container(
          padding: EdgeInsets.only(left:30,top: 30),
          height: height * 0.15,
          child: const Text('Edgar'),
        ),
      ],
    ),
  );
}
