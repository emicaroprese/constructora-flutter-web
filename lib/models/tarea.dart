class Tarea {
  final String id;
  final String titulo;
  final String descripcion;
  final bool completada;
  final DateTime fecha;
  final String prioridad;

  const Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.completada,
    required this.fecha,
    required this.prioridad,
  });

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        descripcion: json['descripcion'] as String,
        completada: json['completada'] as bool,
        fecha: DateTime.parse(json['fecha'] as String),
        prioridad: json['prioridad'] as String,
      );
}
