//
//  Artwork.swift
//  Kit-test
//
//  Created by student on 2/28/18.
//  Copyright © 2018 The-Windows-Specialists. All rights reserved.
//

import Foundation
import MapKit
import Contacts // dictionary key constant e.g. CNPostalAddressStreetKey

class Artwork: NSObject, MKAnnotation
{
    //!< To adopt MKAnnotation protocol, Artwork class needs a subclass NSObject
    //!< MKAnnotation is an NSObjectProtocol
    //!< MKAnnotation protocol requires 'coordinate' property
    //!< Intended for user to see title and subtitle when tapping a pin
    //!< subtitle computes property returning locationName to conform to MKAnnotation protocol
    //!< No PublicArt.json properties maps naturally to 'subtitle'
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String?
    {
        return locationName
    }
    
    // Creates MKMapItem from MKPlacemark
    // Maps reads this and displays it correctly
    func mapItem() -> MKMapItem
    {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let itemOfMap = MKMapItem(placemark: placemark)
        itemOfMap.name = title
        return itemOfMap
    }
}


