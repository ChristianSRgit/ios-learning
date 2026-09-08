print("Bienvenido a Gastos Consola")
print("Ctrl+D sale de la consola")

enum Categoria {
    case Comida
    case Transporte
    case Ocio
    case Otros
}

struct Gasto {
    var categoria: Categoria
    var monto: Double
}

var gastos: [Gasto] = [
    Gasto(categoria: .Comida, monto:10000),
    Gasto(categoria: .Transporte, monto:5000),
    Gasto(categoria: .Ocio, monto:1000)
]


func listarComando(){
    for gasto in gastos{
    print("Gastaste en \(gasto.categoria) un monto de \(gasto.monto)")
    }
}

func totalComando()-> String {
    var total: Double = 0
    for gasto in gastos {
        total += gasto.monto
    }
    return "El total de gastos es \(total)"
}

func agregarComando(gasto:Gasto){

    gastos.append(gasto)
    gastos.contains(where: { item in item.categoria == gasto.categoria && item.monto == gasto.monto })


    print("Gasto agregado exitosamente")
}



while let linea = readLine(){

 print("Ingrese un comando (1: Agregar, 2: Listar, 3: Total, 4: Salir):")

let input = linea.split(separator: " ")

guard let comando = input.first else {
    print("Comando desconocido")
    continue
}

switch comando {
// podedmos cambiar directamente por casos numericos en los cuales cada numero representa un comando, por ejemplo 1 para agregar, 2 para listar, 3 para total y 4 para salir. Esto haría que el código sea más fácil de leer y mantener.
case "1": //agregar
    print("Ingrese la categoría del gasto (1: Comida, 2: Transporte, 3: Ocio, 4: Otros):")

   // resultado = agregarComando(input)
    /* switch readLine() { */

case "2": //listar

print("Listado de gastos:")
print("\(listarComando())")

case "3": //total

    print("Calculando el total de gastos...")
    print("\(totalComando())")

case "4": //salir

    print("Saliendo de la consola...")
    
case "":

    print("Comando desconocido")

default:

    print("Comando desconocido")
}

}
