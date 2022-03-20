import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';

import '../painter/login_painter.dart';

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
          //TEXT FIELD CORREO
          TextField(
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

  get _button => Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(140, 40),
                elevation: 5,
                primary: ColorSelect.loginBackGround),
            onPressed: () {
              //AQUI ES DONDE SE HACE LA LLAMADA CON EL BACK
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 16),
            )),
      );

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
    var size = MediaQuery.of(context).size;

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
                            _button,
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
}
