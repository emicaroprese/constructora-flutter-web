import 'package:flutter_test/flutter_test.dart';
import 'package:constructora_flutter_web/models/item_compra.dart';

void main() {
  group('ItemCompra', () {
    test('fromJson parsea todos los campos correctamente', () {
      final json = <String, dynamic>{
        'id': '1',
        'nombre': 'Leche',
        'cantidad': 2,
        'precio': 1.50,
        'comprado': false,
      };

      final item = ItemCompra.fromJson(json);

      expect(item.id, '1');
      expect(item.nombre, 'Leche');
      expect(item.cantidad, 2);
      expect(item.precio, 1.50);
      expect(item.comprado, false);
    });
  });
}
