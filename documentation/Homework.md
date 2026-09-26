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
- [x] Manejar éxito/fracaso de `URLSession` con `try`/`catch` (propagar el error, no tragarlo). Las funciones de `API.swift` son `throws` y no atrapan nada adentro — falta todavía el `do/catch` general en `main.swift` (ver Milestone 4).
- [ ] Búsqueda de monstruo defensiva: si no hay resultado, devolver `nil` — nunca crashear ("no rompamos la wea"). **Todavía no resuelto** (2026-09-26): si `fetchMonsters` devuelve `[]`, el loop no lo detecta — sigue pidiendo un número de selección y explota por índice fuera de rango al indexar `monsterFetch[monsterIndex - 1]`. Falta el guard de array vacío + el loop de "buscar de nuevo".
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
- [ ] Milestone 4 — Pegar todo en `main` (loop de interacción, manejo de input inválido). **En progreso** (2026-09-26, branch `feature/main-loop`): armado el loop de búsqueda de monstruos con mensajes por `enum Mensaje`, selección de monstruo indexando el `id` real (no el número tipeado), y listado de drops con placeholders (`itemName ?? "Desconocido"`, `chance ?? random100()` — ver pregunta para Juan más abajo). Falta: bounds-check en los índices de selección (crashea si el número está fuera de rango), la opción "0 para buscar otro" (prometida en el mensaje pero sin lógica todavía), selección de item + corrida de `simularKills` con el resultado, y el `do/catch` general del loop.

### 📌 Pendiente para la próxima sesión (anotado 2026-09-26)

- **Búsqueda vacía (sin resultados):** sigue sin resolverse — ver el checkbox tachado arriba. `fetchMonsters` puede devolver `[]` legítimamente; hoy el loop no lo distingue y crashea al indexar. Es la prioridad #1 de la próxima sesión junto con el bounds-check general.
- **Flujo completo de `main.swift` (loop + `do/catch` general):** el loop ya existe (Milestone 4 en progreso), pero el `do/catch` que envuelve los `try await` sigue pendiente — hoy un error de red tira el programa entero en vez de mostrarlo como mensaje y volver a pedir el nombre.
- **Pregunta nueva para Juan (2026-09-26):** para el placeholder de `chance` nulo en un drop, ¿tiene sentido usar `random100()` (pensado originalmente para el simulador, no para mostrar datos "reales") o conviene un placeholder de texto tipo `"Chance: desconocida"` para no mezclar dato real con dato inventado? Quedó así por ahora a propósito, a definir en la próxima sesión.
- **Preguntarle a Juan la convención exacta de mensajes de commit** que pidió practicar (un prefijo tipo "Enhance"/"Fix" seguido de `|` y una descripción corta) — no se recuerda el formato exacto ni la lista completa de prefijos. Nota: esto es la convención del repo `dropsim` (supervisado por Juan), distinta de Conventional Commits que se usa en `awi-core` — no hay conflicto, son proyectos separados.
- **Definir qué Mac en la nube contratar (precio/calidad), deadline 2026-09-28.** Necesario para arrancar Días 16+ (proyectos UIKit reales, requieren Xcode/macOS) — hoy no hay Mac ni Xcode disponible, todo lo practicado fue en Linux/swiftfiddle. Pendiente investigar opciones (MacStadium, MacinCloud, AWS EC2 Mac instances, Scaleway Mac mini, etc.) y elegir por costo/calidad antes de esa fecha. **Deadline pasado mañana — quedaría para la última sesión antes del 28.**
- ~~Corregir el desfasaje de branches en `dropsim`~~ — **Resuelto 2026-09-26.** PR #3 (`chore/align-release-v0.1` → `release/v0.1`) trajo el contenido de `main` a `release/v0.1` sin conflictos (verificado de antemano con `git merge-base --is-ancestor` — main era superset limpio de release). Practicado además: inspección de branches divergentes, `gh pr create/merge`, cleanup de branch auxiliar. Nuevo `documentation/CheatsheetGit.md` para ir memorizando. La práctica de conflictos reales sigue pendiente (🟡 arriba) — este align resultó ser fast-forward limpio, sin fricción real.
