
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegado {
    
    func actualizarClima(objClima: ClimaModelo) {
        DispatchQueue.main.async {
            self.temperaturaLabel.text = "\(objClima.temperaturaString)"
            self.mensajeClima.text = "En \(objClima.nombreCiudad) esta \(objClima.descripcion) y con una humedad de \(objClima.humedad)"
            self.imagenClima.image = UIImage(systemName: objClima.nombreCondicion)
            self.fondoClima.image = UIImage(named: objClima.imagenes)
        }
    }
    
    func huboError(error Cualerror: Error) {
        DispatchQueue.main.async {
            self.mensajeClima.text = "\(Cualerror.localizedDescription)"
        }
    }

    @IBOutlet weak var nombreUbicacion: UITextField!
    @IBOutlet weak var mensajeClima: UILabel!
    @IBOutlet weak var fondoClima: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var imagenClima: UIImageView!
    var climaManager = ClimaManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        climaManager.delegado = self
        nombreUbicacion.delegate = self
    }
    @IBAction func ubicacionButton(_ sender: UIButton) {
        
    }
    
    @IBAction func buscarButton(_ sender: UIButton) {
        print(nombreUbicacion.text ?? "No se han detectado busquedas")
    }
    
    //MARK: metodos de ui text field
    
    // Identificar el boton del teclado virtual
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Ciudad a buscar")
        //ocultar teclado
        textField.endEditing(true)
        print(nombreUbicacion.text ?? "")
        return true
    }
    
    // Identifica cuando el usuario termina de editar
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.endEditing(true)
        print("Edicion terminada")
        //Llamada a la api
        climaManager.obtenerClima(nombreCiudad:nombreUbicacion.text ?? "morelia")
    }
    
    // Evitar busqueda vacia
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        if nombreUbicacion.text != ""{
            return true
        } else {
            print("Debes ingresar una busqueda")
            mensajeClima.text = "Debes ingresar una busqueda"
            return false
        }
    }
}
