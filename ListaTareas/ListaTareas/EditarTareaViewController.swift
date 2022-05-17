
import UIKit

class EditarTareaViewController: UIViewController {

    var recibirTarea: Tarea?
    @IBOutlet weak var tituloElemento: UITextField!
    @IBOutlet weak var fechaElemento: UIDatePicker!
    @IBOutlet weak var imagen: UIImageView!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pa la imagen
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        imagen.addGestureRecognizer(gestureRecognizer)
        imagen.isUserInteractionEnabled = true
        
        tituloElemento.text = recibirTarea?.titulo ?? ""
        fechaElemento.date = recibirTarea?.fecha ?? Date()
    }
    
    
    
    //////////falta guardar y falta mostrar
    
    
    
    
    
    @objc func clickImage(gesture: UITapGestureRecognizer){
        //crear view controller temporal
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
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

extension EditarTareaViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

