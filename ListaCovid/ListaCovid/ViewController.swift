import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tablaPaises: UITableView!
    
    var covidManager = CovidManager()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //delegados de la tabla
        tablaPaises.delegate = self
        tablaPaises.dataSource = self
        covidManager.buscarEstadisticas()
        
    }
    func buscarEstadisticas() {
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries/"
        if let url = URL(string: urlString){
            DispatchQueue.global().async {
                if let imagenData = try? Data(contentsOf: url){
                    let imagen = UIImage(data: imagenData)
                    //actualizar la intefaz grafica
                    DispatchQueue.main.async {
                        // actualizar la imagen de la celda
                        
                    }
                }//iflet
            }//dispatch
        }//let url
    }//func
}




//para el table view
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPaises.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Mexico"
        celda.detailTextLabel?.text = "ª"
        celda.imageView?.image = UIImage(systemName: "flag")
        return celda
    }
    
    
}
