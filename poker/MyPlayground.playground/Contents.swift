import UIKit

//funcion simple
func saludar(){
    print("Hola a todos")
}

func elevarCuadrado(numero: Int){
    //var cuadrado = numero * numero
    print(numero * numero)
}

//funcion con valor de retorno
func retornarEdad(edad: Int)-> Int{
    return edad + 10
}

var edadcalculada = retornarEdad(edad: 10)
print(edadcalculada)
///saludar
elevarCuadrado(numero: 10)
