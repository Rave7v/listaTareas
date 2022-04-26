
import Foundation
struct ClimaModelo {
    let condicionID : Int
    let nombreCiudad: String
    let temperatura: Double
    let humedad : Double
    let descripcion : String
    
    //propiedad computada
    var temperaturaString: String {
        return String(format: "%.1f", temperatura)
    }
    
    var nombreCondicion: String{
        switch condicionID{
        case 200...232:
            //llovia con truenos
            return "cloud.bolt"
        case 300...321:
            //llovizna
            return "cloud.rain"
        case 500...531:
            //lluvia mamlona
            return "cloud.rain.fill"
        case 600...622:
            //nevando
            return "snow"
        case 700...781:
            //la neta no se
            return "sun.dust"
        case 800:
            //soleado
            return "sun.min"
        case 800...804:
            //nublado
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
    var imagenes: String{
        switch condicionID{
        case 200...232:
            //llovia con truenos
            return "tormenta"
        case 300...321:
            //llovizna
            return "lluvioso"
        case 500...531:
            //lluvia mamlona
            return "lluvioso"
        case 600...622:
            //nevando
            return "nevado"
        case 700...781:
            //la neta no se
            return "dust"
        case 800:
            //soleado
            return "soleado"
        case 800...804:
            //nublado
            return "Nublado"
        default:
            return "soleado"
        }
    }
}
