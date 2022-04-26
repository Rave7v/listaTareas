
import Foundation

struct DatosClima: Decodable, Encodable {
    let name: String
    let main: Main
    let weather : [Weather]
    
}

struct Main: Decodable, Encodable {
    let temp : Double
    let humidity: Int?
    let feels_like: Double
}

struct Weather:Decodable, Encodable {
    let id: Int
    let description: String
}
