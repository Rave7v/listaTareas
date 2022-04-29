
import UIKit

class CeldaPaisTableViewCell: UITableViewCell {
    @IBOutlet weak var activoLabel: UILabel!
    @IBOutlet weak var nombrePais: UILabel!
    @IBOutlet weak var banderaPais: UIImageView!
    @IBOutlet weak var recuperados: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // redondear imagen
        banderaPais.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
