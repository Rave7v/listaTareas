
import UIKit

class ViewController: UIViewController {

    var cerebroCalculadora = CerebroCalculadora()
    
    var altura:Float = 1.6
    var peso:Float = 75
    var imc:Float = 0.0
    @IBOutlet weak var valorAltura: UILabel!
    @IBOutlet weak var valorPeso: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calcularBtn(_ sender: UIButton) {
        cerebroCalculadora.calcularIMC(peso: peso, altura: altura)
        
        performSegue(withIdentifier: "calcular", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let objDestino = segue.destination as! segundoViewController
        objDestino.valorImc = cerebroCalculadora.retornarValorIMC()
        objDestino.mensaje = cerebroCalculadora.darAviso()
        objDestino.color = cerebroCalculadora.retonarColor()
        objDestino.image = cerebroCalculadora.retornarImagen()
    }
    
    @IBAction func sliderAltura(_ sender: UISlider) {
        //print(sender.value)
        valorAltura.text = "\(String(format: "%.2f", sender.value)) m"
        altura = Float(sender.value)
    }
    
    @IBAction func sliderPeso(_ sender: UISlider) {
        valorPeso.text = "\(String(format: "%.1f", sender.value)) kg"
        peso = Float(sender.value)
    }
}

