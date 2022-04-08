// import 'dart:_http';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:veterinariamanto/providers/modelo_citas.dart';
import 'package:veterinariamanto/providers/sesion_info.dart';

String ip = '172.17.151.137';
Future<List<dynamic>> login(String usuario, String password) async {
  try {
    final response = await http.post(Uri.http(ip + ':18080', '/user/login'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({"username": usuario, "password": password}));

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

Future<List<dynamic>> get_mascotas_all(String token) async {
  var resultado;
  print('object');
  try {
    final response =
        await http.get(Uri.http(ip + ':9998', '/listMascotas'), headers: {
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

Future<List<dynamic>> get_citas_all(String token) async {
  var resultado;
  print('object');
  try {
    final response =
        await http.get(Uri.http(ip + ':9990', '/listCita'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: token
    });

    // body: json.encode({"username": usuario, "password": password}));
    resultado = json.decode(response.body);
    //print(resultado);
    return resultado;
  } catch (e) {
    return ['Error en la respuesta'];
  }
}

Future<List<dynamic>> updateCitas(Citas citas, String token) async {
  try {
    final response = await http.post(
      Uri.http(ip + ':9990', '/cita/update'),
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
      Uri.http(ip + ':9990', '/cita/delete'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token,
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
      print('a');
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

Future<List<dynamic>> get_mascotas_id(String token, int id) async {
  var resultado;

  try {
    final response = await http
        .get(Uri.http(ip + ':9998', '/mascota/' + id.toString()), headers: {
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
