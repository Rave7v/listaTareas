
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var preguntaLbl: UILabel!
    @IBOutlet weak var verdaderoBoton: UIButton!
    @IBOutlet weak var falsoBoton: UIButton!
    @IBOutlet weak var barraProgreso: UIProgressView!
    @IBOutlet weak var Puntos: UILabel!
    
    var numPregunta: Float = 0;
    var correctas = 0;
    let preguntas = [
        Pregunta(texto: "Diez mas diez es 20", respuesta: "VERDADERO"),
        Pregunta(texto: "El ITM es la mejor escuela", respuesta: "VERDADERO"),
        Pregunta(texto: "el america es el mejor equipo de mexico", respuesta: "FALSO"),
        Pregunta(texto: "Wikipedia es una pagina confiable?", respuesta: "FALSO"),
        Pregunta(texto: "Se puede nadar en los mares bolivianos?", respuesta: "FALSO"),
        Pregunta(texto: "La luz es lo mas rapido existente", respuesta: "VERDADERO"),
        Pregunta(texto: "El cielo es azul", respuesta: "VERDADERO")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cambiarPregunta()
    }
    
    @IBAction func respuestaBtn(_ sender: UIButton) {
        let respuestaUsuario = sender.currentTitle//boton presionado
        let respuestaCorrecta = preguntas[Int(numPregunta)].respuesta
        let alerta = UIAlertController(title: "Felicidades", message: "Tu puntuaje es de: \(correctas)", preferredStyle: .alert)
        if respuestaUsuario == respuestaCorrecta{
            print("respuesta correcta")
            sender.backgroundColor = UIColor.green
            correctas += 1
        }else{
            print("respuesta incorrecta")
            sender.backgroundColor = UIColor.red
        }
            //cambiar de pregunta
        if Int(numPregunta) + 1 < preguntas.count{
            numPregunta += 1
        }else if Int(numPregunta) <  preguntas.count{
            //se terminaron las preguntas
            //aqui debemos llamar la alerta
            self.cambiarPregunta()
            self.barraProgreso.progress = 0
            self.numPregunta=0
            self.correctas=0
            present(alerta, animated: true, completion: nil)
        }
        ///añadir otro if pa alerta
        
        ///alertas
        let accionOK = UIAlertAction(title: "Volver a jugar", style: .default){ _ in
            
        }
        let accionJugarNvo = UIAlertAction(title: "salir", style: .cancel){ _ in
            print("salir del juego")
            exit(0)
        }
        alerta.addAction(accionJugarNvo)
        alerta.addAction(accionOK)
        
        //timer que se ejecuta si o si
        Timer.scheduledTimer(timeInterval: 0.8, target: self,selector: #selector(cambiarPregunta), userInfo: nil, repeats: false)
    }
    
    @objc func cambiarPregunta() {
        preguntaLbl.text = preguntas[Int(numPregunta)].texto
        Puntos.text = "Puntuaje: \(correctas)"
        verdaderoBoton.backgroundColor = UIColor.gray
        falsoBoton.backgroundColor = UIColor.gray
        barraProgreso.progress = (numPregunta + 1) / Float(preguntas.count);
    }
}
