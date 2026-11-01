# Cheatsheet: Armado de pantallas UIKit (por código, sin Storyboard)

Notas de las sesiones armando pantallas de CirujeAR. Vocabulario nuevo + puntos donde costó más, para repasar antes de la próxima sesión.

---

## 2026-10-31 — Dashboard (primera pantalla)

### Conceptos tocados
- `UILabel`, `UIView` como caja de color placeholder.
- `UIStackView` — `axis` (`.vertical` / `.horizontal`), `spacing`, `addArrangedSubview`, y **stacks anidados** (un stack horizontal metido como hijo de uno vertical).
- `NSLayoutConstraint` a mano: `topAnchor`, `leadingAnchor`, `trailingAnchor`, `centerXAnchor`, `centerYAnchor`, `widthAnchor`, `heightAnchor`.
- `translatesAutoresizingMaskIntoConstraints = false` — obligatorio en vistas con constraints manuales; **no hace falta** en vistas agregadas a un stack con `addArrangedSubview` (el stack lo hace solo).
- `view.safeAreaLayoutGuide` (evita notch/Dynamic Island) vs `view.layoutMarginsGuide` (márgenes laterales estándar de Apple, sin inventar un `constant` a mano).
- `.layer.cornerRadius` para redondear esquinas de una `UIView`.
- Colores semánticos del sistema (`.systemGray5`) en vez de RGB fijo.

### Dónde costó más
- **Errores de tipeo en nombres de variable** (`sectionStack` vs `sectionsStack`): pasó dos veces seguidas en el mismo bloque — declarás la variable con un nombre y después la referenciás con otro ligeramente distinto. Swift no avisa hasta compilar ("cannot find in scope"). Antes de compilar, conviene un repaso visual rápido: ¿todas las apariciones de esa variable dicen exactamente lo mismo?
- **`equalTo:` vs `equalToConstant:`**: no quedó claro al primer pasaje. Quedó resuelto comparando dos líneas propias lado a lado:
  - `equalTo:` → relativo a **otra ancla** (ej. `titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)`). Se usa casi siempre para *posición*.
  - `equalToConstant:` → valor **fijo** en puntos, sin relación a nada (ej. `card.widthAnchor.constraint(equalToConstant: 100)`). Se usa para *tamaño* fijo.

### Pendiente (anotado, no bloquea)
- ~~El proyecto Xcode vive solo en la VM... falta definir el flujo de git/push desde la VM.~~ Resuelto 2026-11-01 con `/ios-sync`: no hay auth de git/GitHub en la VM, así que el flujo es rsync VM → clon local → commit/push desde WSL.

---

## 2026-11-01 — Dashboard (scroll horizontal + ranking placeholder)

### Conceptos tocados
- `UIScrollView` — separación visor (`frameLayoutGuide`) vs contenido scrolleable (`contentLayoutGuide`); patrón para "congelar" un eje y lograr scroll en una sola dirección. Detalle completo y los 2 bugs de hoy (vista colgada de un padre desconectado + crash de AutoLayout sin ancestro común) en `ApuntesTeoria.md` — acá solo el resumen rápido.
- `showsHorizontalScrollIndicator = false` — oculta la barrita de scroll, cosmético.
- Tipo tupla como placeholder de datos: `[(name: String, points: Int)]` — suficiente para maquetar antes de tener un `struct`/modelo real.
- Build manual desde Xcode GUI en la VM (sin SSH): elegir dispositivo en el selector de arriba a la izquierda + ▶️/`Cmd+R`; errores aparecen en el Issue Navigator (`Cmd+5`) o en el Debug area si crashea en runtime.

### Dónde costó más
- Mismo patrón de tipeo que el 2026-10-31, pero esta vez en nombres de variable nuevos (`cardsScrollView` escrito como `cardScrollView`/`cardsScrollView.translateAutoresizingMaskIntoConstraints` sin la `s`) — confirma que vale la pena el repaso visual antes de compilar, en particular con nombres largos/nuevos.
- **Bug de lógica, no de tipeo:** `sectionsStack.addArrangedSubview(cardsStack)` en vez de `cardsScrollView` — código válido, compila, pero deja la vista de contenido huérfana de la jerarquía de pantalla. No lo agarra el compilador, solo se nota corriendo la app (o, peor, recién crashea más adelante cuando se agrega otra constraint que sí cruza esa jerarquía rota). Lección: con AutoLayout, "compila" no es sinónimo de "la relación entre vistas es correcta".

### Pendiente (anotado, no bloquea)
- Fila de UI por cada cirujano de `topCirujanos` (nombre + puntos), agregada al stack de "Cirujanos TOP" — primer paso de la próxima sesión.
- Pase de estilo visual con la paleta neo-brutalista (`docs/public/paleta-neo-brutalismo.jpg`) — sin fecha, después de tener más pantallas armadas.
