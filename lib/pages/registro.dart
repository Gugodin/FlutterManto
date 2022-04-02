import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  bool mostrar = true;
  bool ver = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Medicamentos'),
        // iconTheme: const IconThemeData(color: Colors.blue),
        actions: [
          Container(
            padding: const EdgeInsets.only(left: 90),
            height: 60,
            width: 170,
            child: Image.asset('assets/images/splash.png'),
          )
        ],
        backgroundColor: Colors.blue,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(bottom: 50, top: 40, left: 25),
              child: const Text(
                'Bienvenido a Medicamentos ',
                style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold,),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25, bottom: 5),
              child: const Text(
                'ID',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              child: TextField(
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18),
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.black, width: 1)),
                  hintText: 'Nombre completo',
                ),
                onChanged: (text) {},
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25, bottom: 5),
              child: const Text(
                'Correo electrónico',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              child: TextField(
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18),
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      // borderSide: BorderSide(color: Colors.black, width: 100),
                      ),
                  hintText: 'Dirección de correo',
                ),
                onChanged: (text) {},
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.only(left: 25, bottom: 5),
              child: const Text(
                'Contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                obscureText: mostrar,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 18),
                autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon:
                        Icon(mostrar ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        mostrar = !mostrar;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.black, width: 1)),
                  hintText: 'Contraseña',
                ),
                onChanged: (text) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30, top: 15),
              margin: const EdgeInsets.only(right: 30),
              child: const Text(
                  'La contraseña tiene que tener caracteres numéricos y símbolos con un mínimo de 6 caracteres',
                  style:
                      TextStyle(fontSize: 18, color: Colors.grey)),
            ),
            Container(
              margin:const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                children: [
                  Checkbox(
                    value: ver,
                    onChanged: (check) {
                      setState(() {
                        ver = check!;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Al registrarme acepto los\n',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'términos y condiciones',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.pink,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: ' y la ',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'política de privacidad',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.pink,
                                    decoration: TextDecoration.underline),
                                )
                              ]
                            )
                          ]
                        )
                      )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(
                width: size.width - 70,
                height: 50,
                child: ElevatedButton(
                  child: const Text(
                    'Crear Cuenta',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber ,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                  )
                ),
              ),
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(top: 30, left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const Text('¿Ya tienes una cuenta?',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    )
                  ),
                  const Text(''),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, 'login');
                    },
                    child: const Text(
                      'Iniciar sesión',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
