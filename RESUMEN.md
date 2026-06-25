# Resumen de sesión — Scaffold del proyecto

Este documento es para que Claude Chat explique lo que se hizo.
Emi tiene experiencia básica en Flutter (apps de hábitos, chat, etc.).
El objetivo es entender cada decisión, no solo saber que existe.

---

## Qué se construyó

El scaffold (estructura base) de una app Flutter Web: una app que compila,
corre en Chrome, y tiene toda la arquitectura lista para construir encima.
Todavía no hay datos reales ni conexión a Supabase — eso es la próxima sesión.

---

## 1. Estructura de carpetas

```
lib/
  main.dart
  screens/
    dashboard_screen.dart
  widgets/
    tarea_list.dart
    compra_list.dart
  services/
    tarea_service.dart
    compra_service.dart
  models/
    tarea.dart
    item_compra.dart
assets/
  .env              ← credenciales Supabase (ignorado en git)
```

**Preguntas para explorar:**
- ¿Por qué separar en screens/, widgets/, services/, models/?
- ¿Qué diferencia hay entre un widget y una screen en Flutter?
- ¿Por qué la lógica de Supabase va en services/ y no en los widgets?

---

## 2. Dependencias agregadas

En `pubspec.yaml` se agregaron tres paquetes:

- **supabase_flutter** — el SDK oficial de Supabase para Flutter
- **go_router** — manejo de navegación/rutas de forma declarativa
- **flutter_dotenv** — para leer variables de un archivo `.env` en runtime

**Preguntas para explorar:**
- ¿Qué es pubspec.yaml y cómo funciona el sistema de paquetes en Flutter?
- ¿Por qué go_router en vez del Navigator nativo de Flutter?
- ¿Qué es flutter_dotenv y por qué no hardcodear las credenciales en el código?

---

## 3. El archivo main.dart

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  runApp(const App());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
    );
  }
}
```

**Preguntas para explorar:**
- ¿Por qué main() es async y qué hace WidgetsFlutterBinding.ensureInitialized()?
- ¿Qué es MaterialApp.router y en qué se diferencia de MaterialApp normal?
- ¿Cómo funciona ColorScheme.fromSeed? ¿Qué genera a partir de un color?
- ¿Por qué AppBar transparent con elevation 0?

---

## 4. Los modelos (Tarea e ItemCompra)

```dart
class Tarea {
  final String id;
  final String titulo;
  final String descripcion;
  final bool completada;
  final DateTime fecha;
  final String prioridad;

  const Tarea({...});

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        completada: json['completada'] as bool,
        fecha: DateTime.parse(json['fecha'] as String),
        // ...
      );
}
```

Se eligió `fromJson` escrito a mano en lugar de usar `json_serializable`
(que genera código automáticamente).

**Preguntas para explorar:**
- ¿Qué es un factory constructor en Dart y por qué se usa para fromJson?
- ¿Qué es `Map<String, dynamic>` y de dónde viene ese mapa?
- ¿Por qué todos los campos son `final`?
- ¿Cuándo conviene usar json_serializable y cuándo fromJson manual?

---

## 5. Los placeholders (widgets y services vacíos)

Los widgets (`TareaList`, `CompraList`) devuelven `SizedBox.shrink()` por ahora.
Los services (`TareaService`, `CompraService`) son clases vacías.

```dart
class TareaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // no muestra nada
  }
}
```

**Preguntas para explorar:**
- ¿Qué es SizedBox.shrink() y para qué sirve como placeholder?
- ¿Por qué crear los archivos vacíos ahora y no cuando se necesiten?

---

## 6. Tests con TDD

Para los modelos se usó TDD (Test-Driven Development):
primero se escribió el test (que fallaba), después se implementó el modelo.

```dart
test('fromJson parsea todos los campos correctamente', () {
  final json = {'id': '1', 'titulo': 'Comprar leche', ...};
  final tarea = Tarea.fromJson(json);
  expect(tarea.titulo, 'Comprar leche');
});
```

**Preguntas para explorar:**
- ¿Qué es TDD y por qué escribir el test que falla primero?
- ¿Cómo funciona `flutter test` y dónde viven los tests en un proyecto Flutter?
- ¿Qué testea este test específicamente? ¿Qué NO testea?

---

## 7. El archivo .env y gitignore

Se creó `assets/.env` con las credenciales de Supabase (vacías por ahora):
```
SUPABASE_URL=
SUPABASE_ANON_KEY=
```

Este archivo está en `.gitignore` — nunca se sube a GitHub.

**Preguntas para explorar:**
- ¿Qué riesgo hay si las credenciales van en el código fuente?
- ¿Cómo lee Flutter un archivo .env en runtime?
- ¿Cómo se manejan las credenciales cuando se hace deploy?

---

## 8. El flujo de commits (git)

Se hicieron 5 commits separados, uno por cada "capa" del scaffold:

```
dba13c8  chore: scaffold inicial Flutter Web
33b88bb  chore: agregar dependencias supabase_flutter go_router flutter_dotenv
0898250  feat: configurar tema, go_router y dashboard placeholder
747e5fb  feat: agregar modelos Tarea e ItemCompra con fromJson
a20d6ab  chore: agregar placeholders de services y widgets
```

**Preguntas para explorar:**
- ¿Qué convención de nombres de commits se usó y por qué?
- ¿Por qué hacer commits pequeños en lugar de uno grande al final?

---

## Lo que falta (próxima sesión)

1. Crear el proyecto en Supabase y las tablas `tareas` e `items_compra`
2. Cargar las credenciales en `assets/.env`
3. Implementar `TareaService` y `CompraService` con las queries a Supabase
4. Conectar `DashboardScreen` para mostrar los datos reales
