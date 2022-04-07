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
  List<DatosMedicamentos> _datosMedicamentos = [];
  List<String> _listMedicamentoTemp = [];
  String idTemp = "";
  String medicamentoTemp = "";
  String caducidadTemp = "";
  String cantidadTemp = "";

  String boton = "";
  
  @override
  void initState() {
    // TODO: implement initState
    // dispersarLista();
    super.initState();
  }

  @override
  void dispose() {
    // dispersarLista();
    super.dispose();
    // updateProgress();

  }


  dispersarLista(respuesta) async{

    // final respuesta = await _callBackend();

    print(respuesta.length);
    for (var i = 0; i < respuesta.length; i++) {
      // print(int.parse(respuesta[i]["sustanciaActiva"]));
      _datosMedicamentos.add(DatosMedicamentos(respuesta[i]["idMedicamento"], respuesta[i]["nombre"], respuesta[i]["fechaCaducidad"], int.parse(respuesta[i]["sustanciaActiva"])));
    }

    // print(respuesta[0]["idMedicamento"]);

    return _datosMedicamentos;
  }
  
  @override
  Widget build(BuildContext context) {
    final Object? lista_navigator = ModalRoute.of(context)!.settings.arguments;
    print(lista_navigator.toString());
    if (lista_navigator.toString().compareTo("null") == 0){
      // print("Entre");
      boton = "Añadir";
    }else{
      boton = "Modificar";
    }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              height: 400,
              width: 400,
      
              child: FutureBuilder( 
                future: _callBackend(),
                builder: (context, AsyncSnapshot<dynamic> a){
                  print(a);
                  if (a.data == null){
                    return Text("Esperando datos");
                  }else{
                    // 
                    print(a.data);
                    dispersarLista(a.data);
                    // print(_datosMedicamentos[0].nombre);
                    return ListView.builder(
                      itemCount: _datosMedicamentos.length,
                      itemBuilder: (context, index){
      
                        return listaMedicamentos(_datosMedicamentos[index].id, _datosMedicamentos[index].nombre, _datosMedicamentos[index].fechaCaducidad, _datosMedicamentos[index].cantidad);
                      }
                    );
                  }
                },
              )
            ),
      
      
              // child: ListView.builder(
              //   itemCount: _datosMedicamentos.length,
              //   itemBuilder: (context, index){
      
              //     return listaMedicamentos(_datosMedicamentos[index].nombre, _datosMedicamentos[index].fechaCaducidad, _datosMedicamentos[index].cantidad);
              //   }
            //     // 
            // ),
            const Padding(
              padding: EdgeInsets.only(top: 20)
            ),
            inputMedicamento(lista_navigator.toString()),
            inputCaducidad(lista_navigator.toString()),
            inputCantidad(lista_navigator.toString()),
            _button()
          ],
        ),
      ),
    );
  }

  Card listaMedicamentos(int id, String medicamento, String caducidad, int cantidad){
    return
      Card(
        child:
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
                title: Text(id.toString() + ". " +medicamento),
                subtitle: Text(
                  'Caducidad: '+ caducidad + '   Cantidad: '+ cantidad.toString()),
                leading: const Icon(Icons.health_and_safety_outlined),
              ),
              
              // Usamos una fila para ordenar los botones del card
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      List argumento = [id.toString(), medicamento, caducidad, cantidad.toString()];
                      Navigator.pushReplacementNamed(context, 'Medicamentos', arguments: argumento);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: (){
                      _deleteDuenio(id, medicamento, caducidad, cantidad.toString());
                      Navigator.pushReplacementNamed(context, 'Medicamentos');
                    }, 
                    icon: const Icon(Icons.delete)
                  ),
                ],
              ),
            ],
          ),
      );
  }

  Container inputMedicamento(String nombre){
    List<String> nom = []; 
    TextEditingController texto = TextEditingController();
    if (nombre.compareTo("null") == 0){
      nombre = "Medicamento";
    }else{
      // print("Nombre     "+nombre.toString());
      nombre = nombre.replaceAll("[", "").replaceAll("]", "").replaceAll(",", "");
      nom = nombre.split(' ');
      idTemp = nom[0];
      medicamentoTemp = nom[1];
      print("Nombre     "+nom.toString());
      texto.text = nom[1];
      nombre = nom[1];

    }
    return
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
        child: TextField(
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 18),
          controller: texto,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.black, width: 1)),
            hintText: nombre,
          ),
          onChanged: (text) {
            print(text);
            medicamentoTemp = text;
            // setState(() {
            // });
          },
        ),
      );
  }

  Container inputCaducidad(String nombre){
    List<String> nom = []; 
    TextEditingController texto = TextEditingController();
    if (nombre.compareTo("null") == 0){
      nombre = "Caducidad";
    }else{
      nombre = nombre.replaceAll("[", "").replaceAll("]", "").replaceAll(",", "");
      nom = nombre.split(' ');
      print("Nombre     "+nom.toString());
      caducidadTemp = nom[2]; 
      texto.text = nom[2];
      nombre = nom[2];
    }
    return
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
        child: TextField(
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 18),
          controller: texto,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.black, width: 1)),
            hintText: nombre,
          ),
          onChanged: (text) {
            caducidadTemp = text;
            // setState(() {
            // });
          },
        ),
      );
  }

  Container inputCantidad(String nombre){
    List<String> nom = []; 
    TextEditingController texto = TextEditingController();
    if (nombre.compareTo("null") == 0){
      nombre = "Cantidad";
    }else{
      nombre = nombre.replaceAll("[", "").replaceAll("]", "").replaceAll(",", "");
      nom = nombre.split(' ');
      print("Nombre     "+nom.toString());
      cantidadTemp = nom[3];
      texto.text = nom[3];
      nombre = nom[3];
    }
    return
      Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
        child: TextField(
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 18),
          controller: texto,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.black, width: 1)),
            hintText: nombre,
          ),
          onChanged: (text) {
            cantidadTemp = text;
            // setState(() {
            // });
          },
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
            onPressed: () {
              if (boton == "Modificar"){
                if (idTemp != "" && medicamentoTemp != "" && caducidadTemp != "" && cantidadTemp != ""){
                  // print("Si entre");
                  updateLista(idTemp, medicamentoTemp, caducidadTemp, cantidadTemp);
                  // idTemp = "";
                  // medicamentoTemp = "";
                  // caducidadTemp = "";
                  // cantidadTemp = "";
                }else{
                  // print("No entro");
                }
              }else{
                if (medicamentoTemp != "" && caducidadTemp != "" && cantidadTemp != ""){
                  print("Si entre");
                  addLista(medicamentoTemp, caducidadTemp, cantidadTemp);
                  // idTemp = "";
                  // medicamentoTemp = "";
                  // caducidadTemp = "";
                  // cantidadTemp = "";
                }else{
                  print("No entro");
                }
              }
              Navigator.pushReplacementNamed(context, 'Medicamentos');
              // dispersarLista();
              // _datosMedicamentos()
              // print(respuesta);
            },
            child: Text(
              boton,
              style: TextStyle(fontSize: 16),
            )),
      ));
    }

  Future? _callBackend() async {
    Uri url = Uri.http('192.168.0.9:9997', 'listMedicamentos');
    // final response = await http.get(url,)

    final response = await http.get(url);

    if (response.body == '') {
      // SI EL BODY VIENE VACIO ES PORQUE EL USUARIO NO EXISTE
      return null;
    } else {
      // SI NO ES PORQUE ENCONTRO EL USUARIO
      final respuesta = json.decode(response.body);
      return respuesta;
    }
  }

  Future<List<dynamic>> _deleteDuenio(id, nombre, fechaCaducidad, cantidad) async {
    try {
      final response = await http.post(
        Uri.http('192.168.0.9:9997', 'medicamento/delete'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "idMedicamento": id,
            "codigo": 0,
            "nombre": nombre,
            "fechaCaducidad": fechaCaducidad,
            "sustanciaActiva": cantidad
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        if (data == null) {
          return [];
        } else {
          return data;
        }
      } else {
        return ['No se ha podido conectar al servidor'];
      }
    } catch (e) {
      return ['Error en la respuesta'];
    }
  }

}

Future<List<dynamic>> updateLista(id, medicamento, caducidad, cantidad) async {
  try {
    final response = await http.post(
      Uri.http('192.168.0.9:9997', 'medicamento/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "idMedicamento": id,
        "nombre": medicamento,
        "codigo": 0,
        "fechaCaducidad": caducidad,
        "sustanciaActiva": cantidad
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('entre al 200');
      final data = json.decode(response.body);
      print(data);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> addLista(medicamento, caducidad, cantidad) async {
  try {
    final response = await http.post(
      Uri.http('192.168.0.9:9997', 'medicamento/add'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "codigo": 0,
        "nombre": medicamento,
        "fechaCaducidad": caducidad,
        "sustanciaActiva": cantidad
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('entre al 200');
      final data = json.decode(response.body);
      print(data);
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return ['No se ha podido conectar al servidor'];
    }
  } catch (e) {
    return ['Error en la respuesta'];
  }
}


class DatosMedicamentos{
  int id = 0;
  String nombre = "";
  String fechaCaducidad = "";
  int cantidad = 0;

  DatosMedicamentos(this.id, this.nombre, this.fechaCaducidad, this.cantidad);
}