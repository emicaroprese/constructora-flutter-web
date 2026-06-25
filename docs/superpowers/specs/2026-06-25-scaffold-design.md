# Scaffold — constructora_flutter_web

## Objetivo

Crear el proyecto Flutter base listo para desarrollar el dashboard: estructura de carpetas, dependencias instaladas, tema configurado y archivos placeholder que compilan desde el primer momento.

## Decisiones

- Scaffold en la carpeta existente (`flutter create .`) para no mover los archivos de definición.
- Opción A: mínima complejidad — sin code generation, sin paquetes de estado externos.
- Estado con `FutureBuilder` / `StreamBuilder` built-in.
- Credenciales Supabase en `assets/.env`, ignorado en `.gitignore`.

## Pasos

1. **flutter create** — `flutter create --project-name constructora_flutter_web .`
2. **Carpetas** — crear `lib/screens/`, `lib/widgets/`, `lib/services/`, `lib/models/`, `assets/`
3. **Dependencias** — agregar `supabase_flutter`, `go_router`, `flutter_dotenv` vía `flutter pub add`
4. **Tema** — configurar `ThemeData` en `main.dart`: paleta `Colors.grey`, `AppBar` transparente, sin modo oscuro
5. **Placeholders** — crear archivos con estructura mínima que compilen:
   - `lib/screens/dashboard_screen.dart`
   - `lib/widgets/tarea_list.dart`, `compra_list.dart`
   - `lib/services/tarea_service.dart`, `compra_service.dart`
   - `lib/models/tarea.dart`, `item_compra.dart`
6. **Verificación** — `flutter run -d chrome` debe mostrar la app corriendo sin errores

## Resultado esperado

App Flutter Web corriendo en Chrome con pantalla vacía, tema configurado, estructura de carpetas completa y todas las dependencias instaladas.
