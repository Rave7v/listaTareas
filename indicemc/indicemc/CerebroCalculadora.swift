
import Foundation
import UIKit
struct CerebroCalculadora {
    var IMC : imc?
    
    mutating func calcularIMC (peso: Float, altura: Float){
        let valorIMC = peso / (altura * altura)
        if valorIMC < 18.5{
            IMC = imc(valor:valorIMC, mensaje: "Falta comer!", color:#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),image: UIImage(named: "bajo de peso")!)
        }else if valorIMC < 24.9 {
            IMC = imc(valor:valorIMC, mensaje: "Tu peso es normal felicidades!", color:#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), image:UIImage(named: "normal")!)
        }else if valorIMC < 29.9{
            IMC = imc(valor: valorIMC, mensaje: "Tienes sobrepeso", color: UIColor.orange, image: UIImage(named: "sobre peso")!)
        }else{
            IMC = imc(valor: valorIMC, mensaje: "Tienes Obesidad", color: UIColor.red, image: UIImage(named: "obesidad")!)
        }
    }//calcular imc
    
    func retornarValorIMC() -> String{
        let imcCon2Decimales = String(format: "%.2f", IMC?.valor ?? 0.0)
        return imcCon2Decimales
    }
    
    func darAviso() -> String {
        return IMC?.mensaje ?? "No hay mensaje"
    }
    
    func retonarColor() -> UIColor {
        return IMC?.color ?? UIColor.cyan
    }
    
    func retornarImagen() -> UIImage {
        return IMC?.image ?? UIImage(named: "imc")!
    }
}
