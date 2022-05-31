
import Foundation

protocol CriptoManagerDelegado {
    func actualizar(criptos:[CriptoDatos])
}

struct CriptoManager {
    var delegado: CriptoManagerDelegado?
    
    func buscarEstadisticas() {
        let urlstring = "https://api.nomics.com/v1/currencies/ticker?key=ddd85c86d13ed6d32ee530ee4d3e33e96344b4dd&interval=,1d&convert=MNX&platform-currency=ETH&per-page=100&page=1"
        if let url = URL(string: urlstring){
            let sesion = URLSession(configuration: .default)
            let tarea = sesion.dataTask(with: url){datos, respuesta,error in
                if error != nil{
                    print("Error al buscar datos: \(error?.localizedDescription)")
                }
                //si no hubo error
                if let datosSeguros = datos{
                    print(datosSeguros)
                    if let listaCriptos = self.parsearJSON(datosCripto: datosSeguros){
                        //no me importa si hay delgado o quien sea
                        delegado?.actualizar(criptos: listaCriptos)
                    }
                }
            }
            tarea.resume()
        }
        
    }
    func parsearJSON(datosCripto: Data)->[CriptoDatos]?{
        let decodificador = JSONDecoder()
        
        do{
            let datosDecodificados: [CriptoDatos] = try
                decodificador.decode([CriptoDatos].self, from: datosCripto)
            
            //array de paises de tipo covid datos
            let paises: [CriptoDatos] = datosDecodificados
            return paises
        }catch{
            print("Error al decodificar: \(error.localizedDescription)")
            return nil
        }
    }
}
