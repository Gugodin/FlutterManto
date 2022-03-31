import 'package:flutter/material.dart';
import 'package:veterinariamanto/painter/duenio.dart';

import '../providers/share.dart';
import 'login.dart';


class duenios extends StatefulWidget {
  const duenios({Key? key}) : super(key: key);

  @override
  State<duenios> createState() => _dueniosState();
}

class _dueniosState extends State<duenios> {
  @override
  TextEditingController _textFieldController = TextEditingController();
  late List<String> lista_Datos = [];
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int tamLista = 0;
  List lista_datos = [];
  void initState() {
    super.initState();
    local().getToken().then((token) => {
          print('token: $token'),
          get_duenios_all(token!).then((lista) {
            
            // listaDatos(value.length, value);
            tamLista = lista.length;
            lista_datos = lista;
          }),
        });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Dueños'),
      ),
      body: tamLista > 0
          ? RefreshIndicator(
              child: listaDatos(tamLista, lista_datos, context),
              onRefresh: refreshList,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 1));
    setState(
      () {
        local().getToken().then(
              (token) => {
                get_duenios_all(token!).then(
                  (lista) {
                    tamLista = lista.length;
                    lista_datos = lista;
                  },
                ),
              },
            );
      },
    );
    return null;
  }

  //https://www.kindacode.com/article/flutter-listtile/
  Widget listaDatos(int lenghtLista, List lista, BuildContext context) {
    print(lista);
    final List<Map<String, dynamic>> _items = List.generate(
      lenghtLista,
      (index) => {
        "idUsuario": index,
        "title": "Usuario: " + lista[index]['nombre'],
        "subtitle": "Nombre: " + lista[index]['primerNombre'] +
            " | Apellido: " +lista[index]['apellido']
      },
    );
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (_, index) => Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            _items[index]['title'],
          ),
          subtitle: Text(
            _items[index]['subtitle'],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  lista_Datos.add(lista[index]['idUsuario'].toString());
                  lista_Datos.add(lista[index]['nombre']);
                  lista_Datos.add(lista[index]['password']);
                  lista_Datos.add(lista[index]['rol']);
                  lista_Datos.add(lista[index]['primerNombre']);
                  lista_Datos.add(lista[index]['apellido']);

                  // print(lista_datos);
                  late List ListaNavigador = [];
                  ListaNavigador.add(lista[index]['idUsuario'].toString());
                  ListaNavigador.add(lista[index]['rol']);
                  local().setDuenio(lista_Datos);
                  Navigator.pushReplacementNamed(context, 'edit_duenios',
                      arguments: ListaNavigador);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  // String id_STR = lista_navigator.toString()[1];
                  // int id_casteado = int.parse(lista_navigator.toString()[1]);

                  // ignore: unnecessary_new
                  Usuario user = new Usuario(
                      idUsuario: lista[index]['idUsuario'],
                      nombre: lista[index]['nombre'],
                      password: lista[index]['password'],
                      rol: 'DUEÑO',
                      primerNombre: lista[index]['primerNombre'],
                      apellido: lista[index]['apellido']);

                  local().getToken().then(
                    (token) {
                      deleteDuenio(user, token!).then(
                        (value) {
                          print(value);
                          Navigator.pushReplacementNamed(context, 'duenios');
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
