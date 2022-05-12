
import UIKit
import CoreData

class NuevaTareaViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var textoTarea: UITextField!
    @IBOutlet weak var fechaTareaPicker: UIDatePicker!
    
    //conexion a la bd o contexto
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textoTarea.delegate = self
        textoTarea.becomeFirstResponder()
    }
    
    @IBAction func GuardarTareBtn(_ sender: Any) {
        //validar
        if let tituloTarea = textoTarea.text, !tituloTarea.isEmpty{
            let fechaTarea = fechaTareaPicker.date
            
            //crear un nuevo obj
            let nuevoElemento = Tarea(context: self.contexto)
            nuevoElemento.titulo = tituloTarea
            nuevoElemento.fecha = fechaTarea
            //
            
            
            do{
                try contexto.save()
                print("Se guardo correctamente")
            }catch{
                print(error.localizedDescription)
            }
            //regresar
            navigationController?.popToRootViewController(animated: true)
            
        }else{
            print("Escribir algo")
            textoTarea.placeholder = "Necesita escribir una tarea para guardarla"
        }
    }//func guardar
}
