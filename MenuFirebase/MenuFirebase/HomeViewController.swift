
import UIKit
import FirebaseAuth
import CoreData

class HomeViewController: UIViewController {
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bitasos = [Bits]()
    
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
    
    func leer() {
        let solicitud : NSFetchRequest<Bits> = Bits.fetchRequest()
        do{
            //tratar de asignar al arreglo lo que arroje la solicitud
            bitasos = try contexto.fetch(solicitud)
        }catch{
            print("Error al leer datos \(error.localizedDescription)")
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
