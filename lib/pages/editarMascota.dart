import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPet extends StatefulWidget {
  const EditPet({Key? key}) : super(key: key);
  
  @override
  State<EditPet> createState() => _EditPetState();
}

class _EditPetState extends State<EditPet> {

  // final Usuario user;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // _edit_duenioState({required this.user});
  late var nombre = TextEditingController();
  late var apellido = TextEditingController();
  late var edad = TextEditingController();
  late var primerNombre = TextEditingController();
  late var password = TextEditingController();
  late var rol = TextEditingController();
  late List<String> datos_duenio = [];
  late var iniciar = false;
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    nombre.dispose();
    apellido.dispose();
    edad.dispose();
    primerNombre.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // local().getDuenio().then((lista) {
    //   print(lista);
      // datos_duenio = lista!;
    // });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    double width_total = MediaQuery.of(context).size.width;
    double height_total = MediaQuery.of(context).size.height;
    final Object? lista_navigator = ModalRoute.of(context)!.settings.arguments;
    iniciar = true;
    print('object');
    print(datos_duenio);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Modificar Dueño'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'Mascotas');
          },
        ),
      ),
      body: iniciar == true
          ? RefreshIndicator(
              child: ListView(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                children: [
                  input(width_total, height_total, 'Nombre', nombre),
                  input(width_total, height_total, 'password', password),
                  input(width_total, height_total, 'rol', rol),
                  
                  input(
                      width_total, height_total, 'primerNombre', primerNombre),
                  input(width_total, height_total, 'apellido', apellido),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    // width: 300,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // print(nombre.text + apellidos.text);
                        // print(lista_navigator.toString()[0]);
                        // String id_STR = lista_navigator.toString()[1];
                        // int id_casteado =
                        //     int.parse(lista_navigator.toString()[1]);

                        // // ignore: unnecessary_new
                        // Usuario user = new Usuario(
                        //     idUsuario: id_casteado,
                        //     nombre: nombre.text,
                        //     password: password.text,
                        //     rol: rol.text,
                        //     primerNombre: primerNombre.text,
                        //     apellido: apellido.text,
                        
                        //     );
                        // print(user);
                        // local().getToken().then(
                        //   (token) {
                        //     updateDuenio(user, token!).then(
                        //       (value) {
                        //         print(value);
                        //         Navigator.pushReplacementNamed(
                        //             context, 'duenios');
                        //       },
                        //     );
                        //   },
                        // );
                      },
                      child: const Text('Editar Usuario'),
                    ),
                  ),
                ],
              ),
              onRefresh: refreshList)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget input(width_total, height_total, nombre_input,
      TextEditingController controlador) {
    return Container(
      width: width_total * 0.8,
      height: height_total * 0.1,
      margin: const EdgeInsets.only(top: 1),
      child: TextField(
        controller: controlador,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: nombre_input,
        ),
      ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(milliseconds: 30));
    setState(() {
        // local().getDuenio().then((lista) {
        //   print(lista);
        //   nombre = new TextEditingController(text: lista![4]);
        //   apellido = new TextEditingController(text: lista[5]);
        //   edad = new TextEditingController(text: lista[3]);
        //   nombre = new TextEditingController(text: lista[1]);
        //   password = new TextEditingController(text: lista[2]);
        // });
    });
    return null;
  }
}
