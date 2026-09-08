# Notas de refactor — CRUD.swift vs CRUDRefactorClaude.swift

Preparado 2026-09-06 para la sesión con Juan del 2026-09-07. Objetivo: poder explicar y defender cada cambio del refactor con criterio propio, no repetir "porque lo dijo Claude".

Contexto de fechas (importante para el argumento):
- `CRUD.swift` es tu archivo, evolucionado en varias sesiones.
- `CRUDRefactorClaude.swift` se generó el 2026-08-31 13:42, a partir del estado de `CRUD.swift` en ese momento.
- Vos seguiste editando `CRUD.swift` el 2026-09-03 — 3 días **después** del refactor. Por eso hay comentarios en el refactor que ya no describen bien tu archivo actual (ver sección "Comentario desactualizado" abajo). Este punto por sí solo es un buen argumento para mostrarle a Juan que entendés que un refactor es una foto fija, no algo que se mantiene solo.

## 1. Cambios del refactor y por qué son mejores

**ANSIColor / Mensaje: `enum ... : String` con casos → `enum` sin casos + `static let`**
Ninguno de los dos se usa como valor de tipo (no los comparás, no los iterás), son constantes agrupadas. Con `rawValue: String` Swift generaba un `init?(rawValue:)` que nunca ibas a usar. `static let` dentro de un enum vacío es el patrón estándar en Swift para "namespace de constantes" sin la sobrecarga de un caso real.

**Categoria: `PascalCase` (`.Comida`) → `lowerCamelCase` (`.comida`) + `nombre` computado + `menuDescripcion` vía `CaseIterable`**
Convención de Swift: tipos en PascalCase, casos/valores en lowerCamelCase (esto es señalable por Juan si no lo mencionás vos primero). Más importante: el string "1: Comida, 2: Transporte..." estaba hardcodeado en 3 lugares de tu archivo (agregar, editar, filtrar). Generarlo desde `CaseIterable` es justo lo que vos mismo anotaste como pendiente en Homework ("agregar función para no hardcodear categorías"). Si mañana agregás una categoría nueva, el menú se actualiza solo — cero riesgo de que un lugar quede desincronizado.

**Gasto: + `Identifiable`, + `CustomStringConvertible`**
Tu archivo reconstruía el string de un gasto a mano en 3 lugares con formato levemente distinto cada vez (listar, editar, filtrar). `CustomStringConvertible` centraliza ese formato: un solo lugar define cómo se ve un `Gasto` impreso.

**Lector (enum con funciones estáticas): extrae los 3 bucles `while hasValidX == nil { leer, intentar parsear, error, reintentar }`**
Este es el cambio de mayor impacto real: eran 3 bloques casi idénticos (categoría, monto, entero con rango) con la misma forma. Extraerlos elimina la triplicación y hace que `ejecutarAgregar` se lea como una lista de pasos en vez de 40 líneas de manejo de errores.

**GastosStore (class): reemplaza el `var gastos: [Gasto]` global**
Tu archivo mutaba el array global desde el bucle principal y desde funciones sueltas, sin ningún contrato. El nombre del archivo es "CRUD" pero no había Create/Read/Update/Delete explícitos en ningún lado — cualquier función podía tocar el array como quisiera. La clase agrupa esas operaciones con nombre y dueño.

**ComandoMenu (enum con rawValue String) reemplaza `case "1":`**
Exactamente el pedido de tu propio Homework ("usar un enum en vez de constantes sueltas para los comandos"). El switch principal pasa de leerse como números mágicos a leerse como una tabla de comandos con nombre.

## 2. Comentario desactualizado en el refactor (para mostrarle a Juan que revisás con ojo crítico)

El refactor tiene estos comentarios sobre `case "1"` y `case "3"` del filtro:
> "En el original este caso pedía la categoría por consola pero nunca leía la respuesta ni filtraba: quedaba sin efecto."
> "Mismo problema que el caso '1': pedía la descripción y no la usaba."

Esto **no es cierto sobre tu `CRUD.swift` actual** (verificado línea por línea): ambos filtros sí leen `readLine()`, parsean y aplican `.filter` correctamente. La explicación es la de arriba — el refactor es del 31/08, vos arreglaste esto en tu archivo el 03/09, tres días después. El comentario describe un bug que ya no existe. Buen punto para la sesión: un refactor congela el código en el momento en que se genera, no se auto-actualiza cuando seguís trabajando el original.

## 3. Lo que el refactor pierde (regresiones reales — para defenderlo con honestidad, no venderlo como perfecto)

1. **Falta "Total por categoría".** Tu `CRUD.swift` tiene la opción 4 del submenú de filtro ("Total por categoría", con desglose por cada categoría). El refactor la sacó del todo — ni está en `Mensaje.opcionesFiltrar`, ni hay método equivalente en `GastosStore`. Es justo la métrica que vos mismo pediste agregar en el Homework anterior ("agregar métrica de consumo total x categoría"). Si vas a usar el refactor como base, esto hay que devolverlo.

2. **Reproduce (no arregla) el bug de "vuelve al menú anterior" que anotaste en el Homework.** Tu nota decía: *"Switch que se sale cuando hay un error en modificación. Revisar ediciones que se va de nuevo al menú anterior (no solo en categoría)."* Confirmé que este bug sigue vivo en tu `CRUD.swift` actual (en filtrar por categoría/descripción y en editar monto/categoría: un valor inválido no vuelve a pedir directamente el mismo dato, sino que te devuelve al menú padre). El refactor **no lo corrige** — y encima lo empeora en `ejecutarEditar`: en tu original, un valor inválido en el submenú de edición (1/2/3/4) hace que el `while editandoGasto` vuelva a preguntar; en el refactor, `ejecutarEditar` no tiene ningún `while` — una opción inválida cae directo al `default` y te devuelve al menú principal sin reintentar. Esto es el ejemplo más concreto que tenés para tu nota de "mantener consistencia de flujo, que el usuario nunca tenga que volver a un menú anterior para algo que podría resolverse ahí mismo".

3. **Pierde el manejo de EOF / Ctrl+D (programación defensiva).** Tu original usa `guard let x = readLine() else { isRunning = false; break }` en varios puntos para salir con gracia si se cierra la entrada estándar. El refactor lo simplifica a `readLine() ?? ""` en todos lados — que ante un EOF real (stdin cerrado) devuelve siempre `""`, cae en `default`/`comandoDesconocido` y **loopea infinito** en vez de cerrar el programa. Es exactamente el tipo de caso que tu nota de "programación defensiva, pensar que el usuario te quiere romper el programa" pide cubrir, y el refactor lo rompe.

4. **`eliminar(id:)` existe en `GastosStore` pero no está expuesto en el menú** — esto es intencional (está comentado en el código), preparado para un futuro comando de borrado. No es un bug, es un gancho para la próxima feature.

## 4. Estado de los pendientes del Homework anterior (sesión 07/09) contra tu `CRUD.swift` actual

| Pendiente (Homework) | Estado en CRUD.swift (03/09) |
|---|---|
| Enum para constantes en vez de variables sueltas | Colores/mensajes ya eran enum. Los **números de comando** (`case "1"`) siguen hardcodeados — sólo el refactor los resolvió con `ComandoMenu`. |
| Revisar que un error en edición no te mande al menú anterior (no sólo en categoría) | **Sigue pendiente**, confirmado en filtro (categoría, descripción) y en editar (monto, categoría). El refactor no lo arregla y lo empeora en el submenú de editar. |
| Falta filtro por descripción con `contains`/`filter` | **Resuelto** — ya está implementado y funciona. |
| Métrica de total por categoría | **Resuelto en tu original** — pero el refactor la eliminó. |
| Seguir practicando programación defensiva | Abierto, de fondo. El caso EOF del refactor (punto 3 arriba) es un buen ejemplo concreto para traer a la sesión. |
| Terminar refactor / que Claude enumere buenas prácticas | Esto es lo que cubre este documento. |
| Consistencia de flujo (nunca cerrar/reabrir para llegar a un menú) | Relacionado directamente con el punto 2 de "vuelve al menú anterior" — mismo pendiente. |

## 5. Para llevar a la sesión

Si el objetivo es tener una versión combinada, el camino más defendible es: partir del refactor (estructura, `Lector`, `GastosStore`, `ComandoMenu`) y sobre eso: (a) restaurar el total por categoría, (b) agregar retry real dentro del submenú de editar en vez de caer al menú principal, (c) volver a manejar el `nil` de `readLine()` explícitamente en vez de `?? ""`.
