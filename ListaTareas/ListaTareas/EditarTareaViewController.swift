
import UIKit

class EditarTareaViewController: UIViewController {

    var recibirTarea: Tarea?
    @IBOutlet weak var tituloElemento: UITextField!
    @IBOutlet weak var fechaElemento: UIDatePicker!

    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloElemento.text = recibirTarea?.titulo ?? ""
        fechaElemento.date = recibirTarea?.fecha ?? Date()
    }
    @IBAction func guardarBtn(_ sender: UIButton) {
        recibirTarea?.titulo = tituloElemento.text ?? ""
        recibirTarea?.fecha = fechaElemento.date
        
        do {
            try contexto.save()
        } catch{
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
