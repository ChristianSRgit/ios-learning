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


while let linea = readLine(){

let input = linea.split(separator: " ")

switch input[0] {

case "agregar":

print("Ingrese la categoría del gasto (Comida, Transporte, Ocio, Otros):")
   // resultado = agregarComando(input)

case "listar":

print("Listado de gastos:")
  print("\(listarComando())")

case "total":

    print("Calculando el total de gastos...")
    print("\(totalComando())")

case "salir":

    print("Saliendo de la consola...")
    break

default:

    print("Comando desconocido")
}

}
