import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Mascotas extends StatefulWidget {
  const Mascotas({Key? key}) : super(key: key);

  @override
  State<Mascotas> createState() => _MascotasState();
}

class _MascotasState extends State<Mascotas> {
  
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List listaDatos = [];
  @override
  
  void initState() {
    super.initState();
    getDatos().then((lista) {listaDatos = lista;},);
    refreshList();
  }

  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_outlined),
        title: const Text('Vista de mascotas'),
        backgroundColor: ColorSelect.loginBackGround,
      ),
      // ignore: prefer_is_empty
      body: listaDatos.length > 0 ? verdadero(height, width) : const Center(child: CircularProgressIndicator()) 
    );
  }

  Widget verdadero(double height, double width) {
    return RefreshIndicator(
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: height * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: listarDatos(listaDatos.length, listaDatos, context, width, height),
        ),
      ), 
      onRefresh: refreshList
    );
  }

  Future<List<dynamic>> getDatos() async {
  var resultado;
  try {
    final response = await http.get(
      Uri.http('192.168.1.65:9998', '/listMascotasU'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    resultado = json.decode(response.body);
    return resultado;
  } 
  catch (e) {
    return ['Error en la respuesta'];
  }
}

  // ignore: prefer_void_to_null
  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 1));
    setState(
      () {
        getDatos().then((value) => {print(value)});        
      }
    );
    return null;
  }
}

//https://www.kindacode.com/article/flutter-listtile/
Widget listarDatos(int lenghtLista, List lista, BuildContext context, double width, double height) {
  final List<Map<String, dynamic>> _items = List.generate(
    lenghtLista,
    (index) => {
      "id": index,
      "nombre": lista[index]['nombre'],
      "raza": lista[index]['raza'],
      "fecha": lista[index]['fechaIngreso'],
      "razon": lista[index]['razon'],
    },
  );
  return ListView.builder(
    itemCount: _items.length,
    itemBuilder: (_, index) => Card(
      color: ColorSelect.colorCard,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            color: null,
            child: Text(_items[index]['nombre']),
          ),
          Container(
            color: null,
            child: Text(_items[index]['raza']),
          ),
          Container(
            color: null,
            child: Text(_items[index]['fecha']),
          ),
          Container(
            color: null,
            child: Text(_items[index]['razon']),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.green,
              size: 26.0,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 26.0,
            ),
          ),
        ],
      ),
    ),
  );
}