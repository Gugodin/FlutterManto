import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';
import 'package:http/http.dart' as http;


class Medicamentos extends StatefulWidget {
  const Medicamentos({Key? key}) : super(key: key);

  @override
  State<Medicamentos> createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {

  final List<DatosMedicamentos> _datosMedicamentos = [
    // DatosMedicamentos("Paracetamol", "10-05-2023", 200)
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
  ];
  
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Medicamentos'),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Container(
            padding: const EdgeInsets.only(left: 90),
            height: 60,
            width: 170,
            child: Image.asset('lib/assets/mascotas_logo.png'),
          )
        ],
        backgroundColor: ColorSelect.loginBackGround,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            height: 500,
            width: 400,
            child: ListView.builder(
              itemCount: _datosMedicamentos.length,
              itemBuilder: (context, index){
                return listaMedicamentos(_datosMedicamentos[index].nombre, _datosMedicamentos[index].fechaCaducidad, _datosMedicamentos[index].cantidad);
              }
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 70)
          ),
          _button()
        ],
      ),
    );
  }
}

Card listaMedicamentos(String medicamento, String caducidad, int cantidad){
  return
    Card(
      child:
        Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
              title: Text(medicamento),
              subtitle: Text(
                'Caducidad: '+ caducidad + '   Cantidad: '+ cantidad.toString()),
              leading: const Icon(Icons.health_and_safety_outlined),
            ),
            
            // Usamos una fila para ordenar los botones del card
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(onPressed: () => {}, icon: const Icon(Icons.edit),),
                IconButton(onPressed: () => {}, icon: const Icon(Icons.delete),),
              ],
            ),
          ],
        ),
    );
}

dynamic _button() {
    return (Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(140, 40),
              elevation: 5,
              primary: ColorSelect.loginBackGround),
          onPressed: () async{
            final respuesta = await _callBackend();
            print(respuesta);
          },
          child: const Text(
            'Añadir medicamento',
            style: TextStyle(fontSize: 16),
          )),
    ));
  }

  Future? _callBackend() async {
    Uri url = Uri.http('172.17.151.110:9997', 'listMedicamentos');
    // final response = await http.get(url,)


    final response = await http.get(url
        // headers: {
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
        // FORMA FACIL DE REALIZAR UN JSON DE UN MAPA
        // body: json.encode({})
    );

    print(response.body);

    if (response.body == '') {
      // SI EL BODY VIENE VACIO ES PORQUE EL USUARIO NO EXISTE
      return null;
    } else {
      // SI NO ES PORQUE ENCONTRO EL USUARIO
      final respuesta = json.decode(response.body);
      return respuesta;
    }
  }

class DatosMedicamentos{
  String nombre = "";
  String fechaCaducidad = "";
  int cantidad = 0;

  DatosMedicamentos(this.nombre, this.fechaCaducidad, this.cantidad);
}