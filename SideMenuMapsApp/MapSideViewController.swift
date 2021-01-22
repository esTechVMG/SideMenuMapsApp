//
//  MapSideViewController.swift
//  SideMenuMapsApp
//
//  Created by A4-iMAC01 on 19/01/2021.
//

import UIKit
import MapKit
class MapSideViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lateralMenuBtn: UIBarButtonItem!
    
    var positoLocation = CLLocation(latitude: 38.092711, longitude: -3.6371597)
    var estechLocation = CLLocation(latitude: 38.0941902, longitude: -3.6334425)
    let regionRadius:CLLocationDistance = 1000
    override func viewDidLoad() {
        mapView.delegate = self
        self.sideMenus()
        centerMapOnLocation(location: positoLocation)
        showArtwork(coordinate: positoLocation.coordinate, name: "El Pósito", subtitle: "El Pósito de Linares", discipline:  "Centro de información turística", image: nil, urlString: nil)
        showArtwork(coordinate: estechLocation.coordinate, name: "EscuelaEstech", subtitle: "Escuela de tecnologias aplicadas", discipline: "Centro de Estudios", image: UIImage(named: "estechLogo"), urlString: "https://escuelaestech.es")
    }
    func centerMapOnLocation(location:CLLocation) -> Void {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func showArtwork(coordinate:CLLocationCoordinate2D, name:String!, subtitle:String!,discipline:String,image:UIImage?,urlString:String?) {
        let artwork = Artwork(title:name , locationName:subtitle , discipline:discipline, coordinate: coordinate,image: image, urlString: urlString)
        mapView.addAnnotation(artwork)
    }
    func sideMenus() {
        if revealViewController() != nil{
            lateralMenuBtn.target = revealViewController()
            lateralMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = UIScreen.main.bounds.width - 50
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
    }
}

extension MapSideViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else {return nil}
        let identifier = "marker"
        var view:MKMarkerAnnotationView
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeueView.annotation = annotation
            view = dequeueView
        }else{
            //Crear un nuevo objeto MKMarkerAnnotationView
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.glyphImage = annotation.image
        }
        return view
    }
    func mapView (_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control:UIControl){
        let location = view.annotation as! Artwork
        if let urlStr = location.urlString {
            if let url = URL(string: urlStr){
                UIApplication.shared.open(url)
            }
        }else{
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMaps(launchOptions: launchOptions)
        }
    }
}
