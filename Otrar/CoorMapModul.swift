//
//  CoorMapModul.swift
//  Otrar
//
//  Created by Dauren Sarsenov on 24.05.2022.
//

import Foundation
import UIKit
import MapKit

class CoorMapModul {
    var users = [[CoorForMap]]()
    init() {
        setup()
    }
    
    func setup() {
        // AITU - 51.0908° N, 71.4183° E
        let m1 = CoorForMap(coordinate: CLLocationCoordinate2D(latitude: 51.0908, longitude: 71.4183), name: "AstanaIT", city: "Astana")
        // 51.127902, 71.427034
        let m2 = CoorForMap(coordinate: CLLocationCoordinate2D(latitude: 51.127902, longitude: 71.427034), name: "Adil", city: "Astana")
        // 51.127672, 71.427098
        let m3 = CoorForMap(coordinate: CLLocationCoordinate2D(latitude: 51.127672, longitude: 71.427098), name: "Biba", city: "Astana")
        // 51.116713, 71.441422
        let m4 = CoorForMap(coordinate: CLLocationCoordinate2D(latitude: 51.116713, longitude: 71.441422), name: "Daur", city: "Astana")
        
        let coorArray = [m1,m2,m3,m4]
        
        users.append(coorArray)
    }
}
