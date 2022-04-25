
import UIKit

class segundoViewController: UIViewController {
    var valorImc : String?
    var mensaje : String?
    var color: UIColor?
    var image: UIImage?

    @IBOutlet weak var valorIMCLbl: UILabel!
    @IBOutlet weak var mensajeLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        valorIMCLbl.text = valorImc
        mensajeLbl.text = mensaje
        self.view.backgroundColor = color
        imageView.image = image
    }
    
    @IBAction func calculaNuevi(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
