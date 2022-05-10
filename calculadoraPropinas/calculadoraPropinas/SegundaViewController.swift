
import UIKit

class SegundaViewController: UIViewController {
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var personal: UILabel!
    var tot:Double?
    var per:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        total.text = "\(tot ?? 00)"
        personal.text = "\(per ?? 00)"
    }
}
