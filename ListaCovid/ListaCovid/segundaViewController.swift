
import UIKit

class segundaViewController: UIViewController {
    
    var recibirObjPais: CovidDatos?

    @IBOutlet weak var lugar: UILabel!
    @IBOutlet weak var Bandera: UIImageView!
    @IBOutlet weak var activos: UILabel!
    @IBOutlet weak var casos: UILabel!
    @IBOutlet weak var Trecuperados: UILabel!
    @IBOutlet weak var muertos: UILabel!
    @IBOutlet weak var criticos: UILabel!
    @IBOutlet weak var recuperados: UILabel!
    @IBOutlet weak var casosHoy: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lugar.text = recibirObjPais?.country
        activos.text = "Casos activos: \(recibirObjPais?.active ?? 0)"
        casos.text = "Casos Totales: \(recibirObjPais?.cases ?? 0)"
        Trecuperados.text = "Total de recuperados: \(recibirObjPais?.recovered ?? 0)"
        muertos.text = "Muertos: \(recibirObjPais?.deaths ?? 0)"
        criticos.text = "Criticos: \(recibirObjPais?.critical ?? 0)"
        recuperados.text = "Recuperados hoy: \(recibirObjPais?.todayRecovered ?? 0)"
        casosHoy.text = "Casos hoy: \(recibirObjPais?.todayCases ?? 0)"
        
        if let urlString = recibirObjPais?.countryInfo?.flag{
            //print(urlString)
            if let imagenURL = URL(string: urlString){
                //print(imagenURL)
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL)else{ return }
                    //crear un obj tipo image
                    //print("imagen data: \(imagenData)")
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        self.Bandera.image = image
                    }
                }
            }
        }
    }
}
