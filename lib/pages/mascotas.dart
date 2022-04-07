import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';
import 'package:veterinariamanto/providers/petModel.dart';
import 'package:veterinariamanto/services/servicesLogin.dart';
import '../providers/share.dart';

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
    Local().getToken().then((token) => {
      Local().getIdDuenio().then((id) {
        getDataById(token!, id).then((lista) {
          listaDatos = lista;
        });
      })
    });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: (() {
            Navigator.pushReplacementNamed(context, '/');
          }),
        ),
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
            child: listarDatos(listaDatos.length, listaDatos, context)
          ),
          onRefresh: refreshList
        ) 
        : const Center(child: CircularProgressIndicator()) 
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      Local().getToken().then((token) => {
        Local().getIdDuenio().then((id) {
          getDataById(token!, id).then((lista) {
            listaDatos = lista;
          });
        })
      });      
    });
    return null;
  }

  //https://www.kindacode.com/article/flutter-listtile/
  Widget listarDatos(int lenghtLista, List lista, BuildContext context) {
    print(lista);
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
                  listData.add(lista[index]['nombre']);
                  listData.add(lista[index]['raza']);
                  listData.add(lista[index]['fechaIngreso']);
                  listData.add(lista[index]['razon']);

                  List listaNavigador = [];
                  listaNavigador.add(lista[index]['idDuenio']);
                  listaNavigador.add(lista[index]['idMascota']);
                  Local().setMascota(listData);
                  Navigator.pushReplacementNamed(context, 'EditPet', arguments: listaNavigador);
                },
                icon: const Icon(Icons.edit, color: Colors.green,)
              ),
              IconButton(
                onPressed: (){
                  Mascota mascota = Mascota(
                    idMascota: lista[index]['idMascota'],
                    nombre: lista[index]['nombre'],
                    raza: lista[index]['raza'],
                    fechaIngreso: lista[index]['fechaIngreso'],
                    razon: lista[index]['razon'],
                    idDuenio: lista[index]['idDuenio']
                  );
                  Local().getToken().then((token) {
                    deleteMascota(mascota, token!).then((value) {
                      // print(value);
                      Navigator.pushReplacementNamed(context, 'Mascotas');
                    });
                  });
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