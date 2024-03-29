//
//  ViewController.swift
//  MapNotes
//
//  Created by STANISLAV STAJILA on 1/30/24.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapViewOutlet: MKMapView!
    let locationManager = CLLocationManager()
    let locationManger = CLLocationManager()
    var currentLocation: CLLocation!
    var parks: [MKMapItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate =  self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.startUpdatingLocation()
        
        locationManager.requestWhenInUseAuthorization()
        mapViewOutlet.showsUserLocation = true
    
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center2 = locationManager.location!.coordinate
        
        let center = CLLocationCoordinate2D(latitude: 42.2371, longitude: -88.3226)
        
       let region = MKCoordinateRegion(center: center, latitudinalMeters: 1600, longitudinalMeters: 1600)
        let region2 = MKCoordinateRegion(center: center, span: span)
        
        
        mapViewOutlet.setRegion(region, animated: true)
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Parks"
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            guard let responce = response
            else {
                return
            }
            for mapItem in responce.mapItems{
                self.parks.append(mapItem)
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapViewOutlet.addAnnotation(annotation)
            }
        }
    }
    

}

