Ver `refactor-notes-CRUD-2026-09-06.md` para el análisis del refactor de CRUD.swift (defensa + regresiones encontradas) antes de la sesión.

## Nuevo ejercicio: dropsim (cliente de API L2)

- Link de api: https://docs.l2api.dev — pero si encontrás alguna mejor o más fácil, listo.
- Creación de proyecto, con su repo en git.
- Creación de estructura de proyecto. Separar funcionalidades / responsabilidades / modelos.
- No olvidar buenas prácticas. Metodologías. KISS. SOLID.
- Error handling try/catch.
- Data types / mapeos de datos de la API / decode / encode / parse json / formateo — URLSession (investigar Alamofire).
- Mejores prácticas que recomiende Claudito. Tomarlas con pinzas, evaluarlas y revisar si realmente valen la pena. No es verdad absoluta.
- Principalmente listado. Filtrado por categoría. Empezar a investigar caches con los llamados a la API.

## Llamada 2026-09-21 con Juan

### 🔴 Urgente — deadline 2026-09-28 (semana que viene)

Objetivo único de Juan: que el programa devuelva sí o sí el monstruo buscado y su tabla de items/drops, conectado a la API real (no mocks). Equivale al Milestone 2 de `docs/dropsim-plan.md`.

- [x] Reemplazar los JSON hardcodeados en `API.swift` por llamadas reales con `URLSession` + `async/await`. Completado 2026-09-24.
- [x] Manejar éxito/fracaso de `URLSession` con `try`/`catch` (propagar el error, no tragarlo). **Completado y probado 2026-09-27:** `main.swift` ahora envuelve el loop en `do/catch` general. Probado en vivo rompiendo la URL a propósito (host inexistente) — el error de red se muestra como mensaje y el programa vuelve a pedir el nombre, no crashea.
- [x] Búsqueda de monstruo defensiva: si no hay resultado, devolver `nil` — nunca crashear ("no rompamos la wea"). **Resuelto 2026-09-27:** `monsterFetch.isEmpty` corta con mensaje antes de pedir selección. De yapa se cubrieron dos casos más encontrados en el camino: string vacío en la búsqueda (no llega ni a llamar la API) y `dropsFetch.drops.isEmpty` (monstruo válido pero sin tabla de drops — caso real, encontrado probando con "Cat's Eye Bandit").
- [x] Devolver el monstruo + su tabla de drops end-to-end (los dos endpoints conectados). Completado 2026-09-26: el loop de `main.swift` conecta búsqueda → selección → `id` real → drops, sin hardcodear nada.
- [ ] Preguntarle a Juan: closures, ¿como alternativa a async/await o es un tema aparte?

### 🟡 Conceptual — repasar esta semana, no bloquea el código

- [ ] Formato de datos y tipos de datos distintos.
- [ ] Versionado semver de git (major.minor.patch).
- [ ] Resolución de conflictos de git.
- [ ] Qué es una vista, cómo se compone, y su ciclo de vida (UIKit — Juan aclaró que no es SwiftUI).

### ✅ Progreso — dropsim (simulador de drop rate L2)

- [x] Milestone 1 — Los modelos: structs `Codable` (`MonstersResponse`, `Monster`, `DropsResponse`, `Drop`), decoding validado contra JSON hardcodeado. Completado 2026-09-18.
- [x] Milestone 2 — Traer datos reales (`async`/`await`, `URLSession`). **Completado 2026-09-24**: `fetchMonsters` y `fetchMonsterDrops` conectados a la API real (no mocks). Detalle de la sesión: gotcha de Linux (`FoundationNetworking` aparte de `Foundation`), gotcha de SwiftPM (solo `main.swift` admite código ejecutable suelto — un archivo `Main.swift` duplicado por mayúscula rompía el build). Queda pendiente conectar el id del primer resultado de búsqueda al llamado de drops (hoy están probados por separado, con un id hardcodeado).
- [x] Milestone 3 — El simulador (`simularKills`, cero red, cero print).
- [x] Milestone 4 — Pegar todo en `main` (loop de interacción, manejo de input inválido). **Completado 2026-09-27** (branch `feature/main-loop`, todavía sin PR): loop completo búsqueda → selección de monstruo (con "0" para cancelar y volver a buscar) → selección de item → `simularKills` → resultado. Casos raros cubiertos: búsqueda vacía, string vacío, monstruo sin tabla de drops, número fuera de rango, error de red (`do/catch` general, probado en vivo). Bug encontrado y resuelto en el camino: la chance de cada drop se resolvía con `random100()` dentro del `for` que la mostraba, y se recalculaba de nuevo (con otro valor) al simular — se fijó calculando un array `chances` una sola vez con `.map` antes de mostrar la lista, reutilizado tanto para mostrar como para simular. Pendiente de pulir (no bloqueante, decisión consciente de dejarlo así por hoy): el prompt "Ingrese el nombre..." solo se reimprime en 2 de los 7 `continue` del loop — se entiende igual, se prolija después.

### 📌 Pendiente para la próxima sesión (anotado 2026-09-27)

- **Pregunta para Juan:** para el placeholder de `chance` nulo en un drop, ¿tiene sentido usar `random100()` (pensado originalmente para el simulador, no para mostrar datos "reales") o conviene un placeholder de texto tipo `"Chance: desconocida"` para no mezclar dato real con dato inventado? Quedó con `random100()` a propósito, a definir con Juan.
- **Preguntarle a Juan la convención exacta de mensajes de commit** que pidió practicar (un prefijo tipo "Enhance"/"Fix" seguido de `|` y una descripción corta) — no se recuerda el formato exacto ni la lista completa de prefijos. Nota: esto es la convención del repo `dropsim` (supervisado por Juan), distinta de Conventional Commits que se usa en `awi-core` — no hay conflicto, son proyectos separados.
- ~~PR de `feature/main-loop` → `release/v0.1`~~ — **Mergeado 2026-09-27** (PR #4, sin conflictos). Milestone 4 ya vive en `release/v0.1`.
- **Pulir el reprint del prompt de búsqueda** en `main.swift` (ver nota en Milestone 4 arriba) — mover el `print` de `Mensaje.monsterSearch` a la primera línea del `while`, para no tener que repetirlo en cada rama. Cosmético, no urgente.
- **Definir qué Mac en la nube contratar — todavía sin resolver, deadline 2026-09-28 mañana.** Se investigó XCodeClub (descartado: cuenta de X sin actividad desde 2023 + reviews recientes de abril 2026 con acusaciones serias de "scam"/sin reembolsos) y MacinCloud (empresa legítima, 16 años, pero el precio de $25-29 que parecía mensual es **semanal** — el costo real ronda los $36+/mes, y pagando desde Argentina con tarjeta o Lemon se estima que se duplica por impuestos/conversión). **Sin decisión tomada.** Se frenó la investigación por consumir demasiado tiempo de sesión — retomar cuando haya cabeza para esto, no es bloqueante para el código.
- **Notion:** Christian pidió que actualizar Notion sea una skill de AWI (bump de fecha en Inicio + Homework local como fuente de verdad, formatear antes de subir) — anotado, no construido todavía, no bloqueante.
- ~~Corregir el desfasaje de branches en `dropsim`~~ — **Resuelto 2026-09-26.** PR #3 (`chore/align-release-v0.1` → `release/v0.1`) trajo el contenido de `main` a `release/v0.1` sin conflictos (verificado de antemano con `git merge-base --is-ancestor` — main era superset limpio de release). Practicado además: inspección de branches divergentes, `gh pr create/merge`, cleanup de branch auxiliar. Nuevo `documentation/CheatsheetGit.md` para ir memorizando. La práctica de conflictos reales sigue pendiente (🟡 arriba) — este align resultó ser fast-forward limpio, sin fricción real.
