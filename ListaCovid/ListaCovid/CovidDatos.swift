
import Foundation

struct CovidDatos: Decodable {
    let country: String?
    let active: Double?
    let countInfo: CountryInfo?
}

struct CountryInfo:Decodable {
    let flag: String?
}
