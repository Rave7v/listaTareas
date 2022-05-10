
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Mark: variables
    var listaTareas = [Tarea]()
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaTareas.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        let tarea = listaTareas[indexPath.row]
        
        //operador ternario ? = true : = false
        celda.textLabel?.text = tarea.titulo
        celda.textLabel?.textColor = tarea.realizada ? .black : .blue
        
        celda.detailTextLabel?.text = tarea.realizada ? "Completada" : "Por completar.."
        
        celda.accessoryType = tarea.realizada ? .checkmark : .none
        
        return celda
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if TablaTareas.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            TablaTareas.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            //si la celda no esta palomeada
            TablaTareas.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //edicion de core data
        listaTareas[indexPath.row].realizada = !listaTareas[indexPath.row].realizada
        guardar()
        
        //deseleccionar celda
        TablaTareas.deselectRow(at: indexPath, animated: true)
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
    

    @IBOutlet weak var TablaTareas: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TablaTareas.delegate = self
        TablaTareas.dataSource = self
        leer()
    }

    @IBAction func agregarTarea(_ sender: UIBarButtonItem) {
        var titulo = UITextField()
        let alerta = UIAlertController(title: "agregar", message: "Tarea", preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "aceptar", style: .default) { _ in
            //crear una nueva tarea
            let nuevaTarea = Tarea(context: self.contexto)
            nuevaTarea.titulo = titulo.text
            nuevaTarea.realizada = false
            
            //agregar nueva tarea al arreglo para rellenar
            self.listaTareas.append(nuevaTarea)
            
            self.guardar()
        }
        
        //agregar el text field
        alerta.addTextField { textFieldAlerta in
            textFieldAlerta.placeholder = "Escribe algo aqui.."
            titulo = textFieldAlerta
        }
        
        alerta.addAction(accionAceptar)
        present(alerta, animated: true)
    }
    
    func guardar(){
        do{
            try contexto.save()
        }catch{
            print("error al guardar: \(error.localizedDescription)")
        }
        self.TablaTareas.reloadData()
    }
    
    func leer() {
        let solicitud : NSFetchRequest<Tarea> = Tarea.fetchRequest()
        do{
            //tratar de asignar al arreglo lo que arroje la solicitud
            listaTareas = try contexto.fetch(solicitud)
        }catch{
            print("Error al leer datos \(error.localizedDescription)")
        }
    }
    
}

