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

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_outlined),
        title: const Text('Vista de mascotas'),
        backgroundColor: ColorSelect.loginBackGround,
      ),
      // ignore: prefer_is_empty
      body: listaDatos.length > 0 ? verdadero(height) : const Center(child: CircularProgressIndicator()) 
    );
  }

  Widget verdadero(double height) {
    return RefreshIndicator(
      child: Container(
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
                      final respuesta = await getDatos();
                      // ignore: unnecessary_null_comparison
                      if (respuesta == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(("Usuario invalido"))),
                        );
                      } else {
                        print('Usuario valido se guarda');
                        print(listaDatos);
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
              child: listarDatos(listaDatos.length, listaDatos, context),
              // child: ListView.builder(
              //   itemCount: listaDatos.length,
              //   itemBuilder: (context, position){
              //     return _cards(width,height, listaDatos);
              //   },
              // ),
            )
          ],
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

Widget _cards(double width, double height, List<dynamic> datos) {
  return Card(
    color: ColorSelect.colorCard,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top:30,left: 30,right: 30),
          height: height * 0.15,
          child: const Text('1'),
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


//https://www.kindacode.com/article/flutter-listtile/
  Widget listarDatos(int lenghtLista, List lista, BuildContext context) {
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
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            _items[index]['nombre'],
          ),
          subtitle: Text(
            _items[index]['raza'],
          ),
          // trailing: Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     // IconButton(
          //     //   onPressed: () {
          //     //     listaDatos.add(lista[index]['id'].toString());
          //     //     listaDatos.add(lista[index]['username']);
          //     //     listaDatos.add(lista[index]['password']);
          //     //     listaDatos.add(lista[index]['edad'].toString());
          //     //     listaDatos.add(lista[index]['nombre']);
          //     //     listaDatos.add(lista[index]['apellidos']);

          //     //     // print(listaDatos);
          //     //     late List ListaNavigador = [];
          //     //     ListaNavigador.add(lista[index]['id'].toString());
          //     //     ListaNavigador.add(lista[index]['rol']);
          //     //     local().setDuenio(listaDatos);
          //     //     Navigator.pushReplacementNamed(context, 'edit_duenios',
          //     //         arguments: ListaNavigador);
          //     //   },
          //     //   icon: const Icon(Icons.edit),
          //     // ),
          //     IconButton(
          //       onPressed: () {
          //         // String id_STR = lista_navigator.toString()[1];
          //         // int id_casteado = int.parse(lista_navigator.toString()[1]);

          //         // ignore: unnecessary_new
          //         Usuario user = new Usuario(
          //             id: lista[index]['id'],
          //             nombre: lista[index]['nombre'],
          //             apellidos: lista[index]['apellidos'],
          //             edad: lista[index]['edad'],
          //             rol: 'Cliente',
          //             username: lista[index]['username'],
          //             password: lista[index]['password']);

          //         local().getToken().then(
          //           (token) {
          //             deleteDuenio(user, token!).then(
          //               (value) {
          //                 print(value);
          //                 Navigator.pushReplacementNamed(context, 'duenios');
          //               },
          //             );
          //           },
          //         );
          //       },
          //       icon: const Icon(Icons.delete),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }