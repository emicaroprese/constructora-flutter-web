class ItemCompra {
  final String id;
  final String nombre;
  final int cantidad;
  final double precio;
  final bool comprado;

  const ItemCompra({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.precio,
    required this.comprado,
  });

  factory ItemCompra.fromJson(Map<String, dynamic> json) => ItemCompra(
        id: json['id'] as String,
        nombre: json['nombre'] as String,
        cantidad: json['cantidad'] as int,
        precio: (json['precio'] as num).toDouble(),
        comprado: json['comprado'] as bool,
      );
}
