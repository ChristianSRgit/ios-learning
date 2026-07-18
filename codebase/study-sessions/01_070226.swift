```
import UIKit

var greeting = "Hello, playground"

let httpError = (404, "Página no encontrada")
//print(httpError.0) // Imprime 404
//print(httpError.1) // Imprime Página no encontrada


struct Error {
    var code: Int
    var msg: String

    init(codiguito: Int, mensajito: String) {
        self.code = codiguito
        self.msg = mensajito
    }
}

class ErrorTwo {
    var code: Int
    var msg: String

    init(codiguito: Int, mensajito: String) {
        self.code = codiguito
        self.msg = mensajito
    }

}

//let errorTwo = Error(code: 404, msg: "Página no encontrada")
let errorTwo = Error(codiguito: 404, mensajito: "Página no encontrada Estructura")
let errorTwoClass = ErrorTwo(codiguito: 404, mensajito: "Página no encontrada Clase")

//print(errorTwo.msg + " 1")
//print(errorTwoClass.msg + " 2")

var canBeHandled: Error = errorTwo
canBeHandled.msg = "Error modificado estructura"

var canBeHandledByClass: ErrorTwo = errorTwoClass
canBeHandledByClass.msg = "Error modificado clase"

//print(errorTwo.msg + " 3")
//print(errorTwoClass.msg + " 4")

let errorThree: Error

//errorThree = .init(code: 200, msg: "Exitoso")
//print(errorTwo.code)
//print(errorTwo.msg)


let dictionary: [String : Any] = [
    "id": 1,
    "description": "Error de prueba",
]

//print(dictionary["id"])

//if true == true ? "si es true" : "no es true"

var result: String? = nil

let sum: Float = 1+1
//result = String(sum)
//print(result)
//
//if let unwrappedResult = result {
//    print(unwrappedResult)
//} else {
//    print("result is nil")
//}


// 1 Build a CLI tip calculator
// 2 Implement a linked list using structs/classes
// 3 Write a protocol-based shape area calculator

// 1-

class Comida {
//    let percentage: Float //  = 10
//    var amount: Float // = 50000
    var hadDessert: Bool = false
    var amountOfDesserts: Int = 0

//    init(percentage: Float, of amount: Float) {
//        self.percentage = percentage
//        self.amount = amount
//    }

    func calculatePropi(amount: Float, percentage: Float) -> Float {
        return amount * percentage / 100
    }

//    func addDessert(amount: Float = 0) {
//        self.amount += amount
//        hadDessert = true
//        amountOfDesserts += 1
//    }
//
//    func calculatePropi() -> Float {
//        return amount * percentage / 100
//    }

//    print(percentage)
}

//let comida = Comida(percentage: 10, amount: 50000)
let comida = Comida()

let propi = comida.calculatePropi(amount: 50000, percentage: 10)
print("Tu propina es de: $\(propi)")

for _ in 1..<100 {

}

protocol Alimento {
    var valNutricional: String { get }
    var macros: String { get }

    func dameLosPrecio() -> Float
}

// PLATO.SWIFT

struct Plato: Alimento {
    var valNutricional: String {
        return "Valor nutricional del plato"
    }

    var macros: String {
        return "Macros"
    }

    fileprivate var precio: Float = 100

    func dameLosPrecio() -> Float {
        return precio
    }
}

// MARK: - Alimento

extension Plato: Alimento {
    func damePrecioSindicato() -> Float {
        return precio * 1.50
    }
}
```
