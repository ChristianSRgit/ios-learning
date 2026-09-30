# Homework — próxima sesión

## 📚 Mini log de proyectos/temas vistos

- **dropsim** (cliente API L2, Swift): funcional — 4/4 milestones. PR #4 mergeado a `release/v0.1` (2026-09-27), cumplido antes del deadline del 2026-09-28. Quedan solo mejoras de calidad (ver pendiente abajo).
- **Git:** branch alignment practicado (PR #3, fast-forward limpio), `CheatsheetGit.md` creado.
- **CRUD.swift** (gastos-consola): refactor analizado (notas ya no vigentes, eliminadas 2026-09-29).
- **Notion sync:** skill armada 2026-09-28 (Homework local como fuente de verdad → Notion, con bump de fecha en Inicio).
- **100 Days of Swift:** deprioritizado (2026-09-29) — la próxima semana con Juan se pasa a vistas (UIKit) directamente, no es el foco actual.
- **Limpieza de documentación (2026-09-29):** eliminado `refactor-notes-CRUD-2026-09-06.md` (ya no servía) y un archivo basura `dropsim-plan.md:Zone.Identifier` (metadata de Windows/WSL). `CONTEXT.md` actualizado para reflejar el modo de trabajo actual (Homework.md como fuente de verdad, no el tracker de 100 Days). Notas de teoría de videos ahora van en `ApuntesTeoria.md` (nuevo).
- **Placeholder de `chance` nulo:** descartado (2026-09-29), no se implementa.
- **Convención de mensajes de commit:** no hace falta definirla, viene bien así. Nota informal: Juan suele hacer squash merge por PR (un solo commit) — gusto personal suyo, práctica sugerida, no obligatoria.
- **Teoría — vistas UIKit (ciclo de vida y composición):** explicada 2026-09-29 — ver `ApuntesTeoria.md` para las notas y los videos de referencia.

## 🔴 Pendiente — dropsim

- [x] Agregar `utils.swift` para funciones auxiliares (2026-09-30, compila y funciona).
- [ ] Convertir comentarios sueltos en funciones propias, aplicando Single Responsibility Principle (SOLID).
- [x] Crear `LocalConstants.swift` (enum con `static let baseURL`) y mover ahí las URLs hardcodeadas de `API.swift` (2026-09-30, aplicado — sin `.gitignore`, porque la API es pública y no usa key).

## 🟡 Teoría pendiente — repasar

- [ ] Formato de datos y tipos de datos distintos.
- [ ] Versionado semver de git (major.minor.patch).
- [ ] Resolución de conflictos de git.
- [ ] Qué es una vista, cómo se compone, y su ciclo de vida (UIKit) — en curso, ver videos abajo.

### Videos recomendados — vistas y su ciclo de vida (UIKit)

**Ciclo de vida:**
- [Ciclo de vida de una vista en iOS — MoureDev](https://www.youtube.com/watch?v=SKMCwUeB4Do) (español, elegido por Christian 2026-09-29)
- [UIViewController Lifecycle in Swift: viewDidLoad or viewWillAppear?](https://www.youtube.com/watch?v=MjmyuEwEaxw) (inglés, alternativa)

**Qué es una vista y cómo se compone:**
- [Cómo crear vistas por código con UIKit y AutoLayout (Constraints)](https://www.youtube.com/watch?v=c3PZ-HZKI68) (español)
- Playlist SwiftBeta — [Curso UIKit desde cero, en español](https://www.youtube.com/playlist?list=PLeTOFRUxkMcoVxB1Dkt1Nh_N83XQtqYXQ) (encontrada por Christian 2026-09-29):
  - [Video #3](https://www.youtube.com/watch?v=SEwJyoQgkmg&list=PLeTOFRUxkMcoVxB1Dkt1Nh_N83XQtqYXQ&index=3)
  - [Video #18](https://www.youtube.com/watch?v=y1qkDJFxaLU&list=PLeTOFRUxkMcoVxB1Dkt1Nh_N83XQtqYXQ&index=18)
- [Intro to UIKit and UIViews | iOS and Swift](https://www.youtube.com/watch?v=w58ncTHKiK4) (inglés — frame vs bounds, jerarquía de vistas)

## 🖥️ Mac en la nube — sin resolver

AWS EC2 Mac mini M1 (`mac2.metal`) investigado 2026-09-28: viable técnicamente, pero cobra por Dedicated Host con mínimo de 24hs por asignación (no importa el uso real dentro de esa ventana). Juan sigue investigando MacinCloud en paralelo. Sin decisión tomada — no prioritario hoy (2026-09-29).
