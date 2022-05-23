
import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var buscadorSb: UISearchBar!
    
    //variables
    var latitud:CLLocationDegrees?
    var longitud:CLLocationDegrees?
    var altitud:Double?
    
    //manager para usar gps
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buscadorSb.delegate = self
        manager.delegate = self
        mapa.delegate = self
        
        mapa.mapType = .satellite
        
        //manager
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        //mejorar la presicion
        manager.desiredAccuracy = kCLLocationAccuracyBest
        //monitorear en todo momento
        manager.startUpdatingLocation()
    }
    
    //cuando se presiona el boton virtual
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        buscadorSb.resignFirstResponder()
        let geocoder = CLGeocoder()
        
        //crear variable segura
        if let direccion = buscadorSb.text{
            geocoder.geocodeAddressString(direccion) { (places: [CLPlacemark]?,error: Error?) in
                //crear destino
                guard let destinoRuta = places?.first?.location else{return}
                if error == nil{
                    let lugar = places?.first
                    let anotacion = MKPointAnnotation()
                    anotacion.coordinate = (lugar?.location?.coordinate)!
                    anotacion.title = direccion
                    
                    //span o nivel de zoom
                    let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                    
                    //
                    self.mapa.setRegion(region, animated: true)
                    self.mapa.addAnnotation(anotacion)
                    
                    self.trazarRuta(coordenadasDestino: destinoRuta.coordinate)
                }//if error
                else{
                    print("Error al encontrar direccion o lugar!")
                }
            }//closure
        }//if let direccion
    }//metodo
    
    @IBAction func borrar(_ sender: UIBarButtonItem) {
        let overlays = mapa.overlays
        mapa.removeOverlays(overlays)
        mapa.removeAnnotations(mapa.annotations)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderizado = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderizado.strokeColor = .cyan
        return renderizado
    }
    
    func trazarRuta(coordenadasDestino: CLLocationCoordinate2D) {
        guard let coordOrigen = manager.location?.coordinate else { return }
        //origen - destino
        let origenPlaceMark = MKPlacemark(coordinate: coordOrigen)
        let destinoPlaceMark = MKPlacemark(coordinate: coordenadasDestino)
        
        //objeto map kit
        let origenItem = MKMapItem(placemark: origenPlaceMark)
        let destinoItem = MKMapItem(placemark: destinoPlaceMark)
        
        //solicitar ruta
        let solicitudDestino = MKDirections.Request()
        solicitudDestino.source = origenItem
        solicitudDestino.destination = destinoItem
        
        solicitudDestino.transportType = .automobile
        //calcular nuevas rutas
        solicitudDestino.requestsAlternateRoutes = true
        
        let direccciones = MKDirections(request: solicitudDestino)
        direccciones.calculate { (respuesta, error) in
            //respuesta segura
            guard let respuestaSegura = respuesta else{
                if let error = error{
                    print("Error al calcular la ruta\(error.localizedDescription)")
                    
                    let alerta = UIAlertController(title: "error", message: "Ruta inalcanzable", preferredStyle: .alert)
                    let accionOk = UIAlertAction(title: "ok", style: .default)
                    
                    alerta.addAction(accionOk)
                    self.present(alerta, animated: true)
                }//
                return
            }//respuesta segura
            if let ruta = respuestaSegura.routes.first{
                self.mapa.addOverlay(ruta.polyline)
                self.mapa.setVisibleMapRect((ruta.polyline.boundingMapRect), animated: true)
            }
        }
    }

    @IBAction func ubicacionBtn(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Ubicacion", message: "lat:\(latitud ?? 0), lon \(longitud ?? 0)", preferredStyle: .alert)
        let accionOk = UIAlertAction(title: "ok", style: .default)
        
        alerta.addAction(accionOk)
        present(alerta, animated: true)
        
        //hacer zoom
        let localizacion = CLLocationCoordinate2D(latitude: latitud ?? 0, longitude: longitud ?? 0)
        let spanMapa = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: localizacion, span: spanMapa)
        
        mapa.setRegion(region, animated: true)
        mapa.showsUserLocation = true
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("numero de ubicaciones \(locations.count)")
        //crear ubicacion
        guard let ubicacion = locations.first else {return}
        latitud = ubicacion.coordinate.latitude
        longitud = ubicacion.coordinate.longitude
        altitud = ubicacion.altitude
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener ubicacion")
        let alerta = UIAlertController(title: "error", message: "Al obtener ubicacion", preferredStyle: .alert)
        let accionOk = UIAlertAction(title: "ok", style: .default)
        
        alerta.addAction(accionOk)
        present(alerta, animated: true)
    }
}

