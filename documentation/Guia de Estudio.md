# Guía de Estudio Swift: Fundamentos y Práctica (para Windows/Linux)

Esta guía está diseñada para que domines las bases de Swift sin necesidad de una Mac, aprovechando tu experiencia previa en programación. El enfoque es práctico y orientado a consola.

---

## 🛠️ Paso 1: Configurar el Entorno en Windows

Como estás en Windows, no podés usar Xcode para apps de iOS todavía, pero podés escribir y ejecutar Swift de dos formas:

1. **Rápida (Online):** Usá [Swift Playground en línea (Online Swift REPL)](https://www.swift.org/playgrounds/) o [replit.com](https://replit.com/) para escribir código rápido en el navegador.
2. **Local (Recomendado):**
   - Descargá el instalador oficial de Swift para Windows desde [swift.org/download](https://www.swift.org/download/).
   - Instalá la extensión **Swift** en VS Code.
   - Compilá y ejecutá en tu terminal con:
     ```bash
     swift run
     # o ejecutando un archivo directamente:
     swift main.swift
     ```

---

## 📚 Paso 2: Ruta de Conceptos Teóricos

Estudiá los conceptos en este orden lógico. Como ya sabés algo de OOP y scripting, hacé foco en la **sintaxis de Swift** y sus particularidades (como el manejo de nulos seguro).

1. **Básicos y Control de Flujo:**
   - **Variables (`var`) y Constantes (`let`):** En Swift todo lo que no cambie debe ser constante.
   - **Opcionales (`Int?`, `String?`):** La forma en que Swift evita errores de "null pointer".
   - **Unwrapping:** Aprendé a desempaquetar opcionales usando `guard let` (para salir rápido) e `if let` (para bloques locales).
2. **Colecciones:**
   - **Array:** Ordenados, indexados.
   - **Dictionary:** Clave-valor.
   - **Set:** Valores únicos, no ordenados.
3. **Funciones y Closures:**
   - Firmas de funciones, etiquetas de parámetros (internos y externos).
   - **Closures:** Bloques de código autónomos (como funciones anónimas o lambdas).
4. **Estructuras de Datos y OOP:**
   - **Enums:** Muy potentes en Swift, especialmente con **Associated Values** (pasar datos dentro de un caso).
   - **Structs vs Classes:** 
     - *Structs:* Tipo valor (se copian), preferidos en Swift.
     - *Classes:* Tipo referencia, soportan herencia.
   - **Protocols:** Equivalentes a interfaces en otros lenguajes.
   - **Extensions:** Agregar funcionalidad a tipos existentes sin herencia.
5. **Avanzado:**
   - **Error handling:** `do-try-catch` y funciones que lanzan errores (`throws`).
   - **Generics:** Escribir código flexible y reutilizable para cualquier tipo.

---

## 💻 Paso 3: Trabajos Prácticos (Laboratorios)

Hacé estos tres proyectos en orden en tu terminal:

### Lab 1: CLI Tip Calculator (Calculadora de Propinas)
* **Objetivo:** Practicar variables, constantes, tipos numéricos y entrada/salida de datos por consola.
* **Qué hacer:** Pedir al usuario el total de la cuenta, el porcentaje de propina (ej. 10%, 15%, 20%) y mostrar el total a pagar.
* **Tip de Swift:** Usá `readLine()` para leer entrada de terminal y convertilo a `Double`. Recuerda que `readLine()` devuelve un opcional (`String?`), así que debes desempaquetarlo de forma segura.

### Lab 2: Protocol-based Shape Area Calculator (Calculadora de Áreas)
* **Objetivo:** Dominar Protocolos (`protocols`), Structs y Polimorfismo.
* **Qué hacer:** 
  1. Creá un protocolo `Shape` con una propiedad `area: Double` (solo lectura).
  2. Creá structs como `Circle`, `Rectangle` y `Triangle` que implementen `Shape`.
  3. Creá un array de `[Shape]` y recorrelo imprimiendo el área de cada figura.

### Lab 3: Linked List (Lista Enlazada)
* **Objetivo:** Entender la diferencia entre Structs y Classes, manejo de memoria y referencias.
* **Qué hacer:** 
  1. Creá una clase `Node` (clase, porque necesitamos que sea tipo referencia para apuntar al siguiente nodo). Debe tener un valor genérico `T` y una propiedad `next: Node?`.
  2. Creá un struct `LinkedList` que maneje el nodo inicial (`head`) y métodos para agregar (`append`), eliminar (`remove`) e imprimir la lista.

---

## 🎯 Cómo seguir esta guía (Método de Estudio)

1. **Teoría Corta (20-30 min):** Leé un tema en [swift.org](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/) o mirá un video rápido.
2. **Escribir Código (40-60 min):** No copies y pegues. Escribí el código en VS Code o en un playground online, hacelo fallar y arreglalo.
3. **Completa los Labs en orden:** No pases al siguiente lab hasta que el anterior compile sin errores.
4. **Preguntame lo que quieras:** Si un concepto como *Closures* o *Optionals* te confunde, o si el compilador te tira un error que no entendés, pasame tu código y lo resolvemos juntos.
