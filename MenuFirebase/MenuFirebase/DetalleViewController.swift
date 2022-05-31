
import UIKit

class DetalleViewController: UIViewController {
    
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
        cripPrice.text = "$\(recibirObj?.price! ?? "$0.0")"
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
}
