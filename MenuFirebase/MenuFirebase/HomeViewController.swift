import UIKit
import FirebaseAuth
import CoreData

class HomeViewController: UIViewController{
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bitasos = [Bits]()
    
    @IBOutlet weak var bitso: UILabel!
    @IBOutlet weak var nomUsuario: UILabel!
    @IBOutlet weak var imagenPerfil: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //ocultar boton de retroceder
        navigationItem.hidesBackButton = true
        leer()
        let texto = bitasos.last
        bitso.text = "El usuario \(texto?.user ?? "Anon") agrego \(texto?.nameBit ?? "Bit") a sus favoritos con un valor de: \(texto?.valueBit ?? "0,0")"
        if let email = Auth.auth().currentUser?.email {
            let defaults = UserDefaults.standard
            defaults.set(email, forKey: "email")
            title = email
            print("Se guardó la sesion")
            defaults.synchronize()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        leer()
        //sesion
        let texto = bitasos.last
        bitso.text = "El usuario \(texto?.user ?? "Anon") agrego \(texto?.nameBit ?? "Bit") a sus favoritos con un valor de: \(texto?.valueBit ?? "0,0")"
        
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
