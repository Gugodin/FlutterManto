import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistroDuenios extends StatefulWidget {
  RegistroDuenios({Key? key}) : super(key: key);

  @override
  State<RegistroDuenios> createState() => _RegistroDueniosState();
}

class _RegistroDueniosState extends State<RegistroDuenios> {
  @override
  void initState() {
    // TODO: implement initState
    // data = 'ad';
    // _callBackend();

    // print(data[0]);
    super.initState();
  }

  Future? _callBackend() async {
    Uri url = Uri.http('192.168.100.8:18080', 'getAllUser');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // FORMA FACIL DE REALIZAR UN JSON DE UN MAPA
      // body: json.encode({'nombre': nombre, 'password': password})
    );
    // print('RESPUESTA DEL BACK ${response.body}');

    if (response.body == '') {
      // SI EL BODY VIENE VACIO ES PORQUE EL USUARIO NO EXISTE
      return null;
    } else {
      // SI NO ES PORQUE ENCONTRO EL USUARIO

      final respuesta = json.decode(response.body) as List;
      List<Map> res = [];
      for (var i = 0; i < respuesta.length; i++) {
        Map x = respuesta[i] as Map;
        res.add(x);
      }

      return res;
    }
  }

  late dynamic data = _callBackend();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print('data $data');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resgitro de dueños'),
      ),
      body: Column(
        children: [
          campos(height),
          FutureBuilder(
            future: _callBackend(),
            builder: (context, snapshot) {
              final lista = snapshot.data;
              print('snapshot ${snapshot.data}');

              return snapshot.data == null
                  ? Text('Cargando datos...')
                  : _cargarDatos(width, height, snapshot.data);
            },
          )
        ],
      ),
      // body: ListView.builder(
      //   itemCount: 3,
      //   itemBuilder: (context, position){
      //     //  return _cards(width,height);
      //     return const Text('data');
      //   },
      // ),
    );
  }

  Container campos(double height) {
    return Container(
      // padding: EdgeInsets.only(top: 200),
      height: 80,
      decoration: BoxDecoration(color: Colors.blue[200]),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            height: height * 0.15,
            child: const Text('Id'),
          ),
          Container(
            padding: EdgeInsets.all(30),
            height: height * 0.15,
            child: const Text('Usuario'),
          ),
          Container(
            padding: EdgeInsets.all(30),
            height: height * 0.15,
            child: const Text('Rol'),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, top: 30),
            height: height * 0.15,
            child: const Text('Primer Nombre'),
          ),
          // Container(
          //   padding: EdgeInsets.all(30),
          //   height: height*0.15,
          //   child: const Text('Apellido'),
          // ),
        ],
      ),
    );
  }

  _cargarDatos(width, height, lista) {
    return Expanded(
        child: SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, position) {
          return _cards(
              width,
              height,
              lista[position]['idUsuario'],
              lista[position]['nombre'],
              lista[position]['rol'],
              lista[position]['primerNombre']);
        },
      ),
    ));
  }
}

Widget _cards(double width, double height, id, String nickname, String rol,
    String firstName) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Container(
          // color: Colors.grey,
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          height: height * 0.15,
          child: Text(id.toString()),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          height: height * 0.15,
          child: Text(nickname),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          height: height * 0.15,
          child: rol == 'OWNER' ? Text('Propietario') : Text('Empleado'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          height: height * 0.15,
          child: Text(firstName),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ],
    ),
  );
}
