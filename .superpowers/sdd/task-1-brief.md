# Task 1 Brief: Crear proyecto Flutter, estructura de carpetas y git

## Context
This is the first task of the constructora_flutter_web Flutter Web scaffold.
Working directory: /Users/emicaroprese/Documents/Programador Artesanal/constructora-flutter-web

The directory already contains: CLAUDE.md, Proyecto.md, Metodologia_Claude_Code.md,
docs/, and .claude/rules/flutter--rules.md. Do NOT modify these files.

## Global Constraints
- Flutter 3.44.3, channel stable, solo web (Chrome)
- Paleta exclusivamente Colors.grey — nunca hex hardcodeados
- Sin modo oscuro — solo ThemeData light
- Un widget por archivo: snake_case archivos, PascalCase clases
- Credenciales Supabase en assets/.env — nunca en el código
- No usar Card, InkWell, BoxShadow ni fuentes custom
- Líneas máximo 80 caracteres, funciones menos de 20 líneas

## Task

**Files:**
- Create (via flutter create): lib/main.dart, pubspec.yaml, analysis_options.yaml, web/, test/
- Create: lib/screens/, lib/widgets/, lib/services/, lib/models/, assets/
- Create: assets/.env
- Modify: .gitignore

**Interfaces:**
- Produces: proyecto Flutter compilable con estructura de carpetas y repo git inicializado

## Steps

- [ ] Step 1: Ejecutar flutter create en la carpeta actual

```bash
flutter create --project-name constructora_flutter_web .
```

Esperado: Flutter genera los archivos base. Los archivos .md y .claude/ existentes no se modifican.

- [ ] Step 2: Crear las carpetas de lib/ y assets/

```bash
mkdir -p lib/screens lib/widgets lib/services lib/models assets
```

- [ ] Step 3: Crear assets/.env con placeholders

Crear assets/.env:
```
SUPABASE_URL=
SUPABASE_ANON_KEY=
```

- [ ] Step 4: Agregar assets/.env al .gitignore

Agregar al final del .gitignore generado por Flutter:
```
# Supabase credentials
assets/.env
```

- [ ] Step 5: Inicializar repositorio git

```bash
git init
git add -A
git commit -m "chore: scaffold inicial Flutter Web"
```

Esperado: commit creado con todos los archivos de Flutter.

- [ ] Step 6: Verificar que el proyecto corre

```bash
flutter run -d chrome
```

Esperado: app corriendo en Chrome mostrando el contador default de Flutter.
Nota: si Chrome se abre y la app carga (aunque muestre el contador default), la verificación pasa.
Podés usar Ctrl+C para cerrar después de confirmar que cargó.

## Report

Write your full report to:
/Users/emicaroprese/Documents/Programador Artesanal/constructora-flutter-web/.superpowers/sdd/task-1-report.md

Return only: status (DONE / BLOCKED / NEEDS_CONTEXT), commit hash, one-line test summary, and any concerns.
