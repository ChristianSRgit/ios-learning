# Cheatsheet: Swift para Desarrolladores JavaScript 🚀

---

## ✍️ 0. Sintaxis Básica
*   **Sin punto y coma (`;`)**: A diferencia de JS/TS, en Swift **no se usa `;`** al final de cada línea. El salto de línea ya marca el fin de la instrucción.
    ```swift
    // JS/TS
    let name = "John";

    // Swift
    let name = "John"
    ```
*   **Excepción:** Solo se usa `;` si querés escribir **dos instrucciones en la misma línea** (poco común, no recomendado).
    ```swift
    let a = 1; let b = 2
    ```

---

## 📌 1. Variables y Constantes
| Concepto | JS / TS | Swift | Nota |
| :--- | :--- | :--- | :--- |
| **Constantes** | `const x = 5;` | `let x = 5` | **Usa `let` por defecto.** |
| **Variables** | `let y = 10;` | `var y = 10` | **Usa `var` solo para reasignar.** |
| **Tipado** | Dinámico/Estático | Estático Fuerte | Inferencia automática de tipos. |
| **Sin valor** | `null`/`undefined` | `nil` | Solo los **Opcionales** aceptan `nil`. |

---

## 📦 2. Opcionales y Desempaquetado (Unwrapping)

*   **Qué es un Optional, en criollo**: una "caja" (`String?`, `Int?`, etc.) que puede estar llena (con un valor de ese tipo) o vacía (`nil`). El tipo por dentro sigue siendo estricto — a un `String?` no le podés asignar un `Int`, ni compila.
    ```swift
    var nombre: String?        // la caja empieza vacía (nil) por defecto
    nombre = "Ana"              // ahora la caja tiene un valor adentro
    ```
*   **"Desempaquetar" (unwrap)** significa: sacar el valor de adentro de la caja para poder usarlo como el tipo real (`String`, no `String?`). Swift **te obliga** a hacerlo — no te deja usar un optional directo como si fuera seguro.

### 1. Force Unwrapping (`!`) — ⚠️ Peligroso

Le decís a Swift "confiá en mí, sé que tiene valor". Si te equivocás y es `nil`, **crashea la app**.

```swift
var nombre: String? = "Ana"
print(nombre!)     // "Ana" — saca el valor a la fuerza
```

### 2. Optional Binding (`if let`) — 🔒 Seguro

Preguntás "¿tiene valor?" y, si sí, lo desempaqueta en una constante nueva **solo dentro del bloque `{ }`**.

```swift
var nombre: String? = "Ana"

if let nombreDesempaquetado = nombre {
    print("Hola, \(nombreDesempaquetado)")   // corre solo si nombre NO es nil
} else {
    print("No hay nombre")
}
```

*   **Shorthand (mismo nombre)**: si llamás a la constante igual que el optional, podés omitir el `= nombre`:
    ```swift
    if let nombre {
        print("Hola, \(nombre)")   // acá "nombre" ya es String, no String?
    }
    ```

### 3. Early Exit (`guard let`) — 🛡️ Seguro

Preguntás "¿tiene valor?" pero al revés: si **no** lo tiene, salís de la función ahí mismo (`return`/`break`/`throw` en el `else`, obligatorio). Si pasa, el valor queda disponible en **todo el resto de la función**, no solo en un bloque.

```swift
func saludar(nombre: String?) {
    guard let nombre else {
        print("No hay nombre")
        return                      // obligatorio: hay que salir en el else
    }

    print("Hola, \(nombre)")        // acá abajo "nombre" ya está desempaquetado
}
```

### 4. Nil Coalescing (`??`) — 🔄 Valor por defecto

Si el optional es `nil`, usa el valor de la derecha en su lugar. Devuelve el tipo **no-optional** directamente, sin `if`/`guard`.

```swift
var nombre: String? = nil
let saludo = "Hola, " + (nombre ?? "invitado")
print(saludo)   // "Hola, invitado"
```

*   **En criollo**: `??` es un atajo para decir *"usá este valor, pero si está vacío (`nil`), usá este otro en su lugar"*. Nada más.
    ```swift
    var apodo: String? = nil
    let saludo = apodo ?? "Che"   // apodo es nil → saludo = "Che"

    apodo = "Turco"
    let saludo2 = apodo ?? "Che"  // apodo tiene algo → saludo2 = "Turco", el "Che" ni se usa
    ```
*   **Qué reemplaza** — es el mismo resultado que este `if let` más largo, comprimido en una línea:
    ```swift
    var saludo: String
    if let valor = apodo {
        saludo = valor
    } else {
        saludo = "Che"
    }
    // equivale a:
    let saludo = apodo ?? "Che"
    ```
*   **Cuándo usar `??` en vez de `if let`/`guard let`**: cuando lo único que necesitás es **un valor de respaldo**, no cambiar el flujo del código. Si tu `else` de un `if let` fuera "usar tal valor fijo" y nada más, seguramente lo podés reemplazar por `??` y ahorrarte varias líneas.

### 5. Optional Chaining (`?.`) — 🔗 Encadenar accesos seguros

Accedé a propiedades/métodos de un optional sin desempaquetar antes. Si el optional es `nil` en cualquier eslabón de la cadena, todo el resultado es `nil` (no crashea).

```swift
struct Direccion { var ciudad: String }
struct Persona { var direccion: Direccion? }

let persona = Persona(direccion: nil)
let ciudad = persona.direccion?.ciudad   // String? — nil, no crashea
print(ciudad ?? "sin ciudad")            // "sin ciudad"
```

### Cuándo usar cada uno

*   **¿Cuándo es legítimo `!`?**: solo cuando el `nil` depende de algo que **vos controlás** (literal fijo, asset agregado al proyecto, invariante ya verificada arriba). Si el `nil` puede venir de algo **externo** (API, usuario, archivo, red) → siempre `guard`/`if let`, nunca `!`.
*   **`if let` vs `guard let`** (diferencia clave: scope + intención):
    *   `if let`: el valor desempaquetado solo existe **dentro del bloque `{ }`**. Úsalo cuando ambos caminos (con/sin valor) son válidos y la función sigue teniendo sentido igual.
    *   `guard let`: si es `nil`, obliga a salir (`return`/`break`/`throw`) en el `else`. Si pasa, el valor queda disponible en **todo el resto de la función**. Úsalo cuando el valor es un **requisito** para continuar.
*   **Regla rápida de sintaxis**: `if let x = optional { }` y `guard let x = optional else { }` — si la constante nueva se llama **igual** que el optional (`nombreDesempaquetado` vs `nombre`), se puede escribir corto: `if let nombre { }` / `guard let nombre else { }`.

---

## 📚 3. Colecciones
*   **Arrays `[T]`**:
    *   **Tipo:** Homogéneos (mismo tipo).
    *   **Tamaño:** Dinámico (`append`, `remove`).
    *   **Acceso:** Por índice `array[0]`.
    *   **Unir Arrays (`+`)**: Se pueden concatenar dos arrays del mismo tipo con el operador `+`.
        ```swift
        let firstHalf = ["John", "Paul"]
        let secondHalf = ["George", "Ringo"]
        let beatles = firstHalf + secondHalf
        ```
*   **Tuplas `(T, U, ...)`**:
    *   **Tipo:** Heterogéneos (tipos mezclados).
    *   **Tamaño:** Fijo.
    *   **Acceso:** Por índice `.0` o por nombre `.propiedad`.
    *   **Uso:** Ideal para retornar múltiples valores en funciones.
*   **Diccionarios `[K: V]`**:
    *   **Estructura:** Pares Clave-Valor.
    *   **Claves:** Deben ser únicas.
    *   **Acceso:** `dict[clave]` → Siempre retorna un **Opcional** (`V?`).

---

## ⚡ 4. Operadores y Condiciones
*   **Operador Ternario (`condición ? valorSiTrue : valorSiFalse`)**: Forma corta de escribir un `if/else` que devuelve un valor. La sintaxis es **igual que en JS/TS**.
    ```swift
    let age = 18
    let canVote = age >= 18 ? "Yes" : "No"
    // Equivale a:
    // if age >= 18 { canVote = "Yes" } else { canVote = "No" }
    ```
    *   **Nota:** Los espacios alrededor de `?` y `:` son obligatorios (a diferencia de JS, donde a veces se omiten).
*   **`switch`**: A diferencia de JS/TS, en Swift **no hay fallthrough automático** entre `case`s — cada `case` se ejecuta solo y corta ahí, sin necesitar `break`.
    ```swift
    let number = 3

    switch number {
    case 1:
        print("Uno")
    case 2:
        print("Dos")
    default:
        print("Otro número")
    }
    ```
*   **`fallthrough`**: Palabra clave que **fuerza manualmente** el comportamiento "a la JS" — hace que, al terminar un `case`, siga ejecutando el código del `case` siguiente aunque no cumpla su condición.
    ```swift
    let number = 5

    switch number {
    case 5:
        print("Es 5")
        fallthrough
    case 6:
        print("Esto se imprime igual, aunque number no sea 6")
    default:
        print("Otro número")
    }
    // Imprime: "Es 5" y también "Esto se imprime igual, aunque number no sea 6"
    ```
    *   **Uso típico:** Poco frecuente, útil cuando varios `case`s consecutivos deben compartir parte de la lógica.
*   **Range Operators**: Permiten representar un rango de valores. Muy útiles combinados con `switch` para evitar cadenas de `if/else`.
    *   **Closed Range (`a...b`)**: Incluye ambos extremos (`a` y `b` incluidos).
    *   **Half-Open Range (`a..<b`)**: Incluye `a` pero **excluye** `b`. Ideal para índices de arrays (`0..<array.count`).
    ```swift
    let score = 85

    switch score {
    case 0..<50:
        print("You failed badly.")
    case 50..<85:
        print("You did OK.")
    default:
        print("You did great!")
    }
    // Imprime: "You did great!" (85 no entra en 50..<85 porque el límite superior queda excluido)
    ```

---

## 🔁 5. Loops (`for`)
*   **Sintaxis básica**: `for constante in secuencia { ... }`. La constante toma cada valor de la secuencia (array, rango, etc.) en cada vuelta.
    ```swift
    let names = ["Ringo", "John", "Paul", "George"]

    for name in names {
        print("\(name) is a Beatle")
    }
    ```
*   **Loop con rango**: usando los Range Operators (`1...5`) para repetir algo N veces.
    ```swift
    for i in 1...5 {
        print(i)
    }
    ```
*   **Underscore (`_`)**: cuando **no necesitás usar el valor** de la variable de loop, se reemplaza por `_` para indicarle a Swift (y a quien lea el código) que ese valor se descarta a propósito.
    ```swift
    print("Players gonna ")

    for _ in 1...5 {
        print("play")
    }
    ```
    *   **Caso de uso recomendado:** cuando solo te importa **repetir una acción N veces**, sin necesitar el número de la iteración (ej. imprimir algo 5 veces, generar N elementos random, reintentar una acción X cantidad de veces). Usar `_` es más claro que declarar una variable (`i`, `index`) que después nunca se usa.
*   **`repeat while`**: equivalente al `do while` de JS/TS. Ejecuta el bloque **al menos una vez** y después evalúa la condición para decidir si repite.
    ```swift
    var count = 1

    repeat {
        print(count)
        count += 1
    } while count <= 5
    ```
*   **Loops anidados (nested loops)**: un `for` dentro de otro `for`. El loop interno completa **todas sus vueltas** por cada vuelta del loop externo.
    ```swift
    for i in 1...10 {
        for j in 1...10 {
            let product = i * j
            print("\(i) * \(j) is \(product)")
        }
    }
    ```
*   **Labels (`outerLoop:`) y `break outerLoop`**: al etiquetar un loop con un nombre (ej. `outerLoop:`), podés usar `break nombreDelLoop` para salir directamente de **todos los loops anidados a partir de ese label** de una vez, en vez de que el `break` normal solo corte el loop más interno.
    ```swift
    outerLoop: for i in 1...10 {
        for j in 1...10 {
            let product = i * j
            print("\(i) * \(j) is \(product)")

            if product == 50 {
                print("It's a bullseye!")
                break outerLoop
            }
        }
    }
    ```
    *   **Caso de uso:** cuando encontrás lo que buscabas dentro de un loop anidado y necesitás cortar toda la búsqueda (los loops involucrados), no solo el interno.
*   **Abstracción con 3+ loops (mental model: odómetro)**: con 3 loops anidados es la misma regla que con 2, aplicada recursivamente — "por cada valor del loop de afuera, corro TODO el bloque de los loops de adentro como si fuera una sola unidad". El loop más interno es el que gira más rápido (como el dígito de las unidades en un odómetro), y el más externo es el que menos avanza.
    ```swift
    let options = ["up", "down", "left", "right"]
    let secretCombination = ["up", "up", "right"]

    outerLoop: for option1 in options {
        for option2 in options {
            for option3 in options {
                let attempt = [option1, option2, option3]

                if attempt == secretCombination {
                    print("La combinación es \(attempt)!")
                    break outerLoop
                }
            }
        }
    }
    ```
    *   **Sin el label**, apenas encontrás la combinación correcta, `break` solo cortaría `option3` — `option1` y `option2` seguirían probando combinaciones de más, aunque ya no tenga sentido. Con `break outerLoop`, cortás los 3 loops de una, ahorrando trabajo cuando hay miles de combinaciones posibles.
*   **`break` vs `continue`**: `break` **termina el loop por completo**. `continue` solo **salta el resto del código de esa vuelta puntual** y sigue con la próxima iteración — el loop no muere.
    ```swift
    for i in 1...10 {
        if i % 2 == 1 {
            continue
        }
        print(i)
    }
    // Imprime: 2, 4, 6, 8, 10
    // Cuando i es impar, continue salta el print(i) y pasa directo al siguiente i
    ```
    *   **Caso de uso:** filtrar elementos dentro de un loop sin envolver todo el código restante en un `if`. Escribís primero la condición que **descarta** el elemento con `continue`, y el código principal del loop queda al mismo nivel de indentación, más legible.

---

## 🧩 6. Funciones
*   **Sintaxis básica**: `func nombre(parámetro: Tipo) -> TipoDeRetorno { ... }`. El `-> TipoDeRetorno` se omite si la función no devuelve nada.
    ```swift
    func printTimesTables(number: Int) {
        for i in 1...12 {
            print("\(i) x \(number) is \(i * number)")
        }
    }

    printTimesTables(number: 5)
    ```
*   **Con valor de retorno**: se usa `return` para devolver el valor.
    ```swift
    func square(number: Int) -> Int {
        return number * number
    }

    let result = square(number: 4)
    ```

---

## 🧵 7. Closures
*   **Qué es un closure**: un bloque de código auto-contenido que se puede guardar en una constante/variable, pasar como parámetro a una función, o retornar desde una función — tratado como un valor más.
*   **Closures como parámetro**: en vez de que la función devuelva el resultado con `return`, recibe un closure y es **ella** la que decide cuándo ejecutarlo. Sirve cuando el resultado depende de un momento distinto dentro de la propia lógica de la función (incluso podría llamarlo más de una vez).
    ```swift
    func procesarPedido(nombre: String, cuandoListo: (String) -> Void) {
        let mensaje = "Pedido de \(nombre) listo"
        cuandoListo(mensaje)
    }

    procesarPedido(nombre: "Milanesa", cuandoListo: { mensaje in
        print(mensaje)
    })
    ```
*   **Trailing Closure Syntax**
    *   Si el closure es el **último** parámetro de la función, se puede sacar de los `()` y escribirlo con `{ }` pegado después.
        ```swift
        procesarPedido(nombre: "Milanesa") { mensaje in
            print(mensaje)
        }
        ```
    *   Si el closure es el **único** parámetro, se pueden sacar los `()` enteros.
        ```swift
        alCerrarTurno { print("Turno cerrado") }
        ```
    *   **Multiple trailing closures** (Swift 5.3+): si la función recibe más de un closure, el primero sale sin label (como siempre), pero cada closure trailing **adicional** sí lleva su label externo + `:` pegado después del `}` anterior.
        ```swift
        func procesarPedido(nombre: String, cuandoListo: (String) -> Void, siFalla: () -> Void) {
            // ...
        }

        procesarPedido(nombre: "Milanesa") { mensaje in
            print(mensaje)
        } siFalla: {
            print("error")
        }
        ```
*   **Shorthand Closure Parameter Names (`$0`, `$1`, ...)**: si el tipo del closure ya está declarado en la firma de la función que lo recibe, Swift puede inferir los tipos de sus parámetros — entonces podés saltear `city, speed in` y referirte directo a los parámetros por posición: `$0` (primero), `$1` (segundo), etc. Si el closure es una sola expresión, tampoco hace falta `return` (el valor de esa expresión es lo que se devuelve).
    ```swift
    func calcular(operacion: (Int, Int) -> Int) {
        let resultado = operacion(4, 7) // acá se EJECUTA el closure con valores reales
        print(resultado)
    }

    calcular { $0 + $1 } // $0 = primer Int, $1 = segundo Int
    ```
    *   **Ojo con la confusión típica**: `$0`/`$1` solo existen **adentro** del closure — no se pueden usar sueltos en el llamado (`calcular($0, $1)` ❌, eso no es un closure).
    *   **Progresión completa** (de más explícito a más corto), todas equivalentes:
        ```swift
        calcular(operacion: { (a: Int, b: Int) -> Int in return a + b })  // completo
        calcular(operacion: { a, b in return a + b })                     // tipos inferidos
        calcular { a, b in return a + b }                                 // trailing closure
        calcular { a, b in a + b }                                        // sin return (single expression)
        calcular { $0 + $1 }                                              // shorthand
        ```

---

## 🧱 8. Enums vs Structs
*   **Enum**: representa un **conjunto cerrado y fijo de opciones con nombre** (estados, categorías). Se usa cuando todos los casos posibles se pueden listar de antemano.
*   **Struct**: representa un **contenedor de datos con propiedades** (value type). Se usa para agrupar información, no para elegir entre opciones fijas.
*   **Regla práctica**: ¿puedo nombrar TODAS las opciones posibles? → `enum`. ¿Es un conjunto de propiedades que describen algo? → `struct`.
*   **Ejemplo (dominio SMASH — pedido, estado, plataforma, dirección)**:
    ```swift
    enum EstadoPedido {
        case pendiente
        case enPreparacion
        case enCamino
        case entregado
        case cancelado
    }

    enum Plataforma {
        case telegram
        case web
        case instagram
    }

    struct Direccion {
        var calle: String
        var numero: Int
        var ciudad: String
    }

    struct Pedido {
        var estado: EstadoPedido
        var plataforma: Plataforma
        var direccionEntrega: Direccion
    }
    ```
    *   `EstadoPedido` y `Plataforma` son `enum` porque son un menú cerrado de opciones — un pedido no puede estar en un estado que no esté en la lista.
    *   `Direccion` es `struct` porque es información variable (calle, número, ciudad) sin un conjunto fijo de valores posibles.
*   ⚠️ **Ni `struct` ni `enum` soportan herencia** — no podés hacer `struct Perro: Animal`. Solo las `class` heredan. Para agregar funcionalidad a un struct o enum usás `extension` (sección 10) o `protocol` (sección 9).
*   **Enums se llevan bien con `switch`** (ver sección 4) para manejar cada caso:
    ```swift
    switch pedido.estado {
    case .pendiente:
        print("Esperando confirmación")
    case .enPreparacion:
        print("En la cocina")
    case .enCamino:
        print("En camino")
    case .entregado:
        print("Entregado")
    case .cancelado:
        print("Cancelado")
    }
    ```

---

## 📜 9. Protocols vs Funciones
*   **Función**: código real, **ejecutable**. Recibe parámetros, hace algo y opcionalmente devuelve un valor. Cuando la llamás, algo corre.
*   **Protocol**: **no es código ejecutable**, es un **contrato**. Define qué propiedades y métodos debe tener un tipo (`struct`, `class` o `enum`), pero no dice *cómo* implementarlos. Cada tipo que lo adopta escribe su propia implementación.
    ```swift
    protocol Saludable {
        var nombre: String { get }
        func saludar() -> String
    }

    struct Persona: Saludable {
        var nombre: String
        func saludar() -> String {
            return "Hola, soy \(nombre)"
        }
    }

    struct Robot: Saludable {
        var nombre: String
        func saludar() -> String {
            return "BEEP BOOP, soy \(nombre)"
        }
    }
    ```
*   **Tabla comparativa**:

| | Función | Protocol |
| :--- | :--- | :--- |
| ¿Qué es? | Una acción ejecutable | Un requisito/contrato |
| ¿Tiene cuerpo? | Sí, código que corre | No (solo declara la "firma") |
| ¿Se puede llamar directamente? | Sí | No — necesitás un tipo que lo adopte |
| ¿Para qué sirve? | Hacer algo | Garantizar que distintos tipos compartan una interfaz común |

*   **Nota (definición formal, fuente Google):** *"Un protocolo es un conjunto de reglas, pautas o procedimientos establecidos para guiar la conducta y estandarizar la resolución de problemas."*
*   **Por qué importa**: los protocols permiten escribir código genérico que funciona con cualquier tipo que cumpla el contrato, sin importar su implementación interna. Es la base de mucho de UIKit/SwiftUI (`Codable`, `Identifiable`, `Equatable`, etc.).
    ```swift
    func saludarATodos(seres: [Saludable]) {
        for ser in seres {
            print(ser.saludar())
        }
    }

    saludarATodos(seres: [Persona(nombre: "Ana"), Robot(nombre: "R2")])
    ```
*   **Regla práctica:** una función es un **verbo** que ejecutás; un protocol es una **lista de requisitos** que un tipo promete cumplir.

### Protocol Inheritance (herencia de protocolos)

*   **Qué es**: un protocol puede **heredar** de otro protocol (o de varios a la vez), sumando todos sus requisitos más los propios. Cualquier tipo que adopte el protocol hijo tiene que cumplir **todo** el contrato heredado, no solo lo nuevo.
    ```swift
    protocol Identificable {
        var id: Int { get }
    }

    protocol Persistible: Identificable {
        func guardar()
    }

    struct Pedido: Persistible {
        var id: Int          // requisito heredado de Identificable
        func guardar() {     // requisito propio de Persistible
            print("Pedido \(id) guardado")
        }
    }
    ```
*   **A diferencia de las clases** (que solo heredan de **una** superclase), un protocol puede heredar de **varios** protocols a la vez, separados por coma:
    ```swift
    protocol Loggable {
        func log()
    }

    protocol Persistible: Identificable, Loggable {
        func guardar()
    }
    // Persistible ahora exige: id, log() Y guardar()
    ```
*   **No confundir con Protocol Composition (`&`)**: la herencia de protocolos define un **nuevo protocol** que junta requisitos de forma permanente. La composición con `&` es distinta — se usa **al vuelo**, típicamente en la firma de una función, para exigir que un tipo cumpla varios protocols sin necesidad de crear uno nuevo que los combine:
    ```swift
    func procesar(pedido: Identificable & Loggable) {
        pedido.log()
        print(pedido.id)
    }
    ```
*   **Regla práctica**: si la combinación de requisitos se va a **reutilizar** en varios lugares (structs, funciones, params), convenía definir un protocol que herede de los otros (`Persistible: Identificable, Loggable`). Si es algo puntual, **una sola función** que necesita esa combinación, alcanza con `&` ahí mismo.

---

## 🧩 10. Extensions y Protocol Extensions
*   **Extension**: le agrega funcionalidad a un tipo que **ya existe** (`struct`, `class`, `enum`, incluso tipos nativos como `Int` o `String`), sin modificar el archivo original ni heredar.
    ```swift
    extension Int {
        func squared() -> Int {
            return self * self
        }
    }
    ```
*   **Qué SÍ podés agregar**: métodos, computed properties, initializers extra.
*   **Qué NO podés agregar**: stored properties (propiedades con valor guardado). Solo computed.
*   ⚠️ **Método vs Computed Property** *(punto que costó la primera vez, ojo acá)*:
    *   **Método** = función. Se llama con paréntesis → `producto.precioConDescuento()`.
    *   **Computed property** = se declara con `var` + bloque `{ }` que hace `return`. Se accede **sin paréntesis**, como si fuera un atributo → `producto.precioConDescuento`.
    *   **Regla práctica**: si la función no recibe parámetros y solo devuelve algo derivado de las propiedades existentes del tipo, casi siempre conviene que sea `var` computed, no un método.
    ```swift
    struct Producto {
        var nombre: String
        var precio: Double
    }

    extension Producto {
        var precioConDescuento: Double {
            let descuento = 0.9
            return precio * descuento
        }
    }

    let p = Producto(nombre: "Cheeseburger", precio: 1000)
    print(p.precioConDescuento) // 900.0 — sin ()
    ```
*   **Protocol extension**: le da una **implementación por defecto** a los métodos de un protocolo, así los tipos que lo adoptan no están obligados a escribirla de cero. Cualquier tipo puede sobreescribirla si necesita un comportamiento distinto.
    ```swift
    protocol Saludable {
        func saludar()
    }

    extension Saludable {
        func saludar() {
            print("¡Hola desde el default!")
        }
    }

    struct Persona: Saludable { } // usa el default, no lo escribió

    struct Robot: Saludable {
        func saludar() { // lo sobreescribe
            print("BEEP BOOP")
        }
    }
    ```

### Protocol-Oriented Programming (POP)

*   **Qué es**: la filosofía de diseñar la arquitectura de la app como una serie de **protocols** (el "qué"), y usar **protocol extensions** para darles implementación por defecto (el "cómo"). Es el enfoque que Swift favorece por sobre la herencia de clases tradicional (OOP clásico).
*   **La receta en 2 pasos**:
    1.  Definís el contrato con un `protocol` — qué tiene que tener/hacer un tipo, sin importar cómo.
    2.  Le das comportamiento por defecto con una `extension` del protocol — así cualquier tipo que lo adopte lo recibe gratis, y solo sobreescribe si necesita algo distinto (ver ejemplo `Saludable` arriba: `Persona` usa el default, `Robot` lo pisa).
*   **Por qué importa (vs. herencia de clases)**:
    *   Funciona en `struct` y `enum`, no solo en `class` — herencia real (sección 20) es exclusiva de clases.
    *   Un tipo puede adoptar **varios** protocols a la vez (con sus defaults), mientras que una clase solo puede heredar de **una** superclase — evita el problema de "herencia múltiple" que otros lenguajes no permiten.
    *   Menos acoplamiento: cambiar una superclase puede romper toda su cadena de subclases; agregar/sacar un protocol es más quirúrgico.
*   **Cómo se conecta con lo ya visto**:
    *   **Protocol inheritance** (arriba, sección 9) te deja armar protocols compuestos (`Persistible: Identificable, Loggable`) — la base para modelar contratos grandes en piezas chicas.
    *   Es la misma idea de fondo que **SOLID** (sección 13), en particular Dependency Inversion (D) y Interface Segregation (I): depender de abstracciones (`protocol`) chicas y específicas, no de una jerarquía de clases pesada.
*   **Regla práctica**: en Swift, cuando dudes entre "¿hago una clase base y subclases" o "¿hago un protocol + extension con default?" — preferí protocol + extension. Reservá la herencia de clases para cuando de verdad necesitás **estado compartido por referencia** (sección 21) o una relación ES-UN estricta con `override`.

---

## ⚠️ 11. Manejo de Errores (`try`/`catch`)
*   **Qué es**: forma de ejecutar código que puede fallar, atrapando el error de forma anticipada en vez de crashear. Estructura de espíritu similar a `if/else` — "camino feliz vs camino de error". Es **síncrono** por naturaleza, no tiene relación con async/await (una función puede combinar ambos con `async throws`, pero son características independientes).
*   **Sintaxis básica**: `throws` en la función (puede fallar) + `try` al llamarla + `do { } catch { }` para atraparlo.
    ```swift
    enum ErrorPedido: Error {
        case sinStock
    }

    func procesarPedido(cantidad: Int) throws -> String {
        if cantidad <= 0 {
            throw ErrorPedido.sinStock
        }
        return "Pedido procesado"
    }

    do {
        let resultado = try procesarPedido(cantidad: 0)
        print(resultado)
    } catch {
        print("Falló: \(error)")
    }
    ```
*   **`try?`**: convierte el resultado en **Optional** — si falla, devuelve `nil` en vez de crashear. No necesita `do/catch`. Úsalo cuando el error en sí no importa, solo si funcionó o no.
    ```swift
    let resultado = try? procesarPedido(cantidad: 0) // String?, nil si falló
    ```
*   **`try!`**: como el force unwrap (`!`) pero para errores — fuerza que no va a fallar, y si falla **crashea**. Mismo criterio que `!`: solo si controlás 100% que no va a tirar error (nunca con datos externos).
    ```swift
    let resultado = try! procesarPedido(cantidad: 5) // si falla, crash
    ```

---

## 🔀 12. Typecasting / Casting (`as`, `as?`, `as!`)
*   **Contexto — Herencia**: `class PedidoTelegram: Pedido` significa que `PedidoTelegram` **hereda** de `Pedido`. `Pedido` es la **superclase** (genérica), `PedidoTelegram` es la **subclase** (hereda todo y puede agregar lo suyo). *(Fuente: Swift Programming Language docs — "A class can inherit methods, properties, and other characteristics from another class. The inheriting class is a subclass, the class it inherits from is its superclass.")*
*   **Por qué existe el casting**: si guardás cosas en un array del tipo genérico (`[Pedido]`), Swift solo "ve" lo genérico al sacarlas. El casting te deja **confirmar y convertir** hacia el tipo específico (subclase) para acceder a lo que **solo esa subclase tiene**.
*   **Analogía**: una caja etiquetada "Fruta" (genérico) — necesitás confirmar "¿esta fruta es en verdad una Banana?" para poder usar `pelar()`, un método que solo tiene `Banana`, no `Fruta`.
*   **Las 3 variantes**:
    *   `as`: cast **seguro garantizado**, nunca falla — subir en la jerarquía (subclase → superclase). No es Optional.
    *   `as?`: cast que **puede fallar** — devuelve un Optional (`Tipo?`). Se combina con `guard let`/`if let`.
    *   `as!`: fuerza el cast — si falla, **crashea**. Mismo criterio que `!` normal: solo si estás 100% seguro.
*   **Ejemplo (dominio SMASH)**:
    ```swift
    class Pedido {
        var id: Int = 0
    }

    class PedidoTelegram: Pedido {
        func chatId() -> String { return "12345" }
    }

    class PedidoWeb: Pedido {
        func sessionToken() -> String { return "abc" }
    }

    let pedidos: [Pedido] = [PedidoTelegram(), PedidoWeb()]

    for pedido in pedidos {
        if let pedidoTG = pedido as? PedidoTelegram {
            print(pedidoTG.chatId()) // solo existe en PedidoTelegram, no en Pedido
        }
    }
    ```
*   **Con `guard let`**:
    ```swift
    func procesarTelegram(pedido: Pedido) {
        guard let pedidoTG = pedido as? PedidoTelegram else {
            print("No es un pedido de Telegram")
            return
        }
        print(pedidoTG.chatId())
    }
    ```
*   ⚠️ **Ojo con la sintaxis**: `as?` devuelve un Optional — no podés encadenar un método directo (`fruta as? Banana.pelar()` ❌). Hay que desempaquetar primero (`if let`/`guard let`), o usar optional chaining explícito (`(fruta as? Banana)?.pelar()`).

---

## 🏛️ 13. Principios SOLID
*   **Qué son**: 5 principios de diseño (no sintaxis de Swift) para que el código sea fácil de mantener, extender y testear. En Swift se apoyan mucho en `protocol` (sección 9) y `extension` (sección 10) en vez de herencia pesada.

### S — Single Responsibility (Responsabilidad Única)
*   Un tipo debe tener **una sola razón para cambiar** — una sola responsabilidad.
*   ❌ **Mal**: `Pedido` calcula el total, envía la notificación de Telegram Y guarda en la base de datos. Tres razones distintas para tocarlo (cambia el cálculo, cambia la API de Telegram, cambia la DB).
*   ✅ **Bien**: separar en tipos chicos, cada uno con un solo trabajo.
    ```swift
    struct Pedido {
        var items: [String]
        var total: Double
    }

    struct NotificadorTelegram {
        func notificar(pedido: Pedido) { /* ... */ }
    }

    struct RepositorioPedidos {
        func guardar(pedido: Pedido) { /* ... */ }
    }
    ```

### O — Open/Closed (Abierto/Cerrado)
*   El código debe estar **abierto a extensión, cerrado a modificación**. Si cada caso nuevo te obliga a editar una función existente (ej. un `switch` gigante que crece por plataforma), viola OCP.
*   ❌ **Mal**: un `switch` por plataforma que hay que tocar cada vez que aparece una nueva.
    ```swift
    func calcularDescuento(plataforma: Plataforma, total: Double) -> Double {
        switch plataforma {
        case .telegram: return total * 0.9
        case .web: return total * 0.95
        case .instagram: return total // si agrego una plataforma nueva, vuelvo a tocar esta función
        }
    }
    ```
*   ✅ **Bien**: un `protocol` con una implementación por plataforma — agregar una plataforma nueva es agregar un `struct`, no modificar código existente.
    ```swift
    protocol PoliticaDescuento {
        func aplicar(total: Double) -> Double
    }

    struct DescuentoTelegram: PoliticaDescuento {
        func aplicar(total: Double) -> Double { total * 0.9 }
    }

    struct DescuentoWeb: PoliticaDescuento {
        func aplicar(total: Double) -> Double { total * 0.95 }
    }
    ```

### L — Liskov Substitution (Sustitución de Liskov)
*   Un subtipo tiene que poder **reemplazar a su tipo base** sin romper lo que espera quien lo usa. Ver `PedidoTelegram`/`PedidoWeb` heredando de `Pedido` (sección 12) — cualquier función que reciba `Pedido` tiene que funcionar igual sin importar qué subclase le llegue en verdad.
*   **Contraejemplo clásico** (fuera del dominio SMASH, para que quede claro el problema): `Cuadrado` hereda de `Rectangulo` y sobreescribe `ancho`/`alto` para que sean siempre iguales entre sí. Cualquier código que asuma "puedo cambiar `ancho` sin que `alto` se mueva" (válido para `Rectangulo`) se rompe si le pasan un `Cuadrado`. La subclase cambió una expectativa de la superclase → viola LSP.
*   **Regla práctica**: si para que tu subclase "funcione bien" tenés que preguntar `if pedido is PedidoTelegram` en vez de tratarlo como un `Pedido` genérico, probablemente estés violando LSP en algún lado.

### I — Interface Segregation (Segregación de Interfaces)
*   Mejor **muchos protocols chicos y específicos** que uno solo gigante. Nadie debería verse obligado a implementar métodos que no usa.
*   ❌ **Mal**: un protocol enorme donde algunos tipos solo necesitan una parte.
    ```swift
    protocol GestorPedido {
        func calcularTotal() -> Double
        func enviarPorTelegram()
        func enviarPorEmail()
        func generarFacturaPDF()
    }
    // Un pedido de Instagram se ve obligado a implementar enviarPorTelegram(), que no usa
    ```
*   ✅ **Bien**: protocols separados, cada tipo adopta solo lo que necesita.
    ```swift
    protocol CalculaTotal {
        func calcularTotal() -> Double
    }

    protocol NotificablePorTelegram {
        func enviarPorTelegram()
    }

    protocol Facturable {
        func generarFacturaPDF()
    }
    ```

### D — Dependency Inversion (Inversión de Dependencias)
*   Los tipos de "alto nivel" no deberían depender de una implementación concreta de "bajo nivel", sino de una **abstracción** (`protocol`). La implementación concreta también depende del `protocol`, no al revés.
*   ❌ **Mal**: `ProcesadorPedido` depende directo de una clase concreta — si mañana cambiás de base de datos, o querés testear con un mock, tenés que tocar `ProcesadorPedido`.
    ```swift
    struct BaseDeDatosSQL {
        func guardar(pedido: Pedido) { /* ... */ }
    }

    struct ProcesadorPedido {
        let db = BaseDeDatosSQL() // depende de algo concreto
        func procesar(pedido: Pedido) {
            db.guardar(pedido: pedido)
        }
    }
    ```
*   ✅ **Bien**: `ProcesadorPedido` depende de un `protocol`. `BaseDeDatosSQL` (o un `MockPersistencia` para tests) lo implementan, pero `ProcesadorPedido` no sabe ni le importa cuál es.
    ```swift
    protocol Persistencia {
        func guardar(pedido: Pedido)
    }

    struct BaseDeDatosSQL: Persistencia {
        func guardar(pedido: Pedido) { /* ... */ }
    }

    struct ProcesadorPedido {
        let persistencia: Persistencia // depende de la abstracción
        func procesar(pedido: Pedido) {
            persistencia.guardar(pedido: pedido)
        }
    }
    ```

### 📋 Resumen rápido

| Letra | Principio | Pregunta clave |
| :--- | :--- | :--- |
| **S** | Single Responsibility | ¿Este tipo tiene más de una razón para cambiar? |
| **O** | Open/Closed | ¿Agregar un caso nuevo me obliga a modificar código existente? |
| **L** | Liskov Substitution | ¿Puedo reemplazar el tipo base por cualquier subtipo sin sorpresas? |
| **I** | Interface Segregation | ¿Este protocol obliga a implementar algo que no todos necesitan? |
| **D** | Dependency Inversion | ¿Dependo de una implementación concreta o de un `protocol`? |

*   **Por qué importa en Swift particularmente**: SOLID nació pensado para clases/herencia (Java/C++), pero en Swift la herramienta principal para aplicarlo son los `protocol` + `protocol extension` (secciones 9 y 10), no la herencia de clases — Swift favorece **composición sobre herencia**.

---

## 👁️ 14. Property Observers (`didSet` / `willSet`)

Código que se ejecuta automáticamente **cuando una propiedad cambia**. Solo funcionan en stored properties (no en computed).

```swift
struct Progress {
    var amount: Int {
        willSet {
            print("Va a cambiar a \(newValue)")   // newValue = valor entrante
        }
        didSet {
            print("Cambió de \(oldValue) a \(amount)") // oldValue = valor anterior
        }
    }
}
```

| Observer | Cuándo corre | Variable especial |
|---|---|---|
| `willSet` | **Antes** del cambio | `newValue` (el valor que va a entrar) |
| `didSet` | **Después** del cambio | `oldValue` (el valor que había antes) |

**Cuándo usarlos:**
- Validar o corregir un valor apenas cambia
- Actualizar UI cuando cambia un modelo (ej: actualizar un label cuando cambia un puntaje)
- Logging / debugging de cambios de estado

**Regla práctica:** `didSet` es el más común — reaccionás al nuevo estado. `willSet` solo cuando necesitás hacer algo con el valor *anterior* antes de que se pise.

---

## 🔄 15. Mutating Methods

Los structs son **value types** — cuando Swift llama un método en un struct, por defecto lo trata como constante y no te deja modificar sus propiedades adentro. `mutating` es la forma de decirle: *"este método sí va a cambiar el struct, y eso está bien"*.

```swift
struct Counter {
    var count = 0

    // func increment() { count += 1 }  ❌ error: no podés mutar sin mutating

    mutating func increment() {           // ✅
        count += 1
    }
}
```

**Por qué las clases no lo necesitan:** las clases son *reference types* — todos apuntan al mismo objeto en memoria, así que mutar una propiedad siempre afecta al objeto real. No hay ambigüedad.

**Los 3 casos de uso principales:**

1. **Modificar una propiedad interna** — lo más común:
    ```swift
    mutating func reset() {
        count = 0
    }
    ```

2. **Reemplazar `self` entero** — podés pisar toda la instancia:
    ```swift
    mutating func reset() {
        self = Counter()  // reemplaza el struct completo
    }
    ```

3. **Modificar una colección que es propiedad del struct** (porque `append` y similares también mutan):
    ```swift
    struct Playlist {
        var songs: [String]

        mutating func addSong(_ song: String) {
            songs.append(song)  // append muta el array → necesita mutating
        }
    }
    ```

**Consecuencia clave con `let`:** si la instancia es constante, no podés llamar métodos `mutating` sobre ella — Swift no puede mutar algo constante:

```swift
let counter = Counter()
counter.increment()   // ❌ error: counter es constante

var counter2 = Counter()
counter2.increment()  // ✅
```

| | `struct` | `class` |
|---|---|---|
| ¿Necesita `mutating`? | **Sí** | No |
| ¿Por qué? | Value type — Swift no sabe qué copia mutar | Reference type — siempre el mismo objeto |
| ¿`let` bloquea mutación? | **Sí** | No (podés mutar propiedades de un `let` class) |

---

## 🔐 16. Access Control

Controla **quién puede ver y usar** una propiedad o método. De más restrictivo a más abierto:

| Modificador | Quién puede acceder |
|---|---|
| `private` | Solo dentro del mismo bloque `{ }` (o extensiones en el mismo archivo) |
| `fileprivate` | Todo el archivo `.swift` donde está declarado |
| `internal` | Todo el módulo (app). **Es el default — no hace falta escribirlo** |
| `public` | Cualquier módulo que importe este (frameworks). No se puede subclasear/overridear desde afuera |
| `open` | Igual que `public` + permite subclasear y overridear desde afuera |

**En la práctica para una app (no framework), solo usás 3:**

```swift
struct BankAccount {
    private var balance: Double = 0   // nadie de afuera toca esto directo

    var owner: String                 // internal (default) — visible en toda la app

    mutating func deposit(_ amount: Double) {
        balance += amount             // accede a private porque está en el mismo tipo
    }

    private mutating func applyFee() { // detalle de implementación — nadie lo llama de afuera
        balance -= 2.0
    }
}
```

**`fileprivate` — cuándo aparece:**

Cuando dos tipos en el **mismo archivo** necesitan compartir algo que no querés exponer al resto:

```swift
// en el mismo archivo BankAccount.swift
struct BankAccount {
    fileprivate var balance: Double = 0
}

struct Auditor {
    func check(_ account: BankAccount) {
        print(account.balance)  // ✅ mismo archivo
    }
}
```

**Buenas prácticas:**

- **Empezá siempre con `private`** y abrí solo lo necesario. Es más fácil hacer algo público después que restringirlo cuando ya hay código que lo usa.
- **`private` para detalles de implementación** — cosas que pueden cambiar sin avisar (cálculos internos, estado intermedio).
- **`internal` (default) para la interfaz de tu tipo** — lo que otros tipos de la app necesitan usar.
- **`fileprivate` es una señal de código smell leve** — si dos tipos necesitan compartir privados, a veces conviene fusionarlos o repensar la separación.
- **`public`/`open` solo si estás haciendo un framework** — en una app nunca los necesitás.

**Regla mental:** preguntate "¿quién *realmente* necesita ver esto?" y elegí el nivel más restrictivo que lo permita.

---

## 🏷️ 17. Static Properties y Methods

`static` hace que una propiedad o método pertenezca al **tipo en sí**, no a cada instancia. Se accede por el nombre del tipo, no por una variable.

```swift
struct AppConfig {
    static let version = "1.0.0"       // propiedad estática
    static func printVersion() {        // método estático
        print(version)                  // dentro del tipo, no hace falta AppConfig.version
    }
}

AppConfig.printVersion()   // ✅ — se llama en el tipo
// let config = AppConfig()
// config.version          // ❌ — no existe en la instancia
```

**Los 4 casos de uso reales:**

1. **Constantes compartidas** — valores que pertenecen al concepto, no a una instancia:
    ```swift
    struct Pedido {
        static let ivaRate = 0.21
        var subtotal: Double
        var total: Double { subtotal * (1 + Pedido.ivaRate) }
    }
    ```

2. **Contador global de instancias** — estado compartido entre todas:
    ```swift
    struct Player {
        static var count = 0
        init() { Player.count += 1 }
    }
    Player(); Player()
    print(Player.count)  // 2
    ```

3. **Factory / constructores alternativos** — crear instancias con lógica prearmada:
    ```swift
    struct Color {
        var r, g, b: Double
        static let red   = Color(r: 1, g: 0, b: 0)
        static let green = Color(r: 0, g: 1, b: 0)
    }
    let c = Color.red
    ```

4. **Utilidades sin estado** — funciones que no necesitan datos de instancia:
    ```swift
    struct Formatter {
        static func currency(_ value: Double) -> String {
            "$\(String(format: "%.2f", value))"
        }
    }
    Formatter.currency(1500)  // "$1500.00"
    ```

**`static` vs `class` (solo en clases):**

| | `static` | `class` |
|---|---|---|
| Funciona en | struct, class, enum | solo class |
| Subclase puede overridear | ❌ No | ✅ Sí |

```swift
class Animal {
    static func tipo() -> String { "Animal" }
    class func descripcion() -> String { "Soy un animal" }
}

class Perro: Animal {
    // override static func tipo() { }  ❌ error
    override class func descripcion() -> String { "Soy un perro" }  // ✅
}
```

**Buenas prácticas:**
- Usá `static` para constantes de configuración y utilidades sin estado — evitás crear instancias innecesarias.
- Si una función no usa `self` ni propiedades de instancia, considerá hacerla `static`.
- Cuidado con `static var` mutable como estado global — puede generar bugs difíciles de rastrear si se modifica desde muchos lados.

---

## 🏗️ 18. Initializers (`init`)

### Structs — memberwise initializer gratis

Swift **genera automáticamente** un `init` que recibe todas las stored properties como parámetros. Se llama *memberwise initializer* (no tiene traducción oficial — literal sería "inicializador por miembros").

```swift
struct Person {
    var name: String
    var age: Int
}

let p = Person(name: "Carlos", age: 30)  // ✅ sin escribir init
```

Podés escribir tu propio `init` para agregar lógica (como un print, validación, etc.):

```swift
struct Person {
    var name: String
    init(name: String) {
        print("\(name) fue creado")
        self.name = name   // self.name = propiedad, name = parámetro
    }
}
```

⚠️ **Si definís tu propio `init`, el memberwise desaparece.** Si querés conservar ambos, poné tu init custom en una `extension`:

```swift
struct Person {
    var name: String
    var age: Int
}

extension Person {
    init(name: String) {   // init extra sin perder el memberwise
        self.name = name
        self.age = 0
    }
}

Person(name: "Ana", age: 25)  // ✅ memberwise sigue vivo
Person(name: "Bob")           // ✅ tu init custom
```

---

### Clases — siempre escribís el init vos

Las clases **no tienen memberwise initializer**. Si tenés propiedades sin valor por defecto, Swift te obliga a escribir el `init`.

```swift
class Person {
    var name: String
    var age: Int

    init(name: String, age: Int) {   // obligatorio
        self.name = name
        self.age = age
    }
}
```

En herencia, el init de la subclase debe llamar `super.init()` **después de inicializar sus propias propiedades**:

```swift
class Employee: Person {
    var company: String

    init(name: String, age: Int, company: String) {
        self.company = company      // 1. primero las propias
        super.init(name: name, age: age)  // 2. después super
    }
}
```

---

### Diferencias clave struct vs class

| | Struct | Class |
|---|---|---|
| Memberwise init automático | ✅ Sí | ❌ No |
| `self.X` antes de asignar | ❌ Error | ❌ Error |
| Llama a `super.init()` | No aplica | ✅ Obligatorio en herencia |
| Orden en el init | Podés usar parámetros antes de asignar `self.X` | Igual — `self.X` primero, `super` después |

**Regla práctica:** en structs, escribís `init` solo si necesitás lógica extra. En clases, siempre lo escribís vos.

---

## 🔒 19. `final`

Bloquea una clase para que **no pueda ser subclaseada**. También se puede aplicar a métodos o propiedades individuales para bloquear solo ese override.

```swift
final class PaymentProcessor { }       // nadie puede heredar de esta clase
class Free: PaymentProcessor { }       // ❌ error: cannot inherit from final class
```

```swift
class Animal {
    final func respirar() { }          // este método no se puede overridear
    func hablar() { }                  // este sí
}

class Perro: Animal {
    override func hablar() { }         // ✅
    override func respirar() { }       // ❌ error
}
```

**Cuándo usarlo:**
- Clases diseñadas para usarse tal cual, sin personalización (`NetworkManager`, `Logger`, etc.)
- Por **performance**: Swift optimiza mejor las llamadas porque sabe en tiempo de compilación qué función va a ejecutar, sin buscar en la jerarquía de herencia.
- Como señal de diseño: `final` comunica *"esto no está pensado para extenderse"*.

**Regla práctica:** si no tenés un motivo explícito para que tu clase sea heredable, marcala `final` por defecto.

---

## 🧬 20. Herencia (`subclass`) vs `extension`

En otros lenguajes (TypeScript, Java) `extends` hace las dos cosas. En Swift están **separadas e intencionalmente distintas**.

### Subclass — relación ES-UN, tipo nuevo

```swift
class Animal {
    func hablar() { print("...") }
}

class Perro: Animal {                          // Perro ES UN Animal
    override func hablar() { print("Guau") }  // reemplaza comportamiento
    var raza: String = "Labrador"             // agrega propiedades nuevas
}
```

Usás subclass cuando:
- El nuevo tipo *realmente es* una versión del tipo base
- Necesitás `override` — cambiar cómo funciona algo heredado
- Necesitás agregar stored properties al tipo base

### Extension — agrega habilidades, sin tipo nuevo

```swift
extension Animal {
    func dormir() { print("Zzz") }  // Animal y sus subclases lo ganan automáticamente
}
```

Usás extension cuando:
- Querés agregar funcionalidad sin crear un tipo nuevo
- Querés organizar código (separar init, conformar un protocol, métodos privados)
- Trabajás con tipos que no son tuyos (`String`, `Int`, `Array`)
- El tipo es `struct` o `enum` — **que no soportan herencia**

### Tabla comparativa

| | Subclass | Extension |
|---|---|---|
| Crea tipo nuevo | ✅ Sí | ❌ No |
| Puede hacer `override` | ✅ Sí | ❌ No |
| Funciona en struct/enum | ❌ No | ✅ Sí |
| Puede agregar stored properties | ✅ Sí | ❌ No (solo computed) |
| Puede extender tipos externos | ❌ No | ✅ Sí |

**La diferencia en una línea:**
> Subclass crea una nueva identidad. Extension le agrega habilidades a una identidad que ya existe.

**Por qué Swift prefiere extension sobre subclass:** la herencia crea acoplamiento fuerte — si cambiás la superclase, podés romper todas las subclases. Swift favorece `protocol` + `extension` en vez de jerarquías de herencia (ver SOLID sección 13, principio D).

---

## 🆚 21. Structs vs Classes

*   **Struct**: **value type** — cuando lo asignás o pasás, Swift hace una **copia**. Cada variable tiene su propia versión independiente.
*   **Class**: **reference type** — cuando lo asignás o pasás, todas las variables apuntan al **mismo objeto** en memoria. Si uno lo cambia, todos lo ven.
*   **Regla práctica**: ¿los datos son independientes entre quien los crea y quien los recibe? → `struct`. ¿necesitás que múltiples partes del código compartan y vean el mismo objeto? → `class`.

```swift
// STRUCT — copia independiente
struct PointS { var x: Int }
var a = PointS(x: 1)
var b = a       // b es una copia de a
b.x = 99
print(a.x)      // 1 — a no cambió

// CLASS — referencia compartida
class PointC { var x: Int; init(x: Int) { self.x = x } }
var c = PointC(x: 1)
var d = c       // d apunta al mismo objeto que c
d.x = 99
print(c.x)      // 99 — c también cambió
```

### Tabla de diferencias

| | `struct` | `class` |
|---|---|---|
| Tipo | Value type (copia) | Reference type (referencia compartida) |
| Herencia | ❌ No soporta | ✅ Sí (`class Perro: Animal`) |
| Memberwise init automático | ✅ Sí | ❌ No — escribís el tuyo siempre |
| Métodos que mutan propiedades | Necesitan `mutating` | Sin `mutating` |
| `let` bloquea mutación | ✅ Todo el struct es inmutable | ❌ Solo bloquea reasignar la referencia — las propiedades se pueden mutar igual |
| `deinit` (cleanup al destruir) | ❌ No | ✅ Sí |
| Identidad (`===`) | ❌ No tiene sentido | ✅ Podés comparar si dos vars apuntan al mismo objeto |
| `final` | No aplica | ✅ Bloquea subclasear (sección 19) |

### El comportamiento de `let` es distinto — ojo acá

```swift
// STRUCT con let — nada se puede cambiar
let s = PointS(x: 1)
s.x = 5   // ❌ error: s es constante, todo el struct es inmutable

// CLASS con let — la referencia es fija, pero las propiedades no
let c = PointC(x: 1)
c.x = 5   // ✅ podés mutar propiedades — `let` solo fija a qué objeto apunta c
```

### ¿Cuándo usar cada uno?

**Preferí `struct` cuando:**
- Los datos son simples y auto-contenidos (coordenadas, colores, configuración)
- No necesitás herencia
- Querés que cada copia sea independiente (sin efectos secundarios sorpresa)
- Es el **default en Swift** — la stdlib usa structs para `String`, `Array`, `Dictionary`, etc.

**Usá `class` cuando:**
- Necesitás herencia (`class ViewController: UIViewController`)
- Necesitás que múltiples partes del código compartan **el mismo objeto**
- Necesitás `deinit` para limpiar recursos (conexiones, archivos)
- Trabajás con frameworks de Apple (UIKit/AppKit usan clases)

---

## 🗑️ 22. Deinitializers (`deinit`)

Solo disponible en **clases**. Se ejecuta automáticamente cuando el objeto es destruido — cuando ya no hay ninguna variable apuntando a él y Swift libera la memoria.

```swift
class DatabaseConnection {
    init() {
        print("Conexión abierta")
    }
    deinit {
        print("Conexión cerrada")  // corre solo, sin que vos lo llames
    }
}

var conn: DatabaseConnection? = DatabaseConnection()  // "Conexión abierta"
conn = nil                                            // "Conexión cerrada"
```

**Reglas:**
- No lleva paréntesis ni parámetros — es siempre `deinit { }`
- No lo llamás vos — Swift lo llama solo cuando destruye el objeto
- Solo existe en `class`, no en `struct` (porque los structs se copian, no se comparten)

**Casos de uso reales:**

1. **Cerrar conexiones** (base de datos, sockets, archivos):
    ```swift
    class FileLogger {
        let file: FileHandle
        init() { file = FileHandle(/* ... */) }
        deinit { file.closeFile() }
    }
    ```

2. **Remover observers** — evitar memory leaks en NotificationCenter:
    ```swift
    class ViewController {
        init() { NotificationCenter.default.addObserver(/* ... */) }
        deinit  { NotificationCenter.default.removeObserver(self) }
    }
    ```

3. **Cancelar timers o tareas en background**:
    ```swift
    class PollingService {
        var timer: Timer?
        deinit { timer?.invalidate() }
    }
    ```

4. **Debugging** — confirmar que un objeto se está liberando (útil para detectar retain cycles):
    ```swift
    class ViewModel {
        deinit { print("ViewModel liberado ✓") }
    }
    ```

**Regla práctica:** si tu clase abre algo (conexión, observer, timer, archivo), cerralo en `deinit`. Es el equivalente al `finally` de un try/catch pero para la vida del objeto.

---

## 🔁 23. Mutabilidad: Structs vs Classes

La diferencia viene de la naturaleza de cada tipo: los structs son **valores**, las clases son **referencias**.

### En structs — `var`/`let` controla todo

`var` o `let` determina si el struct entero es mutable o no. No hay matices.

```swift
struct Person {
    var name: String
    var age: Int
}

var p1 = Person(name: "Ana", age: 30)
p1.name = "Carlos"   // ✅ p1 es var → todo mutable

let p2 = Person(name: "Ana", age: 30)
p2.name = "Carlos"   // ❌ error: p2 es let → nada se puede cambiar
```

Con `let`, el struct entero queda congelado — propiedades, métodos mutating, todo bloqueado.

### En clases — `var`/`let` solo controla la referencia

`var` o `let` en una clase solo dice si podés **apuntar a otro objeto**. Las propiedades del objeto se pueden mutar igual.

```swift
class Person {
    var name: String
    var age: Int
    init(name: String, age: Int) { self.name = name; self.age = age }
}

let p3 = Person(name: "Ana", age: 30)
p3.name = "Carlos"   // ✅ let solo fija la referencia, no el contenido
p3.age = 25          // ✅ igual

var p4 = Person(name: "Ana", age: 30)
p4 = Person(name: "Luis", age: 20)   // ✅ p4 es var → podés apuntar a otro objeto

let p5 = Person(name: "Ana", age: 30)
p5 = Person(name: "Luis", age: 20)   // ❌ error: p5 es let → no podés reasignar la referencia
```

### La analogía para no confundirse

Pensá en una clase como una **casa** y la variable como una **dirección escrita en papel**:

- `let` en una clase = la dirección escrita en papel es permanente (no podés borrarla y escribir otra) — pero podés entrar a la casa y redecorarla como quieras.
- `let` en un struct = la casa entera está sellada, no podés cambiar nada adentro.

### Tabla resumen

| | `var struct` | `let struct` | `var class` | `let class` |
|---|---|---|---|---|
| Mutar propiedades | ✅ | ❌ | ✅ | ✅ |
| Reasignar la variable a otro objeto | ✅ | ❌ | ✅ | ❌ |
| Llamar métodos `mutating` | ✅ | ❌ | No aplica | No aplica |

**Regla práctica:** en structs, `let` es un escudo total. En clases, `let` solo ancla el puntero — el objeto en sí sigue siendo mutable.
