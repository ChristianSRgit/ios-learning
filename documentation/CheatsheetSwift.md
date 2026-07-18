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
*   **Force Unwrapping (`!`)**: ⚠️ Peligroso. Crash inmediato si el valor es `nil`.
*   **Optional Binding (`if let`)**: 🔒 Seguro. Crea constante temporal dentro del bloque `if`.
*   **Early Exit (`guard let`)**: 🛡️ Seguro. Valida al inicio → `else { return }`. Valor disponible en todo el scope restante.
*   **Nil Coalescing (`??`)**: 🔄 Provee valor por defecto si es `nil`.
*   **Optional Chaining (`?.`)**: 🔗 Accede a propiedades. Devuelve `nil` si cualquier eslabón es `nil`.
*   **Qué es un Optional, en criollo**: una "caja" (`String?`, `Int?`, etc.) que puede estar llena (con un valor de ese tipo) o vacía (`nil`). El tipo por dentro sigue siendo estricto — a un `String?` no le podés asignar un `Int`, ni compila.
*   **¿Cuándo es legítimo `!`?**: solo cuando el `nil` depende de algo que **vos controlás** (literal fijo, asset agregado al proyecto, invariante ya verificada arriba). Si el `nil` puede venir de algo **externo** (API, usuario, archivo, red) → siempre `guard`/`if let`, nunca `!`.
*   **`if let` vs `guard let`** (diferencia clave: scope + intención):
    *   `if let`: el valor desempaquetado solo existe **dentro del bloque `{ }`**. Úsalo cuando ambos caminos (con/sin valor) son válidos y la función sigue teniendo sentido igual.
    *   `guard let`: si es `nil`, obliga a salir (`return`/`break`/`throw`) en el `else`. Si pasa, el valor queda disponible en **todo el resto de la función**. Úsalo cuando el valor es un **requisito** para continuar.

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
