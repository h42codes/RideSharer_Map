//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            let alert = UIAlertController(title: "Location unavailable", message: "Location service must be enabled to use RideSharer", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .denied:
            showPermissionDeniedAlert()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted:
            showPermissionDeniedAlert()
        case .authorizedAlways:
            break
        default:
            break
        }
    }
    
    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Permission required", message: "Location authorization needed to use RideSharer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
