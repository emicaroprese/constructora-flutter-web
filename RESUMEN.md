# Cómo se construyó el scaffold — paso a paso

Para Claude Chat: explicá esto como una historia en orden, mostrando
cómo cada paso habilitó el siguiente. Emi tiene experiencia básica
en Flutter (apps de hábitos, chat, etc.). El objetivo es entender
el razonamiento detrás de cada decisión, no definiciones aisladas.

---

## El punto de partida

La carpeta solo tenía archivos de documentación (.md). Ningún código Flutter.
Antes de crear nada, había que decidir cómo iba a estar organizado el proyecto.

Se eligió esta estructura:
```
lib/screens/    ← pantallas completas
lib/widgets/    ← piezas reutilizables de UI
lib/services/   ← toda la lógica con Supabase
lib/models/     ← los datos y su forma
```

Esta separación existe porque si la lógica de Supabase viviera dentro
de los widgets, cambiar cómo se conecta la base de datos implicaría
tocar los widgets. Separarlo significa que cada parte tiene una sola
razón para cambiar.

---

## Paso 1: flutter create

```bash
flutter create --project-name constructora_flutter_web .
```

Esto generó el esqueleto de Flutter: el `pubspec.yaml`, el `main.dart`
con el contador de ejemplo, la carpeta `web/`, los archivos de
configuración. El punto es que Flutter ya tiene todo armado para
correr — nosotros lo vamos a reemplazar parte por parte.

También se creó `assets/.env` con las credenciales de Supabase vacías
y se lo agregó al `.gitignore` para que nunca se suba a GitHub.

**Por qué .env y no hardcodear las credenciales:**
Si las credenciales van en el código y el repo es público,
cualquiera puede acceder a tu base de datos. El archivo .env
existe localmente pero git lo ignora.

Se hizo `git init` y el primer commit con todo esto.

---

## Paso 2: agregar las dependencias

Con el esqueleto listo, se agregaron los tres paquetes que la app necesita:

```bash
flutter pub add supabase_flutter go_router flutter_dotenv
```

**supabase_flutter** — el SDK que va a permitir hacer queries a Supabase
desde Flutter. Sin esto, no hay forma de hablar con la base de datos.

**go_router** — manejo de rutas. Flutter tiene su propio sistema de
navegación (`Navigator`), pero go_router es más declarativo: definís
las rutas como una lista, no como instrucciones imperativas. Para web
también maneja las URLs del navegador correctamente.

**flutter_dotenv** — lee el archivo `.env` en runtime y expone las
variables. Así `dotenv.env['SUPABASE_URL']` devuelve el valor sin
que esté en el código.

También se declaró el `.env` en `pubspec.yaml` para que Flutter
lo incluya como asset (como si fuera una imagen o un font):
```yaml
flutter:
  assets:
    - assets/.env
```

Sin esta declaración, Flutter no sabe que ese archivo existe
y no lo puede leer cuando corre.

---

## Paso 3: reescribir main.dart y armar el tema

El `main.dart` que genera Flutter trae el contador de ejemplo.
Se reemplazó completamente por tres cosas:

**Primero, la inicialización:**
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  runApp(const App());
}
```
`main()` es async porque necesita cargar el archivo `.env` antes
de arrancar la app. `WidgetsFlutterBinding.ensureInitialized()`
es necesario cuando hacés cosas async antes de `runApp` — le dice
a Flutter que prepare el motor antes de usarlo.

**Segundo, el router:**
```dart
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
```
Una sola ruta por ahora: la raíz (`/`) muestra `DashboardScreen`.
Cuando agreguemos más pantallas, se agregan acá.

**Tercero, el tema:**
```dart
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
```
El tema se define una sola vez acá y aplica a toda la app.
`ColorScheme.fromSeed` genera una paleta completa a partir de un
color base — en este caso gris. Cualquier widget que use
`Theme.of(context).colorScheme.X` va a heredar estos colores
sin hardcodearlos en cada widget.

Se creó también `DashboardScreen` como un widget mínimo que
solo muestra "Dashboard" en el centro — suficiente para que
la app compile y corra.

---

## Paso 4: los modelos

Antes de construir la UI, se definió la forma de los datos.
Esto importa porque la UI va a mostrar tareas y compras —
necesita saber qué campos tienen.

Se usó TDD: primero se escribió el test que describía cómo
tenía que funcionar `fromJson`, se corrió para ver que fallaba,
y después se implementó el modelo.

**El test primero:**
```dart
test('fromJson parsea todos los campos correctamente', () {
  final json = {
    'id': '1',
    'titulo': 'Comprar leche',
    'completada': false,
    'fecha': '2026-06-25T00:00:00.000Z',
    'prioridad': 'alta',
  };
  final tarea = Tarea.fromJson(json);
  expect(tarea.titulo, 'Comprar leche');
  expect(tarea.completada, false);
});
```

**Después el modelo:**
```dart
class Tarea {
  final String id;
  final String titulo;
  final String descripcion;
  final bool completada;
  final DateTime fecha;
  final String prioridad;

  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea(
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        completada: json['completada'] as bool,
        fecha: DateTime.parse(json['fecha'] as String),
        prioridad: json['prioridad'] as String,
      );
}
```

`fromJson` recibe el mapa que Supabase va a devolver y lo convierte
en un objeto `Tarea`. Los campos son `final` porque una tarea no muta
— si cambia algo, se crea una nueva instancia.

Se eligió escribir `fromJson` a mano en vez de usar `json_serializable`
(que lo genera automáticamente) porque agrega un paso de compilación
extra que complica el flujo de aprendizaje. Para este proyecto, manual
es más claro.

---

## Paso 5: los placeholders

Con los modelos definidos, se crearon los archivos que van a
contener la UI y la lógica de Supabase — vacíos por ahora, pero
en su lugar correcto:

```dart
// tarea_list.dart — widget que mostrará la lista de tareas
class TareaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // no muestra nada todavía
  }
}

// tarea_service.dart — lógica de Supabase para tareas
class TareaService {
  // queries a Supabase — se implementa en la próxima sesión
}
```

¿Por qué crearlos vacíos ahora? Porque la estructura del proyecto
queda definida. Cuando en la próxima sesión se implemente
`TareaService`, ya se sabe exactamente dónde va y cómo se llama.

---

## El resultado

Al final de todo esto, la app:
- Compila sin errores
- Corre en Chrome con la pantalla "Dashboard"
- Tiene el tema configurado (gris, AppBar transparente)
- Tiene los modelos con tests pasando
- Tiene la arquitectura completa lista para construir encima

Lo que no tiene todavía: datos reales. Supabase está como
dependencia instalada pero sin inicializar. Eso es la próxima sesión.

---

## Preguntas que vale la pena explorar con todo esto en contexto

- ¿Por qué el orden importa? (modelos antes que UI, tema antes que widgets)
- ¿Qué hubiera pasado si poníamos la lógica de Supabase directo en los widgets?
- ¿Cómo va a fluir el dato desde Supabase hasta aparecer en pantalla?
  (Supabase → service → widget → UI)
- ¿Qué es el `context` que aparece en casi todos los widgets?
