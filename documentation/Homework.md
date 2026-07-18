## Próxima sesión (2026-07-18 → pendiente)
- **Día 8 en curso** — quedó en: https://www.hackingwithswift.com/quick-start/understanding-swift/whats-the-difference-between-a-function-and-a-method
- Temas vistos hoy: computed properties, `didSet`/`willSet` (cheatsheet sección 14)
- Pendiente del Día 8: `mutating` methods y lo que sigue

Enums vs estructs y casos de uso (repaso rápido, ya cubierto en cheatsheet sección 8)

## Repasado (sesión 2026-07-15)
- Principios SOLID (S/O/L/I/D) con ejemplos en dominio SMASH, agregado al cheatsheet (sección 13). Apoyado en protocols/protocol extensions (secciones 9 y 10) — en Swift se prioriza composición sobre herencia.

## Repasado (sesión 2026-07-16)
- **Cierra el Día 7 de 100 Days of Swift.** Trailing Closure Syntax: cuando un closure es el **último parámetro** de una función, se saca de los `()` y se escribe pegado con `{ }` después de la llamada. Si es el **único parámetro**, se sacan los `()` enteros. Sumado: **multiple trailing closures** (Swift 5.3+) — el primero sin label, los siguientes con label externo + `:`.
- Estructura de closures como parámetro: distinguir el closure en sí (ej. `action`, el parámetro de tipo función) de **llamarlo** (`action("London", 60)`, que ejecuta y devuelve un valor) del **resultado** guardado en una constante (ej. `description`, que es un `String` normal, no un closure).
- **Shorthand Closure Parameter Names** (`$0`, `$1`, ...): si el tipo del closure ya está declarado en la firma de la función, se pueden referenciar los parámetros por posición sin nombrarlos ni tipar. Combinado con single-expression closures, no hace falta `return`. Todo esto en cheatsheet sección 7.

## Repasado (sesión 2026-07-10)
- Optional vs Force Unwrap profundizado: qué es un Optional ("caja" que puede estar vacía), cuándo `!` es legítimo (solo si el `nil` depende de vos, nunca de datos externos)
- `if let` vs `guard let`: diferencia de scope (bloque vs resto de la función) e intención (opcional real vs requisito para continuar)
- Try/catch repasado con sintaxis completa + `try?`/`try!` agregados al cheatsheet (sección 11)
- Typecasting/casting (`as`, `as?`, `as!`): relación con herencia (superclase/subclase), combinado con `guard let` (cheatsheet sección 12)

## Repasado (sesión 2026-07-09)
- Extensions y protocol extensions (con protocol extensions, computed properties)
- Try/catch y manejo de errores (do/try/catch, try?, try!)
- Force Unwrap vs Optional (regla: sin certeza de que hay valor, nunca usar `!`)

