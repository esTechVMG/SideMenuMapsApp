//
//  ArtWork.swift
//  mapkitExample
//
//  Created by esTechVMG on 13/1/21.
//

import UIKit
import MapKit
import Contacts
class Artwork: NSObject,MKAnnotation {
    let title: String?
    let locationName:String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let image:UIImage?
    let urlString:String?
    
    init(title:String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D,image:UIImage?,urlString:String?) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.image = image
        self.urlString = urlString
        super.init()
    }
    var subtitle: String?{
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate:coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark:placemark)
        mapItem.name = title
        return mapItem
    }
    
}

