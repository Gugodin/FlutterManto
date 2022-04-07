// import 'dart:_http';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:veterinariamanto/providers/modelo_citas.dart';
import 'package:veterinariamanto/providers/sesion_info.dart';


Future<List<dynamic>> get_duenios_all(String token) async {
  var resultado;
  print(SesionInfo().token);
  print('object');
  try {
    final response = await http
        .get(Uri.http('192.168.1.72:18080', '/user/listUser'), headers: {
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
//////////////////////////////////////////////////////////////////////////
Future<List<dynamic>> get_citas_all(String token) async {
  var resultado;
  print(SesionInfo().token);
  print('object');
  try {
    final response = await http
        .get(Uri.http('192.168.1.72:9990', '/listCita'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token
    });

    // body: json.encode({"username": usuario, "password": password}));
    resultado = json.decode(response.body);
    print(resultado);
    return resultado;
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> updateCitas(Citas citas, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.72:9990', '/cita/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode({
          "idCita": citas.idCita,
          "fecha": citas.fecha,
          "hora": citas.hora,
          "tipoServicio": citas.tipoServicio,
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

Future<List<dynamic>> deleteCitas(Citas citas, String token) async {
  try {
    final response = await http.post(
      Uri.http('192.168.1.72:9990', '/citas/delete'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode(
        {
          "idCita": citas.idCita,
          "fecha": citas.fecha,
          "hora": citas.hora,
          "tipoServicio": citas.tipoServicio,
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