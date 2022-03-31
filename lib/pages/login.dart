import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';
import 'package:http/http.dart' as http;
import 'package:veterinariamanto/providers/prueba.dart';
import 'package:veterinariamanto/providers/sesion_info.dart';
import '../painter/duenio.dart';
import '../painter/login_painter.dart';
import '../providers/share.dart';
//hola
class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String user = '';
  String password = '';
  bool _isObscure = false;

  get _textFieldUser => Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      // color: Colors.black,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Correo electrónico',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorSelect.txtLogin,
                  fontSize: 15,
                  // fontFamily: ''
                ),
              ),
            ],
          ),
          //TEXT FIELD CORREO
          TextField(
            onChanged: (value) {
              user = value;
            },
            decoration: const InputDecoration(
              // labelText: 'Correo electrónico',
              hintText: 'Email address',
              border: OutlineInputBorder(
                  // borderSide: BorderSide(width: 10),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ],
      ));

  get _textFieldPassword => Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      // color: Colors.black,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Contraseña',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorSelect.txtLogin,
                  fontSize: 15,
                  // fontFamily: ''
                ),
              ),
            ],
          ),
          //TEXT FIELD PASSWORD
          TextField(
            onChanged: (value) {
              password = value;
            },
            obscureText: !_isObscure,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      // print('a');
                      // print(_isObscure);
                      _isObscure = !_isObscure;
                      // print(_isObscure);
                    });
                    // print('a');
                  },
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off)),
              // labelText: 'Correo electrónico',
              hintText: 'Password',

              border: const OutlineInputBorder(
                  // borderSide: BorderSide(width: 10),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ],
      ));

  get _registerButton => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              '¿No te has registrado?',
              style: TextStyle(fontSize: 15),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Registrate',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ))
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final loginInfo = Provider.of<SesionInfo>(context);
    var size = MediaQuery.of(context).size;
    // print('Guardado en sesion info');
    // print(loginInfo.id);
    // print(loginInfo.token);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          // color: Colors.red,

          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              //FONDO
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  painter: LoginPainter(
                      heiDeterminate: size.height, wiDeterminate: size.width),
                ),
              ),

              //LO DEMAS
              SingleChildScrollView(
                child: Container(
                  //MOSTRAR A TUS COMPAS PA VER COMO LES GUSTA
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    // color: Colors.black.withOpacity(0.4)
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      //IMAGE
                      Image.asset(
                        'lib/assets/mascotas_logo.png',
                        height: 200,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                spreadRadius: 1)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Inicia sesion ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorSelect.txtLogin,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                            //TEXT USER
                            _textFieldUser,
                            //TEXT PASSWORD
                            _textFieldPassword,

                            //REGISTRO BOTON
                            _registerButton,

                            //BOTON
                            _button(loginInfo),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
              // //LOGIN DE USUARIO
              // //TEXT FIELD DE USUARIO
              // _textFieldUser,
            ],
          ),
        ),
      ),
    );
  }

  dynamic _button(SesionInfo loginInfo) {
    return (Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(140, 40),
              elevation: 5,
              primary: ColorSelect.loginBackGround),
          onPressed: () async {
            //AQUI ES DONDE SE HACE LA LLAMADA CON EL BACK
            // print(user);
            // print(password);

            if (user == "" || password == "") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(("Llenar todos los campos"))),
              );
            } else {
              final respuesta = await _callBackend(user, password);

              // print(respuesta);

              if (respuesta == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(("Usuario invalido"))),
                );
              } else {
                // print('Usuario valido se guarda');
                loginInfo.saveData(datos: respuesta);
                local().setToken(respuesta[1]);
                
                Navigator.pushNamed(context, 'duenios');
              }
            }
          },
          child: const Text(
            'Iniciar sesión',
            style: TextStyle(fontSize: 16),
          )),
    ));
  }

  Future? _callBackend(nombre, password) async {
    Uri url = Uri.http('192.168.1.70:18080', 'user/login');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // FORMA FACIL DE REALIZAR UN JSON DE UN MAPA
        body: json.encode({'nombre': nombre, 'password': password}));

    if (response.body == '') {
      // SI EL BODY VIENE VACIO ES PORQUE EL USUARIO NO EXISTE
      return null;
    } else {
      // SI NO ES PORQUE ENCONTRO EL USUARIO
      final respuesta = json.decode(response.body);
      return respuesta;
    }
  }



}








  Future<List<dynamic>> updateDuenio(Usuario usuario, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.70:18080', '/user/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode({
        "idUsuario": usuario.idUsuario,
        "nombre": usuario.nombre,
        "password": usuario.password,
        "rol": usuario.rol,
        "primerNombre": usuario.primerNombre,
        "apellido": usuario.apellido
      }),
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
Future<List<dynamic>> get_duenios_all(String token) async {
  var resultado;
  print('-----------------');
  print(LoginProvider().jwt);
  print('object');
  try {
    final response = await http
        .get(Uri.http('192.168.1.70:18080', '/user/listUser'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token
    });

    // body: json.encode({"username": usuario, "password": password}));
    resultado = json.decode(response.body);
    // print(resultado);
    return resultado;
  } catch (e) {
    return ['Error en la respuesta'];
  }
}



Future<List<dynamic>> deleteDuenio(Usuario usuario, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.70:18080', '/user/delete'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode(
        {
          "idUsuario": usuario.idUsuario,
          "nombre": usuario.nombre,
          "password": usuario.password,
          "rol": usuario.rol,
          "primerNombre": usuario.primerNombre,
          "apellido": usuario.apellido
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
