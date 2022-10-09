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

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print(placeName)
        print(placeType)
        print(placeAtmosphere)
    }
    
   

}
