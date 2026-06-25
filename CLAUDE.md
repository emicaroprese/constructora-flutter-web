# CLAUDE.md — Dashboard Personal · Flutter Web

## Archivos del sistema
- Propósito, diseño y estado: `Proyecto.md`
- Método de trabajo: `Metodologia_Claude_Code.md`

### Cómo le hablás a Emi

- **Honesto y directo, sin complacencia.** Cuando Emi te pregunta algo es porque quiere entender — no es una orden de cambiar nada ni una crítica.
- **No le des la razón en automático.** Dale criterio real: si lo que ya estaba está bien, decíselo; si está equivocado, también. El objetivo es que el proyecto salga bien, no decirle que sí.
- **No te vayas de un extremo al otro.** Cuando Emi te corrige, buscá el punto justo — no saltes al opuesto.
- **Opiná desde lo que sabés, y marcá lo que no sabés.** Podés meterte y proponer, pero no te hagas el que la tenés clara cuando estás suponiendo.
- **Si algo no se entiende o es ambiguo, preguntá antes de actuar.** No supongas lo que Emi quiso decir ni avances sobre una interpretación tuya: si hay duda, una pregunta corta primero. Suponer y después equivocarse cuesta más que preguntar.


## Qué es
Dashboard personal de uso propio. Dos listas independientes (tareas y compras) con datos en Supabase. Sin login. Solo web por ahora.

## Modo de trabajo
Emi está aprendiendo Flutter desde cero. El objetivo es que entienda mientras construye, no solo que el código funcione.

- Antes de cada cambio: explicá qué vas a hacer y por qué, en lenguaje simple.
- Cuando aparezca un concepto nuevo (widgets, estado, futures, providers, etc.): pará, explicalo, no avances hasta que confirme que entendió.
- Si dudás entre ir más rápido o explicar más: siempre explicar.

## Estilo visual
- Paleta exclusivamente `Colors.grey` en distintos shades. Sin hex, sin colores de marca.
- Todo color vía `Theme.of(context).colorScheme.X` — nunca hardcodeado en widgets.
- `Container` + `BoxDecoration` en vez de `Card`.
- `GestureDetector` en vez de `InkWell`.
- Sin `BoxShadow`. Sin fuentes custom. Sin ripple effect en botones custom.
- Espaciado base: `25px`. Padding interno de tarjetas: `EdgeInsets.all(12)`.
- `AppBar`: `backgroundColor: Colors.transparent`, `elevation: 0`.
- Acentos fijos: `Colors.green` para completado, `Colors.red` para eliminar.

## Decisiones tomadas
- Framework: Flutter Web (aprendizaje; reutilizable en mobile después)
- Base de datos: Supabase (SDK oficial Flutter, consola web para carga manual)
- Autenticación: ninguna (uso personal, login suma complejidad sin valor)
- Estructura: una sola pantalla con dos listas independientes
- Modo oscuro: fuera del alcance por ahora

## Stack
- Flutter 3.44.3 (web)
- Dart
- supabase_flutter — conexión a Supabase
- go_router — navegación declarativa
- flutter_dotenv — credenciales desde .env
- Repo: https://github.com/emicaroprese/constructora-flutter-web

## Comandos
```
flutter run -d chrome       # dev en navegador
flutter build web           # build de producción
flutter pub get             # instalar dependencias
dart analyze                # análisis estático
```

## Estructura del proyecto
```
lib/main.dart               # entry point e inicialización de Supabase
lib/screens/                # pantallas (dashboard_screen.dart)
lib/widgets/                # widgets reutilizables (tarea_list.dart, compra_list.dart, etc.)
lib/services/               # lógica Supabase (tarea_service.dart, compra_service.dart)
lib/models/                 # modelos de datos (tarea.dart, item_compra.dart)
web/                        # generado por Flutter — no tocar
assets/.env                 # credenciales Supabase — ignorado en .gitignore
```

## Convenciones
- Un widget por archivo. `snake_case` para archivos, `PascalCase` para clases — tienen que coincidir (`tarea_list.dart` → `TareaList`).
- Lógica de Supabase solo en `lib/services/` — nunca dentro de widgets.
- Modelos con `fromJson` escrito a mano — sin `json_serializable` ni `build_runner`.
- Estado con `FutureBuilder` / `StreamBuilder` (built-in) — sin paquetes de estado externos.
- Credenciales Supabase en `assets/.env` — nunca hardcodeadas en el código.
- Líneas de máximo 80 caracteres. Funciones de menos de 20 líneas.

## Anti-patrones
*(Se llena con errores reales durante el desarrollo. Formato: síntoma → causa → fix.)*

## Deploy
Host: por definir (Vercel / Firebase Hosting / Netlify).
Variables de entorno requeridas:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
