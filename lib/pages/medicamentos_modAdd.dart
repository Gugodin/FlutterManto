import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';

class MedicamentosModAdd extends StatefulWidget {
  const MedicamentosModAdd({Key? key}) : super(key: key);

  @override
  State<MedicamentosModAdd> createState() => _MedicamentosModAddState();
}

class _MedicamentosModAddState extends State<MedicamentosModAdd> {

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }

  final List<DatosMedicamentos> _datosMedicamentos = [
    // DatosMedicamentos("Paracetamol", "10-05-2023", 200)
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
    DatosMedicamentos("Paracetamol", "05-10-2023", 200),
  ];
  
  @override
  Widget build(BuildContext context) {
    
    final medicamento = TextEditingController();
    medicamento.text = "hoeela";
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5),
            // height: 500,
            // width: 400,
            child: field(medicamento),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 70)
          ),
          _button()
        ],
      ),
    );
  }
}

dynamic field(medicamento){
  // final caducidad = TextEditingController();
  // final cantidad = TextEditingController();
  String user = '';
  return Container(
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
          controller: medicamento,
          onChanged: (value) {
            medicamento.text = "hola";
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
}

dynamic _button() {
    return (Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(140, 40),
              elevation: 5,
              primary: ColorSelect.loginBackGround),
          onPressed: ()  {
          },
          child: const Text(
            'Añadir medicamento',
            style: TextStyle(fontSize: 16),
          )),
    ));
  }




// class DatosMedicamentos{
//   String nombre;
//   String fechaCaducidad;
//   int cantidad;

//   DatosMedicamentos({required this.nombre, required this.fechaCaducidad, required this.cantidad});
// }

class DatosMedicamentos{
  String nombre = "";
  String fechaCaducidad = "";
  int cantidad = 0;

  DatosMedicamentos(this.nombre, this.fechaCaducidad, this.cantidad);
}