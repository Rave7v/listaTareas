
import UIKit
import CoreData

class NuevaTareaViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var textoTarea: UITextField!
    @IBOutlet weak var fechaTareaPicker: UIDatePicker!
    
    @IBOutlet weak var imagen: UIImageView!
    //conexion a la bd o contexto
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //agregar imagen
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        imagen.addGestureRecognizer(gestureRecognizer)
        imagen.isUserInteractionEnabled = true
        
        //ya estaban estos
        textoTarea.delegate = self
        textoTarea.becomeFirstResponder()
    }
    
    @objc func clickImage(gesture: UITapGestureRecognizer){
        //crear view controller temporal
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func GuardarTareBtn(_ sender: Any) {
        //validar
        if let tituloTarea = textoTarea.text, !tituloTarea.isEmpty{
            let fechaTarea = fechaTareaPicker.date
            
            //crear un nuevo obj
            let nuevoElemento = Tarea(context: self.contexto)
            nuevoElemento.titulo = tituloTarea
            nuevoElemento.fecha = fechaTarea
            nuevoElemento.imagen = imagen.image?.pngData()
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
extension NuevaTareaViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagenSeleccionada = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imagen.image = imagenSeleccionada
            
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
