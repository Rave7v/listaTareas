
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablaTareas: UITableView!
    
    var listaTareas = [Tarea]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tablaTareas.delegate = self
        tablaTareas.dataSource = self
    }

    @IBAction func agregarTareaBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "nuevo", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaTareas.dequeueReusableCell(withIdentifier: "celda" ,for: indexPath)
        celda.textLabel?.text = listaTareas[indexPath.row].titulo
        celda.detailTextLabel?.text = "\(listaTareas[indexPath.row].fecha ?? Date() )"
        return celda
    }
    
}

