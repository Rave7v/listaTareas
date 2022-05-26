
import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var nomUsuario: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //ocultar boton de retroceder
        navigationItem.hidesBackButton = true
        
        //sesion
        if let email = Auth.auth().currentUser?.email {
            let defaults = UserDefaults.standard
            defaults.set(email, forKey: "email")
            title = email
            print("Se guardó la sesion")
            defaults.synchronize()
        }
    }
    
    @IBAction func cerrarSesionBtn(_ sender: UIButton) {
        
        //borar sesion
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        print("Se eliminó la sesion")
        defaults.synchronize()
        
        do{
            try Auth.auth().signOut()
            print("Se ha cerrado sesion")
            //navegar a la pantalla de inicio
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error al iniciar sesion\(error.localizedDescription)")
        }
    }
}
