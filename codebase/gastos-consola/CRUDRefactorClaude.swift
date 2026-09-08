import Foundation

// MARK: - Presentación (colores, mensajes)
// Agrupar constantes relacionadas en un enum con static let evita contaminar
// el espacio de nombres global y deja claro que son un grupo cohesivo.
enum ANSIColor {
    static let cyan = "\u{001B}[0;36m"
    static let red = "\u{001B}[0;31m"
    static let green = "\u{001B}[0;32m"
    static let reset = "\u{001B}[0;0m"
}

enum Mensaje {
    static let bienvenida = "\nBienvenido a Gastos Consola\n"
    static let menu = "\(ANSIColor.cyan)\nIngrese un comando (1: Agregar, 2: Listar, 3: Total, 4: Filtrar, 5: Editar, 6: Salir):\n\(ANSIColor.reset)"
    static let comandoDesconocido = "\(ANSIColor.red)\nComando desconocido\n\(ANSIColor.reset)"
    static let elegirGastoAEditar = "\nIngrese el numero del gasto a editar \n"
    static let opcionesEditar = "\(ANSIColor.cyan)\n1: Editar monto, 2: Editar categoria, 3: Editar descripción\n\(ANSIColor.reset)"
    static let opcionesFiltrar = "\(ANSIColor.cyan)\nIngrese un comando:\n 1: Filtrar por categoria. \n 2: Filtrar por monto Maximo. \n 3: Filtrar por descripcion.\n 4: volver al menu principal.\n\(ANSIColor.reset)"
}

// MARK: - Modelo

// Nombres de casos en lowerCamelCase: es la convención de Swift para enums
// (los tipos van en PascalCase, los valores/casos en lowerCamelCase).
enum Categoria: Int, CaseIterable {
    case comida = 1
    case transporte = 2
    case ocio = 3
    case otros = 4

    // Antes el menú de categorías estaba hardcodeado como texto en 3 lugares
    // distintos (agregar, editar, filtrar). Generarlo desde CaseIterable
    // significa que si mañana agregás una categoría, el menú se actualiza solo.
    static var menuDescripcion: String {
        Categoria.allCases
            .map { "\($0.rawValue): \($0.nombre)" }
            .joined(separator: ", ")
    }

    var nombre: String {
        switch self {
        case .comida: return "Comida"
        case .transporte: return "Transporte"
        case .ocio: return "Ocio"
        case .otros: return "Otros"
        }
    }
}

struct Gasto: Identifiable {
    let id: UUID = UUID()
    var categoria: Categoria
    var monto: Double
    var descripcion: String?
}

extension Gasto: CustomStringConvertible {
    var description: String {
        "\(categoria.nombre) - $\(monto) - \(descripcion ?? "Sin descripción")"
    }
}

// MARK: - Entrada de usuario
// Los tres bucles "while hasValidX == nil { ... }" del original repetían la
// misma forma (leer línea, intentar convertir, avisar error, reintentar) para
// tres tipos distintos. Extraerlo a funciones genéricas de lectura elimina esa
// triplicación y hace que el bucle de "agregar" se lea como una lista de pasos.
enum Lector {
    static func leerEntero(prompt: String, dentroDe rango: ClosedRange<Int>? = nil) -> Int {
        while true {
            print(prompt)
            let input = readLine() ?? ""
            if let valor = Int(input), rango == nil || rango!.contains(valor) {
                return valor
            }
            print("\(ANSIColor.red)Valor inválido. Intente nuevamente.\n\(ANSIColor.reset)")
        }
    }

    static func leerMontoPositivo(prompt: String) -> Double {
        while true {
            print(prompt)
            let input = readLine() ?? ""
            if let valor = Double(input), valor >= 0 {
                return valor
            }
            print("\(ANSIColor.red)Monto inválido, debe ser un número positivo. Intente nuevamente.\n\(ANSIColor.reset)")
        }
    }

    static func leerCategoria(prompt: String) -> Categoria {
        while true {
            let numero = leerEntero(prompt: prompt)
            if let categoria = Categoria(rawValue: numero) {
                return categoria
            }
            print("\(ANSIColor.red)Categoría inválida, debe estar entre 1 y \(Categoria.allCases.count). Intente nuevamente.\n\(ANSIColor.reset)")
        }
    }

    static func leerDescripcionOpcional(prompt: String) -> String? {
        print(prompt)
        let input = readLine() ?? ""
        return input.isEmpty ? nil : input
    }
}

// MARK: - Almacenamiento y CRUD
// El original mutaba un `var gastos: [Gasto]` global directamente desde el
// bucle principal y desde funciones sueltas. Envolver el estado en una clase
// con métodos CRUD explícitos (create/read/update/delete) hace el contrato
// del archivo más claro y es lo que el nombre "CRUD.swift" promete.
final class GastosStore {
    private(set) var gastos: [Gasto]

    init(gastos: [Gasto] = []) {
        self.gastos = gastos
    }

    // Create
    func agregar(_ gasto: Gasto) {
        gastos.append(gasto)
    }

    // Read
    func listar() -> [Gasto] {
        gastos
    }

    func total() -> Double {
        gastos.reduce(0) { $0 + $1.monto }
    }

    func filtrar(porCategoria categoria: Categoria) -> [Gasto] {
        gastos.filter { $0.categoria == categoria }
    }

    func gastoDeMayorMonto() -> Gasto? {
        gastos.max(by: { $0.monto < $1.monto })
    }

    func filtrar(descripcionContiene texto: String) -> [Gasto] {
        gastos.filter { ($0.descripcion ?? "").localizedCaseInsensitiveContains(texto) }
    }

    // Update
    func editarMonto(id: UUID, nuevoMonto: Double) {
        guard let index = gastos.firstIndex(where: { $0.id == id }) else { return }
        gastos[index].monto = nuevoMonto
    }

    func editarCategoria(id: UUID, nuevaCategoria: Categoria) {
        guard let index = gastos.firstIndex(where: { $0.id == id }) else { return }
        gastos[index].categoria = nuevaCategoria
    }

    func editarDescripcion(id: UUID, nuevaDescripcion: String?) {
        guard let index = gastos.firstIndex(where: { $0.id == id }) else { return }
        gastos[index].descripcion = nuevaDescripcion
    }

    // Delete
    // El CRUD original no tenía "delete" en el menú; se agrega acá para que
    // el store cumpla el contrato completo. La UI de consola de abajo no lo
    // expone todavía — es intencional, sería una feature nueva del menú.
    func eliminar(id: UUID) {
        gastos.removeAll { $0.id == id }
    }
}

// MARK: - Comandos de menú
// Reemplaza los "case "1":", "case "2":"... con nombres. El switch principal
// ahora se lee como una tabla de comandos en vez de números mágicos.
enum ComandoMenu: String {
    case agregar = "1"
    case listar = "2"
    case total = "3"
    case filtrar = "4"
    case editar = "5"
    case salir = "6"
}

// MARK: - Funciones de comando

func mostrarListado(_ store: GastosStore) {
    print("\nListado de gastos:\n")
    for (index, gasto) in store.listar().enumerated() {
        print("#\(index + 1) -> \(gasto)")
    }
}

func ejecutarAgregar(_ store: GastosStore) {
    print("Ingrese la categoría del gasto (\(Categoria.menuDescripcion)):\n")
    let categoria = Lector.leerCategoria(prompt: "")
    let monto = Lector.leerMontoPositivo(prompt: "Ingrese el monto del gasto:")
    let descripcion = Lector.leerDescripcionOpcional(
        prompt: "Ingrese una descripción del gasto (opcional, enter para omitir):"
    )

    store.agregar(Gasto(categoria: categoria, monto: monto, descripcion: descripcion))
    print("\(ANSIColor.green)Gasto agregado exitosamente ✅ .\n\(ANSIColor.reset)")
}

func ejecutarTotal(_ store: GastosStore) {
    print("\nCalculando el total de gastos...\n")
    print("El total de gastos es \(store.total())\n")
}

func ejecutarFiltrar(_ store: GastosStore) {
    var filtrando = true
    while filtrando {
        print(Mensaje.opcionesFiltrar)
        let opcion = readLine() ?? ""

        switch opcion {
        case "1":
            // En el original este caso pedía la categoría por consola pero
            // nunca leía la respuesta ni filtraba: quedaba sin efecto.
            let categoria = Lector.leerCategoria(
                prompt: "Ingrese la categoría por la que desea filtrar (\(Categoria.menuDescripcion)):"
            )
            let resultados = store.filtrar(porCategoria: categoria)
            if resultados.isEmpty {
                print("\nNo hay gastos en la categoría \(categoria.nombre).")
            } else {
                resultados.forEach { print("\n\($0)") }
            }

        case "2":
            if let maxGasto = store.gastoDeMayorMonto() {
                print("\nEl gasto máximo es de \(maxGasto.monto) en la categoría \(maxGasto.categoria.nombre) con descripción: \(maxGasto.descripcion ?? "Sin descripción").")
            } else {
                print("\nNo hay gastos registrados.")
            }

        case "3":
            // Mismo problema que el caso "1": pedía la descripción y no la usaba.
            print("\nIngrese la descripción por la que desea filtrar:")
            let texto = readLine() ?? ""
            let resultados = store.filtrar(descripcionContiene: texto)
            if resultados.isEmpty {
                print("\nNingún gasto coincide con \"\(texto)\".")
            } else {
                resultados.forEach { print("\n\($0)") }
            }

        case "4":
            filtrando = false

        default:
            print(Mensaje.comandoDesconocido)
        }
    }
}

func ejecutarEditar(_ store: GastosStore) {
    mostrarListado(store)
    print(Mensaje.elegirGastoAEditar)

    let gastos = store.listar()
    let numeroGasto = Lector.leerEntero(prompt: "", dentroDe: 1...max(gastos.count, 1))
    guard numeroGasto <= gastos.count else {
        print("\(ANSIColor.red)\nNúmero de gasto inválido.\n\(ANSIColor.reset)")
        return
    }

    let id = gastos[numeroGasto - 1].id
    print(Mensaje.opcionesEditar)
    let opcion = readLine() ?? ""

    switch opcion {
    case "1":
        let nuevoMonto = Lector.leerMontoPositivo(prompt: "Ingrese el nuevo monto:")
        store.editarMonto(id: id, nuevoMonto: nuevoMonto)
        print("\(ANSIColor.green)Monto actualizado exitosamente ✅ .\n\(ANSIColor.reset)")

    case "2":
        let nuevaCategoria = Lector.leerCategoria(
            prompt: "Ingrese la nueva categoría (\(Categoria.menuDescripcion)):"
        )
        store.editarCategoria(id: id, nuevaCategoria: nuevaCategoria)
        print("\(ANSIColor.green)Categoría actualizada exitosamente ✅ .\n\(ANSIColor.reset)")

    case "3":
        let nuevaDescripcion = Lector.leerDescripcionOpcional(
            prompt: "Ingrese la nueva descripción (deje en blanco para eliminar):"
        )
        store.editarDescripcion(id: id, nuevaDescripcion: nuevaDescripcion)
        print("\(ANSIColor.green)Descripción actualizada exitosamente ✅ .\n\(ANSIColor.reset)")

    default:
        print(Mensaje.comandoDesconocido)
    }
}

// MARK: - Bucle principal

let store = GastosStore(gastos: [
    Gasto(categoria: .comida, monto: 10000, descripcion: "Comida en restaurante"),
    Gasto(categoria: .transporte, monto: 5000, descripcion: "Nafta para el picante"),
    Gasto(categoria: .ocio, monto: 1000)
])

print(Mensaje.bienvenida)
print(Mensaje.menu)

var isRunning = true
while isRunning {
    let input = readLine() ?? ""
    guard let comando = ComandoMenu(rawValue: input) else {
        print(Mensaje.comandoDesconocido)
        continue
    }

    switch comando {
    case .agregar:
        ejecutarAgregar(store)
    case .listar:
        mostrarListado(store)
    case .total:
        ejecutarTotal(store)
    case .filtrar:
        ejecutarFiltrar(store)
    case .editar:
        ejecutarEditar(store)
    case .salir:
        print("Saliendo de la consola...")
        isRunning = false
    }

    if isRunning {
        print(Mensaje.menu)
    }
}
