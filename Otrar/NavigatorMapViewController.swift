//
//  NavigatorMapViewController.swift
//  Otrar
//
//  Created by Dauren Sarsenov on 07.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class NavigatorMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var textFieldForAddress: UITextField!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var mapNav: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapNav.delegate = self
        
    }
    
    @IBAction func getDirectionsTapped(_ sender: Any) {
        getAddress()
    }
    
    func getAddress() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(textFieldForAddress.text!) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location
            else {
                print("No Location Found")
                return
            }
            print(location)
            self.mapThis(destinationCord: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func mapThis(destinationCord : CLLocationCoordinate2D) {
        
        let sourceCoordinate = (locationManager.location?.coordinate)!
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destPlacemark = MKPlacemark(coordinate: destinationCord)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Something is wrong :(")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapNav.addOverlay(route.polyline)
            self.mapNav.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    
}
