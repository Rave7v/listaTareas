
import UIKit

class ViewController: UIViewController {
    var porcentaje:Float = 0.1
    var cuenta:Double = 0.1
    var total:Float = 0.1
    var cuentaC:Float = 0.1
    var personal: Double = 0.1
    var personas: Double = 0.1
    @IBOutlet weak var totalTf: UITextField!
    @IBOutlet weak var personasTf: UITextField!
    @IBOutlet weak var porcentajeLbl: UILabel!
    @IBOutlet weak var porceltajeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        porcentajeLbl.text = "\(porceltajeSlider.value*100)%"
    }
    
    @IBAction func CalcularBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "enviar", sender: self)
    }
    
    @IBAction func desliza(_ sender: UISlider) {
        porcentajeLbl.text = "\(String(format:"%.2f",sender.value*100))%"
        porcentaje = sender.value
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let objDestino = segue.destination as! SegundaViewController
        if Double(totalTf.text ?? "0") != nil {
            self.cuenta = Double(totalTf.text ?? "0") ?? 0
        }
        else {
            cuenta = 0
        }
        if (Double(personasTf.text ?? "0") != nil){
            self.personas = Double(personasTf.text ?? "0") ?? 0
        }else{
            
        }
        total = Float((cuenta*Double(porcentaje))+cuenta)
        personal = Double(total)/personas
        objDestino.tot = Double(total)
        objDestino.per = personal
    }
}
