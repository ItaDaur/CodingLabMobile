//
//  LibriesViewController.swift
//  Otrar
//
//  Created by Dauren Sarsenov on 02.05.2022.
//

import UIKit
import MapKit


class LibriesViewController: UIViewController {

    // AITU - 51.0908° N, 71.4183° E
    
    @IBOutlet weak var mapLibraries: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annontation = MKPointAnnotation()
        annontation.title = "The AITU Library"
        annontation.subtitle = "The AITU"
        annontation.coordinate = CLLocationCoordinate2D(latitude: 51.0908, longitude: 71.4183)
        mapLibraries.addAnnotation(annontation)
        
        let region = MKCoordinateRegion(center: annontation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapLibraries.setRegion(region, animated: true)

    }
    

}
