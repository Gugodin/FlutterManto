class MascotaList {
  final List<Mascota> mascota;

  MascotaList({
    required this.mascota,
  });

  factory MascotaList.fromJson(Map<String, dynamic> parsedJson) {
    Iterable list = parsedJson['mascota'];
    List<Mascota> mascota = list.map((i) => Mascota.fromJson(i)).toList();
    return MascotaList(mascota: mascota);
  }
}

class Mascota {
  final int idMascota;
  final int idDuenio;
  final String nombre;
  final String raza;
  final String fechaIngreso;
  final String razon;

  Mascota({
    required this.idMascota,
    required this.idDuenio,
    required this.nombre,
    required this.raza,
    required this.fechaIngreso,
    required this.razon,
  });

  factory Mascota.fromJson(Map<String, dynamic> json) => Mascota(
    idMascota: json['idMascota'],
    idDuenio: json['idDuenio'],
    nombre: json['nombre'],
    raza: json['raza'],
    fechaIngreso: json['fechaIngreso'],
    razon: json['razon'],
  );
}