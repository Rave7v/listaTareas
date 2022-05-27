
import UIKit
import CLTypingLabel
import FirebaseAuth
class ViewController: UIViewController {

    @IBOutlet weak var mensajeBienvenida: CLTypingLabel!
    @IBOutlet weak var correUsuario: UITextField!
    @IBOutlet weak var contraseñaUsuario: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //velocidad
        mensajeBienvenida.charInterval = 0.09
        //mensaje
        mensajeBienvenida.text = "Bienvenidos al Criptomundo "
        //color al finalizar
        mensajeBienvenida.onTypingAnimationFinished = {
        self.mensajeBienvenida.textColor = .black
            
        //guardar sesion
        let defaults = UserDefaults.standard
        
        if let email = defaults.value(forKey: "email") as? String{
                //utilizar segue para ir al HOME VC
                print(email)
                print("Se encontro la sesion guardada y se navega a HOME VC")
                self.performSegue(withIdentifier: "loginMenu", sender: self)
            }
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        if let email = correUsuario.text, let password = contraseñaUsuario.text{
            Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
                if let e = error{
                    print("Error al iniciar sesion \(e.localizedDescription)")
                }else{
                    print("Inicio exitoso")
                    self!.performSegue(withIdentifier: "loginMenu", sender: self)
                }
            }
        }
    }
}
