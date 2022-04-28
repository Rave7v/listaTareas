import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tablaPaises: UITableView!
   
    var covidManager = CovidManager()
    //lista paises
    var listaPaises:[CovidDatos] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaPaises.delegate = self
        tablaPaises.dataSource = self
        covidManager.delegado = self
        //delegados de la tabla
        
        covidManager.buscarEstadisticas()
    }
}

extension ViewController: covidManagerDelegado{
    func actualizar(paises: [CovidDatos]) {
        print("Total de paises: \(paises.count)")
        listaPaises = paises
        
        DispatchQueue.main.async {
            self.tablaPaises.reloadData()
        }
    }
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
//para el table view

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPaises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaPaises.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = listaPaises[indexPath.row].country
        celda.detailTextLabel?.text = "casos activos: \(listaPaises[indexPath.row].active!)"
        
        //mostarr imageb
        if let urlString = listaPaises[indexPath.row].countryInfo?.flag{
            //print(urlString)
            if let imagenURL = URL(string: urlString){
                //print(imagenURL)
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL)else{ return }
                    //crear un obj tipo image
                    //print("imagen data: \(imagenData)")
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.imageView?.image = image
                    }
                }
            }
        }
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablaPaises.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "info", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
