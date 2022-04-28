
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
        activos.text = "Casos activos: \(recibirObjPais?.active)"
        casos.text = "Casos Totales: \(recibirObjPais?.cases)"
        Trecuperados.text = "Total de recuperados: \(recibirObjPais?.recovered)"
        muertos.text = "Muertos: \(recibirObjPais?.deaths)"
        criticos.text = "Criticos: \(recibirObjPais?.critical)"
        recuperados.text = "Recuperados hoy: \(recibirObjPais?.todayRecovered)"
        casosHoy.text = "Casos hoy: \(recibirObjPais?.todayCases)"
    }
}
