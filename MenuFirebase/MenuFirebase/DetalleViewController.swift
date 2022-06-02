import UIKit
import CoreData
import FirebaseAuth

class DetalleViewController: UIViewController {
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var recibirObj: CriptoDatos?
    @IBOutlet weak var cripCurrency: UILabel!
    @IBOutlet weak var imagenBit: UIImageView!
    @IBOutlet weak var cripName: UILabel!
    @IBOutlet weak var cripPrice: UILabel!
    @IBOutlet weak var cripStatus: UILabel!
    @IBOutlet weak var cripRank: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cripCurrency.text = recibirObj?.currency
        cripName.text = recibirObj?.name
        
        cripPrice.text = String(format: "$ %.2f",Float( (recibirObj?.price)!) ?? 0.0)
        cripStatus.text = "Estado: \(recibirObj?.status ?? "Coahuila")"
        cripRank.text = "#\(recibirObj?.rank ?? "0")"
        //obtener la imagen
        if let urlString = recibirObj?.logo_url{
            if let imagenURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL)else{ return }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        self.imagenBit.image = image
                    }
                }
            }
        }
    }
    
    func guardar(){
        do{
            try contexto.save()
            print("guardado con exito")
        }catch{
            print("error al guardar: \(error.localizedDescription)")
        }
    }
     
    @IBAction func AgregarBtn(_ sender: UIButton) {
        let nuevoBit = Bits(context: self.contexto)
        nuevoBit.nameBit = recibirObj?.name
        nuevoBit.valueBit = String(format: "$ %.2f",Float( (recibirObj?.price)!) ?? 0.0)
        nuevoBit.user = Auth.auth().currentUser?.email
        //agregar nuevo bit
        self.guardar()
    }
}
