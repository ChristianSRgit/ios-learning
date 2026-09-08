# dropsim.swift — Simulador de Drop Rate (Lineage 2 Interlude)

Proyecto de consola en Swift. Sesión estimada: 3 a 4 horas.
Objetivo pedagógico: primer contacto con consumo de APIs (`URLSession` + `Codable`) manteniendo las dos reglas de `gastos.swift`.

---

## 1. Qué hace el programa

El usuario elige un monstruo y un item que ese monstruo dropea. El programa
simula matar al monstruo una y otra vez, tirando un número aleatorio contra
la probabilidad de drop **real** que devuelve la API, hasta que el item cae.

Al final reporta cuántos kills hicieron falta y cuánto tiempo real de juego
representa eso.

La gracia está en que los datos son reales pero la experiencia la genera tu
código. El mismo item da resultados distintos cada corrida.

---

## 2. Reglas del ejercicio (heredadas de gastos.swift)

- **Prohibido el force unwrap (`!`).** Ni en optionals, ni en `try!`.
- **Las funciones devuelven, no imprimen.** El único lugar donde hay `print`
  es la capa de presentación / punto de entrada. Una función que se llama
  `buscarMonstruo` devuelve `Monstruo?`, no imprime el monstruo.

Regla nueva para este proyecto:

- **Separar red de lógica.** La función que simula los kills no debe saber que
  existe una API. Recibe un `Double` (la chance) y devuelve un `Int` (los kills).
  Esto la hace testeable sin internet y es la primera intuición de por qué
  existe la separación de capas que después vas a ver como MVC / MVVM.

---

## 3. La API

Base URL: `https://l2api.dev/api/interlude`
Sin API key. Read-only. Solo chronicle `interlude`.
Docs: `https://docs.l2api.dev` — OpenAPI: `https://l2api.dev/api/openapi.json`

### Paso 0 de la sesión: verificar la forma real

Antes de escribir un solo `struct`, corré esto y mirá el JSON con tus ojos:

```bash
# Buscar un monstruo por nombre
curl "https://l2api.dev/api/interlude/monsters?q=hangman&limit=5"

# Ver la tabla de drops de un monstruo (usá un id del resultado anterior)
curl "https://l2api.dev/api/interlude/monsters/20144/drops"
```

No modeles el `struct` desde este documento. Modelalo desde lo que ves en la
terminal. Si un campo del documento no coincide con la realidad, gana la
realidad — y avisá, porque significa que la API cambió.

### Endpoint 1 — buscar monstruo

```
GET /interlude/monsters?q={texto}&limit={n}
```

Forma de la respuesta (según el schema OpenAPI oficial):

```json
{
  "data": [
    {
      "id": 20144,
      "name": "Hangman Tree",
      "title": null,
      "level": 20,
      "npcType": "L2Monster",
      "hp": 234.5,
      "isAggressive": false
    }
  ],
  "meta": { "total": 1, "limit": 5, "offset": 0 }
}
```

Campos que el schema declara **nullable** — o sea, optionals en Swift:
`title`, `level`, `npcType`, `hp`.

### Endpoint 2 — drops del monstruo

```
GET /interlude/monsters/{id}/drops
```

```json
{
  "data": {
    "npcId": 20144,
    "npcName": "Hangman Tree",
    "drops": [
      {
        "itemId": 57,
        "itemName": "Adena",
        "qty": "22-44",
        "chance": 70.0,
        "chanceDisplay": "70%",
        "type": "adena",
        "rollCount": 1
      },
      {
        "itemId": 1864,
        "itemName": "Stem",
        "qty": "1",
        "chance": 3.5,
        "chanceDisplay": "3.5%",
        "type": "spoil",
        "rollCount": 1
      }
    ]
  }
}
```

Puntos importantes de este endpoint:

- `chance` es **nullable** y es un **porcentaje ya dividido** (3.5 significa 3.5%,
  no 3.5/10000). No lo vuelvas a dividir.
- `itemName` también es nullable.
- `type` es un enum de tres valores: `"spoil"`, `"adena"`, `"regular"`.
- `drops` puede venir vacío aunque el monstruo exista. Devuelve 404 solo si el
  id no existe. Son dos casos de error distintos y tu código debería
  distinguirlos.

### Envelope

Todas las respuestas envuelven el contenido en `data`. Nunca leas el objeto raíz
directo. Esto significa que vas a necesitar un `struct` wrapper, y ahí aparece
naturalmente el tema de los generics.

---

## 4. Flow de consola esperado

Así se debería ver la corrida completa. Este es el contrato: si al final de la
sesión tu programa produce algo parecido a esto, terminaste.

```
=== L2 DROP SIMULATOR (Interlude) ===

Buscar monstruo: hangman

Encontrados:
  1. Hangman Tree (lv 20, HP 234)
  2. Hangman Tree Sapling (lv 18, HP 180)

Elegir numero: 1

Drops de Hangman Tree:
  1. Adena              22-44    70%
  2. Stem               1        3.5%
  3. Silver Nugget      1        0.8%
  4. Coal               1        0.12%

Elegir numero: 4

Segundos por kill (enter = 30): 25

Simulando...

--- RESULTADO ---
Item:            Coal
Chance:          0.12%
Kills:           1847
Tiempo de farmeo: 12h 49m

Kills esperados en promedio: 833
Tuviste MALA suerte: 2.2x el promedio.

Otra simulacion? (s/n): s
```

Casos de error que el flow tiene que cubrir sin crashear:

```
Buscar monstruo: asdfgh

No se encontro ningun monstruo con ese nombre.
Buscar monstruo: _
```

```
Buscar monstruo: gremlin

Encontrados:
  1. Gremlin (lv 1, HP 42)

Elegir numero: 7

Numero fuera de rango. Elegir entre 1 y 1.
Elegir numero: _
```

```
Drops de Vuku Orc Fighter:
Este monstruo no tiene tabla de drops. Elegir otro.
```

```
Error de red: no se pudo contactar la API.
Revisar conexion e intentar de nuevo.
```

---

## 5. Estructura de archivos sugerida

No hace falta separar en muchos archivos, pero sí separar mentalmente estas
cuatro responsabilidades. Si lo hacés en un solo `.swift`, usá `// MARK:` para
separarlas visualmente.

```
dropsim/
  Models.swift       // structs Codable, sin logica
  API.swift          // funciones que hablan con la red, devuelven modelos
  Simulator.swift    // la logica de la simulacion, cero red, cero print
  main.swift         // el unico archivo que imprime y lee input
```

La prueba de que separaste bien: `Simulator.swift` no debería tener ni un
`import Foundation` relacionado a red, ni un solo `print`.

---

## 6. Milestones

Ordenados para que cada uno funcione por sí solo antes de pasar al siguiente.
Si te quedás sin tiempo, terminá en el milestone 3 y el programa igual sirve.

### Milestone 1 — Los modelos (45 min)

Escribir los `struct Codable` que representan las dos respuestas. Probar el
decoding contra un JSON hardcodeado en un string, sin tocar la red todavía.

```swift
// Wrapper generico: toda respuesta de la API viene envuelta en "data".
// El generico <T> permite reusar este struct para items, monstruos y drops
// sin escribir un wrapper distinto para cada uno.
struct APIResponse<T: Decodable>: Decodable {
    let data: T
}

// Un monstruo tal como viene en la lista de /monsters.
// level y hp son opcionales porque el schema de la API los declara nullable:
// hay NPCs en el datapack sin nivel ni HP definidos.
struct Monstruo: Decodable {
    let id: Int
    let name: String
    let level: Double?   // nullable en la API
    let hp: Double?      // nullable en la API
}
```

Meta del milestone: un `JSONDecoder().decode(...)` que no lanza error sobre un
string de prueba.

### Milestone 2 — Traer datos reales (60 min)

Reemplazar el string hardcodeado por una llamada real. Acá aparece `async/await`
por primera vez.

```swift
// Trae la lista de monstruos que coinciden con el texto de busqueda.
// Devuelve un array vacio si no hay coincidencias.
// Lanza si hay problema de red o de decoding: el caller decide que hacer.
func buscarMonstruos(nombre: String) async throws -> [Monstruo] {
    // Los nombres pueden tener espacios, hay que escaparlos para la URL.
    var componentes = URLComponents(string: "https://l2api.dev/api/interlude/monsters")
    componentes?.queryItems = [
        URLQueryItem(name: "q", value: nombre),
        URLQueryItem(name: "limit", value: "10")
    ]

    // URLComponents.url es opcional: si la construccion fallo, avisamos
    // en vez de forzar con "!".
    guard let url = componentes?.url else {
        throw ErrorApp.urlInvalida
    }

    let (datos, _) = try await URLSession.shared.data(from: url)
    let respuesta = try JSONDecoder().decode(APIResponse<[Monstruo]>.self, from: datos)
    return respuesta.data   // devuelve, no imprime
}
```

Meta del milestone: imprimir desde `main` la lista de monstruos que devuelve
esta función. La función no imprime nada.

### Milestone 3 — El simulador (45 min)

El corazón del proyecto, y la parte con cero red.

```swift
// Simula matar al monstruo repetidamente hasta que el item caiga.
// chance: porcentaje de 0 a 100, tal como viene de la API.
// Devuelve la cantidad de kills que hicieron falta.
// Devuelve nil si la chance es invalida (cero, negativa o mayor a 100):
// simular un drop imposible seria un loop infinito.
func simularKills(chance: Double) -> Int? {
    guard chance > 0 && chance <= 100 else {
        return nil
    }

    var kills = 0
    while true {
        kills += 1
        // Double.random genera un numero entre 0 y 100.
        // Si cae por debajo de la chance, el item dropeo.
        if Double.random(in: 0...100) < chance {
            return kills
        }
    }
}

// El promedio teorico de intentos para un evento con probabilidad p
// es 1/p. Sirve para decirle al usuario si tuvo buena o mala suerte.
func killsEsperados(chance: Double) -> Int? {
    guard chance > 0 else { return nil }
    return Int(100.0 / chance)
}
```

Meta del milestone: correr `simularKills(chance: 3.5)` diez veces y ver diez
números distintos, todos rondando 28.

### Milestone 4 — Pegar todo en main (60 min)

El loop de interacción, el manejo de input inválido, el formato del tiempo.
Todo el `print` y todo el `readLine()` viven acá y solo acá.

```swift
// readLine() devuelve String? porque la entrada puede cerrarse (Ctrl+D).
// Int() sobre un String devuelve Int? porque el texto puede no ser un numero.
// Son dos optionals encadenados de origen distinto: nil-coalescing no alcanza,
// hace falta decidir que pasa en cada caso.
func leerNumero(entre minimo: Int, y maximo: Int) -> Int? {
    guard let linea = readLine() else {
        return nil   // entrada cerrada
    }
    guard let numero = Int(linea) else {
        return nil   // no era un numero
    }
    guard numero >= minimo && numero <= maximo else {
        return nil   // fuera de rango
    }
    return numero
}
```

Meta del milestone: el flow de la sección 4 corriendo de punta a punta.

---

## 7. Conceptos que toca este proyecto

### Nuevos (el foco de la sesión)

| Concepto | Dónde aparece |
|---|---|
| `URLSession` y `async`/`await` | traer datos de la red en el milestone 2 |
| `Codable` / `Decodable` | mapear JSON a `struct` en el milestone 1 |
| `JSONDecoder` | el decoding propiamente dicho |
| `URLComponents` y `URLQueryItem` | armar la URL con query params escapados |
| Generics básicos | el `APIResponse<T>` que envuelve toda respuesta |
| `throws` y `try` | propagar errores de red hacia arriba |
| `enum` de errores | definir tus propios casos de falla |

### Refuerzo (tus puntos flojos diagnosticados)

| Concepto | Por qué está acá |
|---|---|
| **Function contracts** | cada función del documento declara qué devuelve y por qué. La regla "devuelve, no imprime" existe justamente para esto |
| Optionals | la API tiene campos nullable reales. No son optionals de ejercicio: si no los manejás, no compila |
| `guard let` | tres orígenes distintos de nil en el mismo programa: la URL, el JSON, el input del usuario |
| `??` | valores por defecto: segundos por kill, nombre de item faltante |

### Conceptos que **no** vamos a tocar (a propósito)

- Arquitectura (MVC / MVVM). Es consola, no hace falta, y forzarla sería
  exactamente lo que Juan quiere evitar: patrón antes del dolor.
- Persistencia. Nada se guarda entre corridas.
- Concurrencia real (`TaskGroup`, actores). Solo `async/await` secuencial.
- Testing formal. Podés probar a mano; Swift Testing viene después.

---

## 7.b. SOLID y KISS en este proyecto

No se aplican a rajatabla. Se tienen en cuenta: cuando una decisión de diseño
aparece, se mira si algún principio la ilumina, y si no aplica se deja pasar
sin forzarla.

La tensión hay que nombrarla: SOLID empuja a separar, abstraer e inyectar.
KISS empuja a no agregar nada que todavía no duela. En un programa de consola
de una tarde, KISS gana casi siempre — y eso es coherente con el enfoque de
sentir el dolor antes de introducir la solución.

### Lo que sí se aplica

**SRP — Single Responsibility.** Es el único principio que estructura el
proyecto de verdad, y ya está en el plan aunque no estuviera nombrado:

- La separación en cuatro archivos (Models / API / Simulator / main) es SRP
  a nivel módulo.
- La regla "las funciones devuelven, no imprimen" es SRP a nivel función:
  calcular y comunicar son dos responsabilidades distintas.
- `simularKills` no sabe que existe internet. Esa es la línea más importante
  del diseño.

**DIP — Dependency Inversion, en versión mínima.** `simularKills` depende de
un `Double`, no de un cliente de red. La lógica no depende del detalle de
dónde vino el dato. Eso alcanza para este tamaño.

Lo que sería sobreingeniería acá: definir un `protocol MonsterRepository` con
implementación real y una mock, e inyectarla por constructor. Es lo correcto
en una app de verdad con tests. En un script de consola es ceremonia.

### Lo que se deja afuera, a propósito

| Principio | Por qué no aplica acá |
|---|---|
| OCP | No hay nada que vaya a extenderse sin modificarse. Un `enum` cerrado de tipos de drop es más simple y más correcto que una jerarquía abierta |
| LSP | No hay herencia. Sin subtipos, no hay sustituibilidad que respetar |
| ISP | No hay interfaces, mucho menos gordas. Nada que segregar |

Si en algún momento de la sesión sentís el impulso de crear un protocol
"por las dudas", ese es el momento de aplicar KISS: no lo crees hasta que
haya un segundo caso de uso real.

### Dónde va a aparecer el dolor (y ahí sí, refactor)

El punto donde el proyecto empieza a pedir estructura de verdad:

- Si agregás la extensión de "valor por hora", vas a necesitar un tercer
  endpoint. Ahí tres funciones de fetch casi idénticas van a doler, y ese
  dolor justifica un `func fetch<T: Decodable>(_ url: URL) async throws -> T`
  genérico. Eso es DRY llegando por dolor, no por decreto.
- Si querés testear el simulador con una secuencia de números fija en vez de
  random, ahí aparece la necesidad real de inyectar la fuente de aleatoriedad.
  Ese es el momento honesto de DIP completo, no antes.

---

## 8. Preguntas para revisar con Juan

- ¿El generic `APIResponse<T>` es demasiado pronto, o es el momento justo
  porque el dolor de escribir tres wrappers idénticos es real y concreto?
- ¿Conviene meter `enum ErrorApp: Error` en esta sesión o dejarlo en
  `throws` genérico y agregar el enum como refactor de una segunda pasada?
- La separación en cuatro archivos: ¿vale la pena en un proyecto de consola,
  o es mejor un archivo con `// MARK:` para no distraer del tema principal?
- Sobre la sección 7.b: ¿coincidís en que SRP y una versión mínima de DIP es
  todo lo que corresponde acá, o hay algún principio que dejé afuera y que a
  tu criterio sí vale la pena introducir en este tamaño de proyecto?

---

## 9. Extensiones si sobra tiempo

Ninguna es necesaria. Están ordenadas por relación esfuerzo/diversión.

- **Modo "1000 corridas"**: simular mil veces y mostrar el promedio real vs el
  teórico. Es la ley de los grandes números apareciendo en tu terminal.
- **Comparar dos items** del mismo monstruo y mostrar cuál cuesta más farmear.
- **Modo "full set"**: elegir varios items y simular hasta juntarlos todos.
- **Valor por hora**: cruzar con `/items/{id}` para traer el `price` y calcular
  cuánta adena por hora genera farmear ese mob.
