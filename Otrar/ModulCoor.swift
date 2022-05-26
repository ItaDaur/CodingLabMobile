//
//  ModulCoor.swift
//  Otrar
//
//  Created by Dauren Sarsenov on 24.05.2022.
//

import Foundation
import UIKit
import MapKit

class CoorForMap: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var name: String
    var city: String
    var title: String?{
        return name
    }
    init(coordinate:CLLocationCoordinate2D, name:String, city:String) {
        self.coordinate = coordinate
        self.name = name
        self.city = city
    }
}
