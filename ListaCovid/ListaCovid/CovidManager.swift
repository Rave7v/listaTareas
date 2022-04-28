import Foundation

protocol covidManagerDelegado {
    func actualizar(paises: [CovidDatos])
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
                    if let listaPaises = self.parsearJSON(datosCovid: datosSeguros){
                        //no me importa si hay delgado o quien sea
                        delegado?.actualizar(paises: listaPaises)
                    }
                }
            }
            tarea.resume()
        }
    }
    func parsearJSON(datosCovid: Data)->[CovidDatos]?{
        let decodificador = JSONDecoder()
        
        do{
            let datosDecodificados: [CovidDatos] = try
                decodificador.decode([CovidDatos].self, from: datosCovid)
            
            //array de paises de tipo covid datos
            let paises: [CovidDatos] = datosDecodificados
            return paises
        }catch{
            print("Error al decodificar: \(error.localizedDescription)")
            return nil
        }
    }
}
