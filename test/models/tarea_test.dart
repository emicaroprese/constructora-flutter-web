import 'package:flutter_test/flutter_test.dart';
import 'package:constructora_flutter_web/models/tarea.dart';

void main() {
  group('Tarea', () {
    test('fromJson parsea todos los campos correctamente', () {
      final json = <String, dynamic>{
        'id': '1',
        'titulo': 'Comprar leche',
        'descripcion': 'En el super',
        'completada': false,
        'fecha': '2026-06-25T00:00:00.000Z',
        'prioridad': 'alta',
      };

      final tarea = Tarea.fromJson(json);

      expect(tarea.id, '1');
      expect(tarea.titulo, 'Comprar leche');
      expect(tarea.descripcion, 'En el super');
      expect(tarea.completada, false);
      expect(tarea.prioridad, 'alta');
    });
  });
}
