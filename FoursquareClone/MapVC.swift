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
    var choosenLatitude = ""
    var choosenLongitude = ""

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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta:0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func addPin (longPressGestureRecognizer:UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touches = longPressGestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceInfo.sharedInstance.placeName
            annotation.subtitle = PlaceInfo.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            self.choosenLatitude = String(coordinates.latitude)
            self.choosenLongitude = String(coordinates.longitude)
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let placeInfo = PlaceInfo.sharedInstance
        
        let parseObject = PFObject(className: "Places", dictionary: nil)
        parseObject["name"] = placeInfo.placeName
        parseObject["type"] = placeInfo.placeType
        parseObject["Atmosphere"] = placeInfo.placeAtmosphere
        parseObject["image"] = placeInfo.placeImage?.jpegData(compressionQuality: 0.5)
        
        parseObject.saveInBackground { (saveInfo, error) in
            if error != nil {
                self.makeAlert(alertTitle: "Error!", alertMessage: "\(error?.localizedDescription ?? "ERROR=?")", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, handler: false)
            } else {
                self.makeAlert(alertTitle: "Success", alertMessage: "Your data has uploaded to our servers.", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, handler: true)
            }
        }
    }
    
    func makeAlert (alertTitle:String, alertMessage:String, alertStyle:UIAlertController.Style, buttonTitle:String, buttonStyle:UIAlertAction.Style, handler:Bool) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let okButton = UIAlertAction(title: buttonTitle, style: buttonStyle) { UIAlertAction in
            if handler == true {
                self.dismiss(animated: true)
            } else {
                
            }
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
   

}
