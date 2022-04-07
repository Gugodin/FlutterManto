import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:veterinariamanto/pages/mascotas.dart';
import 'package:veterinariamanto/providers/petModel.dart';

import '../painter/duenio.dart';

String ip = '192.168.1.74';

Future<List<dynamic>> updateDuenio(Usuario usuario, String token) async {
  try {
    final response = await http.post(
      Uri.http(ip, '/user/update'),
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
  try {
    final response = await http.get(
      Uri.http(ip, '/user/listUser'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      }
    );
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
      Uri.http(ip, '/user/delete'),
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

Future<List<dynamic>> updateMascota(Mascota mascota, String token) async {
  try {
    final response = await http.post(
      Uri.http(ip + ':9998', '/mascota/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode({
        "idDuenio": mascota.idDuenio,
        "idMascota": mascota.idMascota,
        "nombre": mascota.nombre,
        "raza": mascota.raza,
        "fechaIngreso": mascota.fechaIngreso,
        "razon": mascota.razon,
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

Future<List<dynamic>> deleteMascota(Mascota mascota, String token) async {
  try {
    final response = await http.post(
      Uri.http(ip + ':9998', '/mascota/delete'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      },
      body: json.encode({
        "idDuenio": mascota.idDuenio,
        "idMascota": mascota.idMascota,
        "nombre": mascota.nombre,
        "raza": mascota.raza,
        "fechaIngreso": mascota.fechaIngreso,
        "razon": mascota.razon,
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

Future<List<dynamic>> getDataById(String token, int id) async {
  var resultado;
  try {
    final response = await http.get(
      Uri.http(ip + ':9998', '/mascota/' + id.toString()),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token
      }
    );
    resultado = json.decode(response.body);
    return resultado;
  } catch (e) {
    return ['Error en la respuesta'];
  }
}