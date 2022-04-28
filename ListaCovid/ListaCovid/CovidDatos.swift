
import Foundation

struct CovidDatos: Decodable {
    let country: String?
    let active: Double?
    let countryInfo: CountryInfo?
    let cases: Double?
    let todayCases: Double?
    let deaths: Double?
    let recovered: Double?
    let todayRecovered: Double?
    let critical: Double?
}

struct CountryInfo: Decodable {
    let flag: String?
}
