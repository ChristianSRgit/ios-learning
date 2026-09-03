import Foundation

enum ANSIColor: String {
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case reset = "\u{001B}[0;0m"
}

enum Mensaje: String {
    case bienvenida = "\nBienvenido a Gastos Consola\n"
    case menu = "\u{001B}[0;36m\nIngrese un comando (1: Agregar, 2: Listar, 3: Total,4 filtrar, 5: Editar, 6: Salir):\n\u{001B}[0;0m"
    case unknown = "\u{001B}[0;31m\nComando desconocido\n\u{001B}[0;0m"
    case editarGasto = "\nIngrese el numero del gasto a editar \n"
    case editarOpciones = "\u{001B}[0;36m\n1: Editar monto, 2: Editar categoria, 3: Editar descripción,4: Cancelar edición\n\u{001B}[0;0m"
    case filtrar = "\u{001B}[0;36m\nIngrese un comando:\n 1: Filtrar por categoria. \n 2: Filtrar por monto Maximo. \n 3: Filtrar por descripcion.\n 4: Total por categoria.\n 5: volver al menu principal.\n\u{001B}[0;0m"
}

// MARK: - Estructuras y enumeraciones
print(Mensaje.bienvenida.rawValue)
print(Mensaje.menu.rawValue)

enum Categoria: Int, CaseIterable {
    case Comida = 1
    case Transporte = 2
    case Ocio = 3
    case Otros = 4
}

struct Gasto {
    let id: UUID = UUID()
    var categoria: Categoria
    var monto: Double
    var descripcion: String?
}

var gastos: [Gasto] = [
    Gasto(categoria: .Comida, monto:10000, descripcion: "Comida en restaurante"),
    Gasto(categoria: .Transporte, monto:5000, descripcion: "Nafta para el picante"),
    Gasto(categoria: .Ocio, monto:1000)
]


func listarComando(){
    for (index,gasto) in gastos.enumerated() {
    print("\nGastaste en #\(index + 1) -> \(gasto.categoria) un monto de \(gasto.monto) - \(gasto.descripcion ?? "Sin descripción").\n")
    }
}

func totalComando()-> String {
    var total: Double = 0
    for gasto in gastos {
        total += gasto.monto
    }
    return "El total de gastos es \(total)"
}

func agregarComando(gasto:Gasto) {
    gastos.append(gasto)
    print("Gasto agregado exitosamente")
}


// MARK: - Bucle principal
var isRunning = true

while isRunning {
    guard let command = readLine() else {
        print("\nEntrada cerrada. Saliendo de la consola...")
        isRunning = false
        break
    }
    switch command { //
        // cada numero representa un comando,
        // por ejemplo 1 para agregar, 2 para listar, 3 para total y 4 para salir.
        // Esto haría que el código sea más fácil de leer y mantener.

        case "1": //agregar 
            //agregar una funcion para no hardcodear los numeros de las categorias,
            //  sino que se pueda agregar nuevas categorias sin tener que modificar el codigo.
            print("Ingrese la categoría del gasto (1: Comida, 2: Transporte, 3: Ocio, 4: Otros):\n") 
        
            var hasValidCategory: Categoria? = nil
            var hasValidAmount: Double? = nil
            var hasValidDescription: String? = nil

            while hasValidCategory == nil {
                guard let categoriaInput = readLine() else {
                    isRunning = false
                    break
                }

                //print("DEBUG: categoriaInput: \(categoriaInput)")
                
                //print("Ingrese el monto del gasto:")
                if let numero = Int(categoriaInput), let categoria = Categoria(rawValue: numero) {
                    hasValidCategory = categoria
                } else {
                    print("\(ANSIColor.red.rawValue)\n NO ES CATEGORIA VALIDA PA VOLVE A INTENTAR ❌ .\n\(ANSIColor.reset.rawValue)")
                    print("\(ANSIColor.red.rawValue)LAS CATEGORIAS VAN DE 1 A 4 .\n\(ANSIColor.reset.rawValue)")

                }
            }

            while hasValidAmount == nil {
                print("Ingrese el monto del gasto:")
                guard let montoInput = readLine() else {
                    isRunning = false
                    break
                }

                if let monto = Double(montoInput), monto >= 0 {
                    hasValidAmount = monto
                } else {
                    print ("\(ANSIColor.red.rawValue)NO ES MONTO VALIDO PA VOLVE A INTENTAR ❌ .\n\(ANSIColor.reset.rawValue)")
                    print("\(ANSIColor.red.rawValue)EL MONTO DEBE SER UN NUMERO POSITIVO .\n\(ANSIColor.reset.rawValue)")
                }
            }
            
            while hasValidDescription == nil {
                print("Ingrese una descripción del gasto (opcional):\n")
                print("Si no desea agregar una descripción, simplemente presione espacio y enter.\n")
                guard let descripcionInput = readLine() else {
                    isRunning = false
                    break
                }
                hasValidDescription = descripcionInput.isEmpty ? nil : descripcionInput
            }

            if let categoria = hasValidCategory, let monto = hasValidAmount, let descripcion = hasValidDescription {
                let nuevoGasto = Gasto(categoria: categoria, monto: monto, descripcion: descripcion)
                gastos.append(nuevoGasto)
                print("\(ANSIColor.green.rawValue)Gasto agregado exitosamente ✅ .\n\(ANSIColor.reset.rawValue)")
                print(Mensaje.menu.rawValue)

            }
        case "2": //listar
            print("")
            print("Listado de gastos:")
            print("")
            listarComando()
            print("")
            print(Mensaje.menu.rawValue)

        case "3": //total
            print("")

            print("Calculando el total de gastos...")
            print("")
            print("\(totalComando())")
            print("")
            print(Mensaje.menu.rawValue)

//MARK: - filtrar
        case "4": 
        var areFiltering = true
        while areFiltering {
            // tomar la entrada del usuario para filtrar por categoria, monto maximo o descripcion
            print("\(Mensaje.filtrar.rawValue)\n")
            
            guard let filtroInput = readLine() else {
                areFiltering = false
                isRunning = false
                break
            }

            switch filtroInput {

                    case "1": // filtrar por categoria
                        print("Ingrese la categoría por la que desea filtrar (1: Comida, 2: Transporte, 3: Ocio, 4: Otros):")

                        let inputCategoria = readLine() ?? ""
                        if let numero = Int(inputCategoria), let categoria = Categoria(rawValue: numero) {
                            let gastosFiltrados = gastos.filter { $0.categoria == categoria }
                            if gastosFiltrados.isEmpty {
                                print("\nNo hay gastos registrados en la categoría \(categoria).")
                            } else {
                                print("\nGastos en la categoría \(categoria):")
                                for gasto in gastosFiltrados {
                                    print("- Monto: \(gasto.monto), Descripción: \(gasto.descripcion ?? "Sin descripción")")
                                }
                                print("\nTotal de gastos en la categoría \(categoria): \(gastosFiltrados.reduce(0) { $0 + $1.monto })")
                            }
                        } else {
                            print("\nCategoría inválida. Por favor, intente nuevamente.")
                        }


                    case "2": // filtrar por monto maximo
                        if let maxGasto = gastos.max(by: { $0.monto < $1.monto}) {
                        print("\nEl gasto máximo es de \(maxGasto.monto) en la categoría \(maxGasto.categoria) con descripción: \(maxGasto.descripcion ?? "Sin descripción").")
                        } else {
                                print("\nNo hay gastos registrados.")
                                }

                    case "3": // filtrar por descripcion
                        print("\nIngrese la descripción por la que desea filtrar:")
                        let inputDescripcion = readLine() ?? ""
                        if !inputDescripcion.isEmpty {
                            let gastosFiltrados = gastos.filter { $0.descripcion?.lowercased().contains(inputDescripcion.lowercased()) ?? false }
                            if gastosFiltrados.isEmpty {
                                print("\nNo hay gastos registrados con la descripción que contiene '\(inputDescripcion)'.")
                            } else {
                                print("\nGastos con la descripción que contiene '\(inputDescripcion)':")
                                for gasto in gastosFiltrados {
                                    print("- Monto: \(gasto.monto), Categoría: \(gasto.categoria), Descripción: \(gasto.descripcion ?? "Sin descripción")")
                                }
                                print("\nTotal de gastos con la descripción que contiene '\(inputDescripcion)': \(gastosFiltrados.reduce(0) { $0 + $1.monto })")
                            }
                        } else {
                            print("\nDescripción vacía. Por favor, intente nuevamente.")
                        }

                    case "4": // total por categoria
                        print("\nTotal por categoría:")
                        for categoria in Categoria.allCases {
                            let totalCategoria = gastos
                                .filter { $0.categoria == categoria }
                                .reduce(0) { $0 + $1.monto }
                            print("- \(categoria): \(totalCategoria)")
                        }
                        print("\n\(totalComando())")

                    case "5": // volver al menu principal
                        areFiltering = false
                        print(Mensaje.menu.rawValue)

                    default:
                        print(Mensaje.unknown.rawValue)
            }
        }
//MARK: - editar
        case "5": 
            listarComando()
            print(Mensaje.editarGasto.rawValue)

            let inputNumeroGasto = readLine() ?? ""
            guard let numeroGasto = Int(inputNumeroGasto), numeroGasto >= 1, numeroGasto <= gastos.count else {
                print("\(ANSIColor.red.rawValue)\nNúmero de gasto inválido. Por favor, intente nuevamente.\n\(ANSIColor.reset.rawValue)")
                print(Mensaje.menu.rawValue)
                break
            }

            let gastoSeleccionado = gastos[numeroGasto - 1].id
            print(" DEBUG: Gasto seleccionado:\(gastos[numeroGasto - 1])\n")

            if let index = gastos.firstIndex(where: { $0.id == gastoSeleccionado }) {
               var editandoGasto = true
                while editandoGasto {
                                    print(Mensaje.editarOpciones.rawValue)
                                    guard let opcion = readLine() else {
                                        editandoGasto = false
                                        isRunning = false
                                        break
                                    }

                switch opcion {
                    case "1": //editar monto
                        print("Ingrese el nuevo monto:")
                        if let nuevoMontoInput = Double(readLine() ?? ""), nuevoMontoInput >= 0 {
                            gastos[index].monto = nuevoMontoInput
                            print("\(ANSIColor.green.rawValue)Monto actualizado exitosamente ✅ .\n\(ANSIColor.reset.rawValue)")
                            editandoGasto = false
                        } else {
                            print("\(ANSIColor.red.rawValue)Monto inválido. Por favor, intente nuevamente.\n\(ANSIColor.reset.rawValue)")
                        }
                    case "2": //editar categoria
                        print("Ingrese la nueva categoría (1: Comida, 2: Transporte, 3: Ocio, 4: Otros):")
                        if let nuevaCategoriaInput = Int(readLine() ?? ""), let nuevaCategoria = Categoria(rawValue: nuevaCategoriaInput) {
                            gastos[index].categoria = nuevaCategoria
                            print("\(ANSIColor.green.rawValue)Categoría actualizada exitosamente ✅ .\n\(ANSIColor.reset.rawValue)")
                            editandoGasto = false
                        } else {
                            print("\(ANSIColor.red.rawValue)Categoría inválida. Por favor, intente nuevamente.\n\(ANSIColor.reset.rawValue)")
                        }
                    case "3": //editar descripcion
                        print("Ingrese la nueva descripción (deje en blanco para eliminar):")
                        let nuevaDescripcionInput = readLine() ?? ""
                        gastos[index].descripcion = nuevaDescripcionInput.isEmpty ? nil : nuevaDescripcionInput
                        print("\(ANSIColor.green.rawValue)Descripción actualizada exitosamente ✅ .\n\(ANSIColor.reset.rawValue)")
                        editandoGasto = false

                    case "4": //volver al menu principal/ cancelar edición
                        editandoGasto = false
                    default:
                        print(Mensaje.unknown.rawValue)
                }
                }
                print(Mensaje.menu.rawValue)
            }

        case "6": //salir
            print("Saliendo de la consola...")
            isRunning = false
        case "":
            print(Mensaje.unknown.rawValue)
        default:
            print(Mensaje.unknown.rawValue)
    }
}