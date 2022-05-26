//
//  CreateNewMapViewController.swift
//  Otrar
//
//  Created by Dauren Sarsenov on 25.05.2022.
//

import UIKit
import MapKit

class CreateNewMapViewController: UIViewController {

    @IBOutlet weak var niceMapLib: MKMapView!
    let locationManager = CLLocationManager()
    let coorModul = CoorMapModul()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.niceMapLib.delegate = self
        for coor in coorModul.users.first!{
            niceMapLib.addAnnotation(coor)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkAuthorization()
        } else {
            showAlertLocation(title: "Your geolocation service is disabled", message: "Do you want to turn it on?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            niceMapLib.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: "Prohibition on the use of location", message: "Do you want to change this?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func showAlertLocation(title:String, message:String?, url:URL?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsLocationAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsLocationAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}

extension CreateNewMapViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            niceMapLib.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
}

extension CreateNewMapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CoorForMap else {return nil}
        let idView = "marker"
        var viewMarker: MKMarkerAnnotationView
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.calloutOffset = CGPoint(x: 0, y: 6)
            viewMarker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return viewMarker
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let coordinate = locationManager.location?.coordinate else {return}
        
        self.niceMapLib.removeOverlays(mapView.overlays)
        
        let user = view.annotation as! CoorForMap
        let startpoint = MKPlacemark(coordinate: coordinate)
        let endpoint = MKPlacemark(coordinate: user.coordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startpoint)
        request.destination = MKMapItem(placemark: endpoint)
        request.transportType = .automobile
        
        let direction = MKDirections(request: request)
        direction.calculate { (response, error) in
            guard let response = response else {return}
            for route in response.routes{
                self.niceMapLib.addOverlay(route.polyline)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 6
        
        return renderer
    }
}
