
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tablaContactos: UITableView!
    var nombreMan:String?
    
    override func viewDidLoad() {
        
        tablaContactos.delegate = self
        tablaContactos.dataSource = self
        super.viewDidLoad()
    }
    
    //metodos tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaContactos.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Fersillo"
        celda.detailTextLabel?.text = "44512541"
        celda.imageView?.image = UIImage(systemName: "person")
        nombreMan = celda.textLabel?.text
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "editar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar"{
            let objetoDestino = segue.destination as! EditarContactoViewController
            objetoDestino.nombre = nombreMan
        }
    }
}

