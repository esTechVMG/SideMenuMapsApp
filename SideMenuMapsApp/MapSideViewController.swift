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
    var location = CLLocation(latitude: 38.092711, longitude: -3.6371597)
    let regionRadius:CLLocationDistance = 1000
    override func viewDidLoad() {
        centerMapOnLocation(location: location)
    }
    func centerMapOnLocation(location:CLLocation) -> Void {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
