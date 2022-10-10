//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 4.10.2022.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var imageViewImage : Data?
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(addPin(longPressGestureRecognizer:)))
        longPressGestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(longPressGestureRecognizer)
        
    }
    
    @objc func addPin (longPressGestureRecognizer:UILongPressGestureRecognizer) {
        // Pin eklenecek
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print(placeName)
        print(placeType)
        print(placeAtmosphere)
    }
    
   

}
