# Dashboard Personal · Flutter Web

_Documento de diseño y estado del proyecto_

*Fuente de verdad de propósito, diseño y decisiones. El CLAUDE.md tiene el QUÉ técnico estable; este doc tiene el POR QUÉ. El as-built técnico vive en el código del repo.*

---

# 0. Objetivo principal

**Emi está aprendiendo Flutter.** El dashboard es el resultado, pero el verdadero objetivo es **aprender Flutter y Supabase construyendo algo real**. Esto cambia las reglas:

- **El ritmo lo marca el aprendizaje, no la velocidad de entrega.** Tener todo listo en dos días sin entender nada es fracaso. Tener la mitad en dos semanas y entender cómo funciona es éxito.
- **Toda decisión técnica se explica.** Tanto Claude chat como Claude Code tienen que explicar el por qué de cada cosa en lenguaje simple, sin asumir conocimiento previo de Flutter o Dart.
- **Cuando aparece un concepto nuevo** (widgets, estado, providers, futures, streams, etc.): se para, se explica con palabras simples, y no se avanza hasta que Emi confirme que entendió.
- Si en algún momento Claude avanza sin que Emi entienda, **se detiene y se explica**. No es opcional.

Este principio prima sobre cualquier otra prioridad del proyecto.

---

# 1. Visión general

Dashboard personal de uso propio. Muestra dos listas independientes — tareas y compras — con datos cargados manualmente en Supabase. Permite marcar ítems como completados desde la app.

| Dato | Valor |
| --- | --- |
| Fase actual | Scaffold completo — listo para conectar Supabase |
| Stack | Flutter Web + Supabase |
| Deploy | Pendiente |
| Dominio | Pendiente |
| Repo | https://github.com/emicaroprese/constructora-flutter-web |

---

# 2. Propósito y audiencia

**¿Quién usa esto?** Solo Emi. No hay usuarios externos, no hay login, no hay roles.

**¿Para qué?** Ver y gestionar dos listas personales: tareas y compras. Los datos los carga Emi directamente en Supabase; la app los muestra y permite marcarlos como completados.

**¿Qué tiene que dejar hacer?**
- Ver la lista de tareas y marcar tareas como completadas.
- Ver la lista de compras y marcar ítems como comprados.

No hay más acciones por ahora.

---

# 3. Contenido y secciones

**Estructura:** una sola pantalla de dashboard con las dos listas visibles. Sin navegación entre páginas por ahora.

**Lista de tareas**

Campos por tarea:
- Título
- Descripción
- Completada (sí/no) — se puede cambiar desde la app
- Fecha
- Prioridad

**Lista de compras**

Campos por ítem:
- Nombre
- Cantidad
- Precio
- Comprado (sí/no) — se puede cambiar desde la app

Las dos listas son completamente independientes entre sí. No hay relación entre ellas.

---

# 4. Estilo visual

**Referencia:** dashboard estilo Apple. Limpio, ordenado, mucho espacio en blanco, tipografía clara, sin decoración innecesaria.

**Modo:** solo claro. Modo oscuro queda fuera del alcance por ahora.

**Prioridad:** que funcione. El diseño acompaña pero no es el foco de este proyecto.

### Patrones visuales observados en proyectos anteriores

**Paleta**
- Exclusivamente `Colors.grey` en distintos shades. Sin valores hex, sin colores de marca.
- Todo vía `colorScheme.X` — nunca hardcodeado en los widgets.
- `inversePrimary` = texto principal (siempre el extremo opuesto del fondo en la escala de gris).
- Únicos acentos fijos: `Colors.green` (completado/éxito) y `Colors.red` (eliminar).

**AppBar**
- Siempre `backgroundColor: Colors.transparent` + `elevation: 0`. Completamente invisible, se funde con el fondo.
- Sin título en la mayoría de casos, o solo el ícono hamburguesa.

**Tarjetas y contenedores**
- `BorderRadius.circular(8)` para tiles de lista.
- `BorderRadius.circular(12)` para contenedores más grandes (panel de settings).
- Color de fondo: siempre un shade de gris levemente distinto al del Scaffold.

**Botones**
- Sin `ElevatedButton` ni `TextButton`. Los botones custom son `GestureDetector` + `Container`.
- `FloatingActionButton` para la acción principal de crear/agregar.
- `MaterialButton` sin estilo solo para acciones de dialogs.
- Sin ripple effect en botones custom.

**Tipografía**
- Casi sin estilos explícitos — todo hereda los defaults de Material.
- Cuando hay un heading grande: `fontSize: 48` (solo `notes_app_1`).
- `fontWeight: FontWeight.bold` en texto de botones y labels de settings.
- Sin `fontFamily` custom (excepción: `notes_app_1` usa `DM Serif Text` solo para el título).

**Espaciado**
- Unidad universal: `25px` — padding horizontal de contenedores, márgenes de tarjetas, `SizedBox` verticales.
- Padding interno de tarjetas: `EdgeInsets.all(12)`.
- Separador secundario: `SizedBox(height: 10)`.

**Íconos**
- Todos de `Icons.*` (Material). Sin tamaño ni color explícito en la mayoría — heredan del tema.

**Settings page** (patrón idéntico en todos los proyectos que la tienen)
- Un `Container` con `Row(spaceBetween)`: texto "Dark Mode" a la izquierda + `CupertinoSwitch` a la derecha.

**Lo que no aparece en ningún proyecto**
- `Card`, `InkWell`, `BoxShadow`, fuentes custom, colores hex, colores de acento/marca, imágenes decorativas.

---

# 5. Performance / SEO / accesibilidad

- **SEO:** no aplica. Es una app de uso personal, no necesita ser indexada.
- **Performance:** no es prioridad para esta etapa. Flutter Web tiene sus propias particularidades de carga; se revisa si se vuelve un problema real.
- **Accesibilidad:** contraste adecuado por defecto con el estilo claro. Sin requisitos adicionales por ahora.

---

# 6. Decisiones y su fundamento

| Decisión | Elegido | Por qué |
| --- | --- | --- |
| Framework | Flutter Web | Es lo que Emi está aprendiendo; permite reutilizar lo aprendido en mobile más adelante |
| Base de datos | Supabase | Backend listo para usar sin configurar servidor; tiene SDK oficial para Flutter y consola web para cargar datos manualmente |
| Autenticación | Ninguna por ahora | Es uso personal; el login suma complejidad sin aportar valor en esta etapa |
| Plataforma | Solo web | Más simple para arrancar; mobile queda para cuando el aprendizaje avance |
| Estructura | Una sola pantalla | Reduce complejidad de navegación; ideal para aprender los fundamentos primero |
| Modo oscuro | No | Duplica el trabajo de diseño; queda para más adelante si se decide |

---

# 7. Roadmap

**MVP (lo mínimo para que funcione):**
- Conexión a Supabase funcionando
- Lista de tareas visible con todos sus campos
- Lista de compras visible con todos sus campos
- Marcar tarea como completada (actualiza en Supabase)
- Marcar ítem de compras como comprado (actualiza en Supabase)
- Deploy básico con URL accesible

**V2:**
- Agregar y eliminar ítems desde la app (sin tener que ir a Supabase)
- Filtros: ver solo pendientes, ver solo completados
- Mejor diseño visual

**Largo plazo:**
- Login para acceso seguro
- Versión mobile
- Más tipos de listas

---

# 8. Estado / dónde vamos

*Única sección volátil. Se actualiza al cierre de cada sesión que cambió algo.*

### Estado actual

Scaffold completo. Repo en GitHub. App compila y pasa `dart analyze`. Lista para conectar Supabase.

### Próximo paso

1. Crear cuenta y proyecto en Supabase.
2. Crear tablas `tareas` e `items_compra` en Supabase.
3. Cargar las credenciales en `assets/.env`.
4. Implementar `TareaService` y `CompraService` en `lib/services/`.
5. Conectar `DashboardScreen` con los servicios.

### Pendientes / decisiones abiertas

- Decidir dónde hacer el deploy (Vercel, Firebase Hosting, Netlify — a evaluar cuando llegue el momento).

### Changelog reciente

- **Sesión 1 (inicio del proyecto):** definición completa. Stack: Flutter Web + Supabase. Una pantalla, dos listas independientes, sin login. Estilo: limpio tipo Apple, solo modo claro. Objetivo principal: aprendizaje.
- **Sesión 2 (scaffold):** scaffold completo con Flutter 3.44.3. Estructura de carpetas, dependencias (supabase_flutter, go_router, flutter_dotenv), tema gris, go_router, modelos Tarea e ItemCompra con fromJson y tests. Repo creado en GitHub y pusheado.

---

# 9. Técnico

Pendiente — completar cuando el proyecto exista.

### Comandos

### Estructura de carpetas



**Visual**
- Paleta exclusivamente `Colors.grey`; nunca hex hardcodeados en widgets. Todo vía `Theme.of(context).colorScheme.X`.
- `AppBar`: `backgroundColor: Colors.transparent`, `elevation: 0` — se funde con el fondo.
- Espaciado base: `25` (padding horizontal, márgenes de tarjetas, separadores verticales).
- `BorderRadius.circular(8)` para tiles; `BorderRadius.circular(12)` para contenedores. Sin sombras.


---

# 10. Anti-patrones

Pendiente — completar con errores reales que ocurran durante el desarrollo.

*Formato: "No hacer X porque causó Y."*
