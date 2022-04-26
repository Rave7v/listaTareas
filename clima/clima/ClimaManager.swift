import Foundation

protocol ClimaManagerDelegado {
    
    func actualizarClima(objClima: ClimaModelo)
    
    func huboError(error: Error)
}

struct ClimaManager {
    let climaUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=fb540c21323ed122505ce242df21b704&units=metric&lang=es"
    var delegado: ClimaManagerDelegado?
    func obtenerClima(nombreCiudad: String) {
        let urlString = "\(climaUrl)&q=\(nombreCiudad)"
        realizarSolicitud(urlString: urlString)
    }
    
    func  realizarSolicitud(urlString: String) {
        //crear url
        if let url = URL(string: urlString){
        //crear url sesion
        let sesion = URLSession(configuration: .default)
        //asignar una tarea
        let tarea = sesion.dataTask(with: url) { (datos, respuesta, error) in
            if error != nil {
                print("error al consumir la appi")
                return
            }
            //si no hubo errores
            if let datosSeguros = datos {
                if let objClima = analizarJSON(datosClima: datosSeguros){
                    delegado?.actualizarClima(objClima: objClima)
                }
            }
        }
        //comenzar tarea
        tarea.resume()
        }//fin if let
    }//fin realizar soli
    
    func analizarJSON(datosClima: Data) -> ClimaModelo? {
        let decodificador = JSONDecoder()
        do{
            let datosDecodificados = try decodificador.decode(DatosClima.self, from: datosClima)
            print(datosDecodificados.name)
            print(datosDecodificados.main.temp)
            print(datosDecodificados.weather[0].id)
            
            let condicionId = datosDecodificados.weather[0].id
            let nombreCiudad = datosDecodificados.name
            let temperatura = datosDecodificados.main.temp
            let humedad = datosDecodificados.main.humidity ?? 20
            let descripcion = datosDecodificados.weather[0].description
            
            let objClima = ClimaModelo(condicionID: condicionId, nombreCiudad: nombreCiudad, temperatura: temperatura, humedad: Double(humedad),descripcion: descripcion)
            
            return objClima
            
        }catch{
            delegado?.huboError(error: error)
            print("error")
            return nil
        }
    }
}
