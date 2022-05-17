
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablaTareas: UITableView!
    
    var listaTareas = [Tarea]()
    
    var tareaEnviar: Tarea?
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tablaTareas.delegate = self
        tablaTareas.dataSource = self
        //leer info
        leerTareas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        leerTareas()
        //no se puede hacer directo por que no guarda
    }
    
    func leerTareas(){
        let solicitud: NSFetchRequest<Tarea> = Tarea.fetchRequest()
        do {
            listaTareas = try contexto.fetch(solicitud)
        }catch{
            print(error.localizedDescription)
        }
        tablaTareas.reloadData()
    }

    @IBAction func agregarTareaBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "nuevo", sender: self)
    }
    
    //tabla metodos
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tareaEnviar = listaTareas[indexPath.row]
        performSegue(withIdentifier: "editar", sender: self)
    }
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTareas.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar"{
            let objDestino = segue.destination as! EditarTareaViewController
            objDestino.recibirTarea = tareaEnviar
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaTareas.dequeueReusableCell(withIdentifier: "celda" ,for: indexPath)
        celda.textLabel?.text = listaTareas[indexPath.row].titulo
        celda.detailTextLabel?.text = "\(listaTareas[indexPath.row].fecha ?? Date() )"
        let imagenes = UIImage(data: listaTareas[indexPath.row].imagen!)
        celda.imageView?.image = imagenes
        return celda
        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionEliminar = UIContextualAction(style: .normal, title: "borrar") { _, _, _ in
            self.contexto.delete(self.listaTareas[indexPath.row])
            self.listaTareas.remove(at: indexPath.row)
            
            self.guardar()
        }
        accionEliminar.image = UIImage(systemName: "trash")
        accionEliminar.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
    func guardar(){
        do{
            try contexto.save()
        }catch{
            print("error al guardar: \(error.localizedDescription)")
        }
        self.tablaTareas.reloadData()
    }
    
}

