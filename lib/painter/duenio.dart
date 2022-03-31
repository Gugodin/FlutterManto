class UsuarioList {
  final List<Usuario> usuario;

  UsuarioList({
    required this.usuario,
  });

  factory UsuarioList.fromJson(Map<String, dynamic> parsedJson) {
    Iterable list = parsedJson['usuarios'];

    List<Usuario> usuario = list.map((i) => Usuario.fromJson(i)).toList();

    return new UsuarioList(usuario: usuario);
  }
}

class Usuario {
  final int idUsuario;
  final String nombre;
  final String password;
  final String rol;
  final String primerNombre;
  final String apellido;

  Usuario({
    required this.idUsuario,
    required this.nombre,
    required this.password,
    required this.rol,
    required this.primerNombre,
    required this.apellido,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json['idUsuario'],
        nombre: json['nombre'],
        password: json['password'],
        rol: json['rol'],
        primerNombre: json['primerNombre'],
        apellido: json['apellido'],
      );
}
