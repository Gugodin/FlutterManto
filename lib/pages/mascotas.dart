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
  late List<String> listData = [];
  List listaDatos = [];

  @override
  void initState() {
    super.initState();
    print('ANTES DEL GET DATOS');
    getDatos().then((lista) {listaDatos = lista;},);
    print(listaDatos);
    refreshList();
  }

  @override
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
      body: listaDatos.length > 0 
        ? RefreshIndicator(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(5),
            child: listarDatos(listaDatos.length, listaDatos, context, width, height)
          ),
          onRefresh: refreshList
        ) 
        : const Center(child: CircularProgressIndicator()) 
    );
  }

  Future<List<dynamic>> getDatos() async {
  var resultado;
  print('Antes del try');
  try {
    final response = await http.get(
      Uri.http('192.168.1.74:9998', '/listMascotasU'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    resultado = json.decode(response.body);
    print(resultado);
    return resultado;
  } 
  catch (e) {
    return ['Error en la respuesta'];
  }
}

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

  //https://www.kindacode.com/article/flutter-listtile/
  Widget listarDatos(int lenghtLista, List lista, BuildContext context, double width, double height) {
    final List<Map<String, dynamic>> _items = List.generate(
      lenghtLista,
      (index) => {
        "id": index,
        "nombre": lista[index]['nombre'],
        "fecha" : "Fecha: " + lista[index]['fechaIngreso'],
        "raza" : "Raza: " + lista[index]['raza'],
        "descripcion": "Descripción: " + lista[index]['razon'],
      },
    );
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (_, index) => Card(
        color: ColorSelect.colorCard,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(
            _items[index]['nombre']
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _items[index]['fecha'],
              ),
              Text(
                _items[index]['raza'],
              ),
              Text(
                _items[index]['descripcion'],
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  // listData.add(lista[index]['idUsuario'].toString());
                  // listData.add(lista[index]['nombre']);
                  // listData.add(lista[index]['raza']);
                  // listData.add(lista[index]['fechaIngreso']);
                  // listData.add(lista[index]['razon']);
                  // // print(lista_datos);
                  // late List ListaNavigador = [];
                  // ListaNavigador.add(lista[index]['idUsuario'].toString());
                  // ListaNavigador.add(lista[index]['rol']);
                  // local().setDuenio(listData);
                  // Navigator.pushReplacementNamed(context, 'edit_duenios', arguments: ListaNavigador);
                },
                icon: const Icon(Icons.edit, color: Colors.green,)
              ),
              IconButton(
                onPressed: (){
                  // Mascota mascota = new Mascota(
                  //   idMascota: lista[index]['idUsuario'],
                  //   nombre: lista[index]['nombre'],
                  //   raza: lista[index]['raza'],
                  //   fechaIngreso: lista[index]['fechaIngreso'],
                  //   razon: lista[index]['razon'],
                  // );
                  // local().getToken().then(
                  //   (token) {
                  //     deleteDuenio(user, token!).then(
                  //       (value) {
                  //         print(value);
                  //         Navigator.pushReplacementNamed(context, 'duenios');
                  //       },
                  //     );
                  //   },
                  // );
                },
                icon: const Icon(Icons.delete, color: Colors.red,),
              )
            ]
          ),
        )
      ),
    );
  }
}