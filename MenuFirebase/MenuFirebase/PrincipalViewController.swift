
import UIKit

class PrincipalViewController: UIViewController {

    @IBOutlet weak var TablaCripto: UITableView!
    
    var criptoManager = CriptoManager()
    var seleccion: CriptoDatos?
    
    var listaCripto:[CriptoDatos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //registrar
        TablaCripto.register(UINib(nibName: "TableViewCell",bundle:nil), forCellReuseIdentifier: "celda")
        
        TablaCripto.delegate = self
        TablaCripto.dataSource = self
        criptoManager.delegado = self
        //delegados de la tabla
        criptoManager.buscarEstadisticas()
    }
    

    /* Mi Appi
     https://api.nomics.com/v1/currencies/ticker?key=ddd85c86d13ed6d32ee530ee4d3e33e96344b4dd&interval=1h,1d&convert=MNX&platform-currency=ETH&per-page=100&page=1
    */

}

extension PrincipalViewController: CriptoManagerDelegado{
    func actualizar(criptos: [CriptoDatos]) {
        print("Total de paises: \(criptos.count)")
        listaCripto = criptos
        
        DispatchQueue.main.async {
            self.TablaCripto.reloadData()
        }
    }
}

extension PrincipalViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCripto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1para la tabla personalizada
        let celda = TablaCripto.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! TableViewCell
        //2 castear la celda
        
        celda.NombreCrip.text = "Nombre: \(listaCripto[indexPath.row].name)"
        celda.RankCripto.text = "# \(listaCripto[indexPath.row].rank)"
        celda.valorCripto.text = "$ \(listaCripto[indexPath.row].price)"
        
        
        //mostarr imageb
        if let urlString = listaCripto[indexPath.row].logo_url{
            //print(urlString)
            if let imagenURL = URL(string: urlString){
                //print(imagenURL)
                DispatchQueue.global().async {
                    guard let imagenData = try? Data(contentsOf: imagenURL)else{ return }
                    //crear un obj tipo image
                    //print("imagen data: \(imagenData)")
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async {
                        celda.iconoCelda.image = image
                    }
                }
            }
        }
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TablaCripto.deselectRow(at: indexPath, animated: true)
        seleccion = listaCripto[indexPath.row]
        performSegue(withIdentifier: "detalle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalle"{
            let objetoDestino = segue.destination as! DetalleViewController
            objetoDestino.recibirObj = seleccion
        }
    }
    
}

