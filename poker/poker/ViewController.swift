
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    var Aleat  = Int.random(in: 0...3)
    var Aleat2 = Int.random(in: 0...9)
    var baraja = [#imageLiteral(resourceName: "1.png"),#imageLiteral(resourceName: "2.png"),#imageLiteral(resourceName: "3.png"),#imageLiteral(resourceName: "4.png"),#imageLiteral(resourceName: "6.png"),#imageLiteral(resourceName: "7.png"),#imageLiteral(resourceName: "8.png"),#imageLiteral(resourceName: "9.jpeg"),#imageLiteral(resourceName: "10.png"),#imageLiteral(resourceName: "11.png")]
    override func viewDidLoad() {
        super.viewDidLoad()
        img1.image = baraja[Aleat]
    }

    @IBAction func jugar(_ sender: UIButton) {
        Aleat2 = Int.random(in: 1...9)
        img2.image = baraja[Aleat2]
        
        if (Aleat==0 && (Aleat2 == 1 || Aleat2 == 2 || Aleat2 == 3 || Aleat2 == 4 || Aleat2 == 5 || Aleat2 == 6) ){
            //validar juego ganador
            let alerta = UIAlertController(title: "Felicidades", message: "Ganaste", preferredStyle: .alert)
            
            let accionOK = UIAlertAction(title: "Volver a jugar", style: .default){ _ in
                self.Aleat  = Int.random(in: 0...3)
                self.img1.image = self.baraja[self.Aleat]
                self.img2.image = UIImage(named: "reverso")
            }
            
            let accionApostar = UIAlertAction(title: "Apostar", style: .default) { _ in
                print("apostando")
            }
            
            let accionJugarNvo = UIAlertAction(title: "salir", style: .cancel){ _ in
                print("salir del juego")
                exit(0)
            }
            alerta.addAction(accionOK)
            alerta.addAction(accionJugarNvo)
            alerta.addAction(accionApostar)
            present(alerta, animated: true, completion: nil)
        }else{
            let alerta = UIAlertController(title: "chale", message: "intentalo de  nuevo", preferredStyle: .alert)
            let accionOK = UIAlertAction(title: "Volver a jugar", style: .default){ _ in
                self.Aleat  = Int.random(in: 0...3)
                self.img1.image = self.baraja[self.Aleat]
                self.img2.image = UIImage(named: "reverso")
            }
            alerta.addAction(accionOK)
            present(alerta, animated: true, completion: nil)
        }
    }
}

