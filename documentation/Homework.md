# Homework — próxima sesión

## 📚 Mini log de proyectos/temas vistos

- **dropsim** (cliente API L2, Swift): funcional — 4/4 milestones. PR #4 mergeado a `release/v0.1` (2026-09-27), cumplido antes del deadline del 2026-09-28. PR #5 mergeado (2026-09-30): `LocalConstants.swift`/`utils.swift` + limpieza de código muerto. Quedan solo mejoras de calidad — SRP en `main.swift` — deferidas a la próxima sesión por volumen de trabajo (ver pendiente abajo).
- **Git:** branch alignment practicado (PR #3, fast-forward limpio), `CheatsheetGit.md` creado.
- **CRUD.swift** (gastos-consola): refactor analizado (notas ya no vigentes, eliminadas 2026-09-29).
- **Notion sync:** skill armada 2026-09-28 (Homework local como fuente de verdad → Notion, con bump de fecha en Inicio).
- **100 Days of Swift:** deprioritizado (2026-09-29) — la próxima semana con Juan se pasa a vistas (UIKit) directamente, no es el foco actual.
- **Limpieza de documentación (2026-09-29):** eliminado `refactor-notes-CRUD-2026-09-06.md` (ya no servía) y un archivo basura `dropsim-plan.md:Zone.Identifier` (metadata de Windows/WSL). `CONTEXT.md` actualizado para reflejar el modo de trabajo actual (Homework.md como fuente de verdad, no el tracker de 100 Days). Notas de teoría de videos ahora van en `ApuntesTeoria.md` (nuevo).
- **Placeholder de `chance` nulo:** descartado (2026-09-29), no se implementa.
- **Convención de mensajes de commit:** no hace falta definirla, viene bien así. Nota informal: Juan suele hacer squash merge por PR (un solo commit) — gusto personal suyo, práctica sugerida, no obligatoria.
- **Teoría — vistas UIKit (ciclo de vida y composición):** explicada 2026-09-29 — ver `ApuntesTeoria.md` para las notas y los videos de referencia.
- **Teoría de la sesión 2026-10-01:** value vs reference types, semver, resolución de conflictos de git (con ejercicio simulado) — todo cerrado, notas en `ApuntesTeoria.md`. Resumen conceptual de AutoLayout/Constraints armado antes de que Christian viera el video correspondiente.
- **Video de MoureDev (ciclo de vida de vistas):** notas cerradas 2026-10-01 — el diagrama `img/uikit-view-lifecycle.png` ya lo sintetiza, documentado en `ApuntesTeoria.md`.
- **Fuente de videos UIKit:** se pasa de videos sueltos a una playlist estructurada (ver "Videos — en curso" abajo) — video actual (#19) es largo (~5hs), se digiere en varias sesiones.

## 🔵 Plan de branches — cerrar `release/v0.1` y abrir `release/v0.2` (dropsim)

Estado real del repo (2026-10-01): `release/v0.1` (5678a3a, PR #5) todavía **no está mergeado a `main`** (main sigue en PR #2, 0947fd0). No hay tag. El refactor SRP pendiente es parte de este mismo ciclo v0.1, no de v0.2.

**Fase 1 — terminar pendientes de v0.1 (feature branch → PR a `release/v0.1`):**
- [ ] Rama `docs/readme-and-structure` (o el nombre que prefieras): actualizar `README.md` + reestructurar carpetas/archivos → commit → push → PR a `release/v0.1` → mergear → borrar rama.
- [ ] Rama `refactor/main-srp`: aplicar el refactor SRP de `main.swift` (ver checklist abajo) → commit → push → PR a `release/v0.1` → mergear → borrar rama.

**Fase 2 — cerrar v0.1:**
- [ ] PR `release/v0.1` → `main`.
- [ ] Mergear (squash o merge commit, a tu gusto).
- [ ] Tag `v0.1.0` en `main`.

**Fase 3 — abrir v0.2:**
- [ ] Crear `release/v0.2` desde `main` (ya con `v0.1.0` tageado) → push a origin.
- [ ] A partir de ahí, cada feature nueva entra como `feature/...` → PR a `release/v0.2`.

## 🔴 Pendiente — dropsim

- [ ] Convertir comentarios sueltos en funciones propias, aplicando Single Responsibility Principle (SOLID). Relevados en `main.swift` (2026-09-30) — va en la rama `refactor/main-srp` del plan de branches arriba:
  - [ ] L45-50: leer input del usuario → `func leerEntrada() -> String?`.
  - [ ] L64-67: imprimir lista de monstruos → `func imprimirMonstruos(_ monstruos: [Monster])`.
  - [ ] L69-87: pedir y resolver selección de monstruo (input, caso 0, validación de rango) → `func seleccionarMonstruo(cantidad: Int) -> Int?`.
  - [ ] L83/L112-115: validación de rango duplicada (monstruo e ítem, marcada por Christian con `//validateInput() DRY`) → `func validarRango(_ valor: Int, en rango: ClosedRange<Int>) -> Bool`.
  - [ ] L90-92: resolver `chance ?? random100()` por drop → `func resolverChances(_ drops: [Drop]) -> [Double]` (candidato a vivir en `Simulator.swift`, no en `main.swift`, que declara "cero red, cero print").
  - [ ] L99-103: imprimir lista de drops → `func imprimirDrops(_ drops: [Drop], chances: [Double])`.

## 💡 Ideas futuras — portfolio (sin empezar)

- **dropsim con cara visual:** Christian quiere que dropsim no quede solo en consola, con la mira en portfolio. Referencia propia ya existente: `C:\Users\csram\pruebal2` — "Return to Aden", un RPG por turnos ya bastante avanzado (Preact + Vite + TS, PWA, datos reales de `l2api.dev`, ya en `v0.1.0` de su propio versionado). No es el mismo proyecto ni se van a fusionar — es la referencia de "a dónde podría llegar" un proyecto de consola si se le agrega una capa visual. Sin plan concreto todavía.
- **Juego de memoria (parejas) con skills de L2:** backend primero (para mostrar con Juan más adelante la parte visual). Una clase de L2 al inicio, expandible a elegir varias clases con sus skills. Nombres e imágenes desde la API si están disponibles, si no buscadas a mano. Mecánica: cartas boca arriba unos segundos → se dan vuelta → el usuario toca dos → si coinciden quedan reveladas/desaparecen, si no, se vuelven a tapar y continúa el loop. **Mecánica principal todavía no está del todo cerrada** (nota de Christian, 2026-10-01) — no arrancar implementación hasta definirla mejor.

## 🎥 Videos — en curso (UIKit)

Fuente actual: ["Curso UIKit en Swift para Principiantes"](https://www.youtube.com/watch?v=y1qkDJFxaLU&list=PLeTOFRUxkMcoVxB1Dkt1Nh_N83XQtqYXQ&index=19), video único de ~5.5hs con 20 capítulos internos (no es una serie de videos separados — esto corrige la suposición anterior). Transcript completo procesado 2026-10-01 y filtrado en `ApuntesUIKit-Curso.md` — resumen por bloque temático, checklist de repaso y studyflow sugerido para las próximas sesiones. En curso, se sigue viendo de a poco.

## 🖥️ Mac en la nube — sin resolver

AWS EC2 Mac mini M1 (`mac2.metal`) investigado 2026-09-28: viable técnicamente, pero cobra por Dedicated Host con mínimo de 24hs por asignación (no importa el uso real dentro de esa ventana). Juan sigue investigando MacinCloud en paralelo. Sin decisión tomada — no prioritario hoy (2026-09-29).
