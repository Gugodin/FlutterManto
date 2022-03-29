import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';

class Mascotas extends StatefulWidget {
  Mascotas({Key? key}) : super(key: key);

  @override
  State<Mascotas> createState() => _MascotasState();
}

class _MascotasState extends State<Mascotas> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_outlined),
        title: const Text('Vista de mascotas'),
        backgroundColor: ColorSelect.loginBackGround,
      ),
      body:  Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Expanded(
          child: SizedBox(
            height: 300,
            child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, position){
              return _cards(width,height);
            },
          ),
          )

        ),
      ),
      // body: ListView(
      //   children: const [
      //     Card(
      //       color: ColorSelect.txtLogin,
      //       child: ListTile(
      //         title: Text('PRIMERA CARD'),
      //         textColor: Colors.white,
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

Widget _cards(double width, double height) {
  return Card(
    elevation: 5,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [

              Container(
                padding: EdgeInsets.only(top:30,left: 30,right: 30),
                height: height * 0.15,
                child: const Text('01'),
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
