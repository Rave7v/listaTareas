
import UIKit

class EditarContactoViewController: UIViewController {
    var nombre:String?
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var Nombre: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var direccion: UITextField!
    @IBOutlet weak var correo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        imagen.addGestureRecognizer(gestureRecognizer)
        imagen.isUserInteractionEnabled = true
        //nombrelbl.text = nombre
    }//
    
    @objc func clickImage(gesture: UITapGestureRecognizer){
        //print("cambiar imagen")
        //crear view controller temporal
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    @IBAction func guardarBtn(_ sender: UIButton) {
        print("guardo")
    }
    
    @IBAction func cancelarBtn(_ sender: UIButton) {
        print("cancelo")
    }
}
extension EditarContactoViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
