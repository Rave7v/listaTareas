

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var iconoCelda: UIImageView!
    @IBOutlet weak var NombreCrip: UILabel!
    @IBOutlet weak var valorCripto: UILabel!
    @IBOutlet weak var RankCripto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
