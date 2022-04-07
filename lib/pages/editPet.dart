import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';
import 'package:veterinariamanto/providers/petModel.dart';
import 'package:veterinariamanto/services/servicesLogin.dart';

import '../providers/share.dart';

class EditPet extends StatefulWidget {
  const EditPet({Key? key}) : super(key: key);
  
  @override
  State<EditPet> createState() => _EditPetState();
}

class _EditPetState extends State<EditPet> {

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  late var name = TextEditingController();
  late var date = TextEditingController();
  late var raza = TextEditingController();
  late var descrption = TextEditingController();
  late List<String> dataPet = [];
  late var iniciar = false;

  void dispose() {
    name.dispose();
    date.dispose();
    raza.dispose();
    descrption.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Local().getMascota().then((lista) {
      dataPet = lista!;
    });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    final Object? lista_navigator = ModalRoute.of(context)!.settings.arguments;
    iniciar = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar mascota'),
        backgroundColor: ColorSelect.loginBackGround,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'Mascotas');
          },
        ),
      ),
      body: iniciar == true ? RefreshIndicator(
        child: ListView(
          padding: const EdgeInsets.all(13),
          children: [
            input('Nombre', name),
            input('Fecha', date),
            input('Raza', raza),
            input('Descripción', descrption),
            Container(
              color: Colors.transparent,
              // margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: const Text('Editar mascota'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  List? lista = [];
                  lista = lista_navigator as List?;
                  int idMascota = lista![1];
                  int idDuenio = lista[0];

                  // ignore: unnecessary_new
                  Mascota mascota = Mascota (
                    idMascota: idMascota,
                    nombre: name.text,
                    raza: raza.text,
                    fechaIngreso: date.text,
                    razon: descrption.text,
                    idDuenio: idDuenio,
                  );
                  Local().getToken().then((token) {
                    updateMascota(mascota, token!).then((value) {
                      Navigator.pushReplacementNamed(context, 'Mascotas');
                    });
                  });
                },
              ),
            ),
          ],
        ),
        onRefresh: refreshList
      )
      : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget input(String dato, TextEditingController controlador) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 25),
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
          hintText: dato,
        ),
      ),
    );
  }

  // ignore: prefer_void_to_null
  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(const Duration(milliseconds: 30));
    setState(() {
      Local().getMascota().then((lista) {
        print(lista);
        name = TextEditingController(text: lista![0]);
        raza = TextEditingController(text: lista[1]);
        date = TextEditingController(text: lista[2]);
        descrption = TextEditingController(text: lista[3]);
      });
    });
    return null;
  }
}
