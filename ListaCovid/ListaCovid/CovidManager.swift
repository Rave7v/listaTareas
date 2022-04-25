import Foundation

protocol covidManagerDelegado {
    func actualizar()
}

struct CovidManager {
    var delegado: covidManagerDelegado?
    
    func buscarEstadisticas() {
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries/"
        if let url = URL(string: urlString){
            let sesion = URLSession(configuration: .default)
            let tarea = sesion.dataTask(with: url){datos, respuesta,error in
                if error != nil{
                    print("Error al buscar datos: \(error?.localizedDescription)")
                }
                //si no hubo error
                if let datosSeguros = datos{
                    print(datosSeguros)
                    
                }
            }
            tarea.resume()
        }
    }
}
