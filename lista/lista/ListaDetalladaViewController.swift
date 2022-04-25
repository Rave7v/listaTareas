
import UIKit

class ListaDetalladaViewController: UIViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombreAlumno: UILabel!
    var Recibirnombre: String?
    var recibirCalificacion: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreAlumno.text = "\(Recibirnombre ?? "") tu calificacion es de :\(recibirCalificacion ?? 0)"
        print(recibirCalificacion!)
        // Do any additional setup after loading the view.
        if recibirCalificacion! < 70{
            //cambiar imagen, mostrar calificacion y validar si es aprobatoria o reprobatoria
            
        }
    }
}
