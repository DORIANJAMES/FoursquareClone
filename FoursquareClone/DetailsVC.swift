//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 10.10.2022.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var selectedPlaceName = ""
    var selectedPlaceId = ""
    var selectedLatitudeDouble = Double()
    var selectedLongitudeDouble = Double()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeAtmosphereLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        fetchDataFromParse()
    }
    
    func fetchDataFromParse () {
        
        let parse = PFQuery(className: "Places")
        parse.whereKey("objectId", equalTo: selectedPlaceId)
        parse.findObjectsInBackground { (parseObjects, error) in
            if error != nil {
                self.makeAlert(alertTitle: "Fetching Failed", alertMessage: "\(error?.localizedDescription ?? "Error")", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, handler: "failed")
            } else {
                if parseObjects != nil {
                    if parseObjects!.count > 0 {
                        let chosenPlaceObject = parseObjects![0]
                    
                        if let name = chosenPlaceObject.object(forKey: "name") as? String {
                            self.placeNameLabel.text = name
                        }
                        if let type = chosenPlaceObject.object(forKey: "type") as? String {
                            self.placeTypeLabel.text = type
                        }
                        if let atmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.placeAtmosphereLabel.text = atmosphere
                        }
                        if let image = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            image.getDataInBackground { fetchedImage, error in
                                if error == nil {
                                    if fetchedImage != nil {
                                        self.imageView.image = UIImage(data: fetchedImage!)
                                    }
                                }
                            }
                        }
                        if let latitude = chosenPlaceObject.object(forKey: "latidude") as? String {
                            if let doubleLatitude = Double(latitude) {
                                self.selectedLatitudeDouble = doubleLatitude
                                
                            }
                        }
                        if let longitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                            if let doubleLongitude = Double(longitude) {
                                self.selectedLongitudeDouble = doubleLongitude
                                print("Longitude = \(self.selectedLongitudeDouble)")
                            }
                        }
                        if let selectedName = chosenPlaceObject.object(forKey: "name") as? String {
                            self.selectedPlaceName = selectedName
                        }
                        
                        self.mapCodes()
                       
                    }
                }
            }
        }
    }
    
    func mapCodes () {
        // MAP CODES
        let location = CLLocationCoordinate2D(latitude: selectedLatitudeDouble, longitude: selectedLongitudeDouble)
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: location, span: span)
        self.mapView.setRegion(region, animated: true)
        print("\(selectedLatitudeDouble)")
        print("\(selectedLongitudeDouble)")
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = self.placeNameLabel.text
        annotation.subtitle = self.placeTypeLabel.text
        self.mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            // MKPinAnnotationView IOS16 ve sonrası için depreciated edildiği için onun yerine MKMarkerAnnotationView fonksiyonunu kullanıyoruz.
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedLatitudeDouble != 0.0 && selectedLongitudeDouble != 0.0 {
            let requestLocation = CLLocation(latitude: selectedLatitudeDouble, longitude: selectedLongitudeDouble)
            // reverseGocodeLocation bizim bulunduğumuz yerden annotasyondaki yer'e geri rota çizer. Bunu mecburen yapmamız lazım.
            CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarks, error in
                if error != nil {
                    self.makeAlert(alertTitle: "Location Couldn't Find", alertMessage: "Sorry, we couldn't find your current location for drawing a route to target location", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, handler: "")
                    
                } else {
                    if let placemark = placemarks {
                        if placemark.count > 0 {
                            let newPlacemark = MKPlacemark(placemark: placemark[0])
                            let item = MKMapItem(placemark: newPlacemark)
                            item.name = self.selectedPlaceName
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                            item.openInMaps(launchOptions: launchOptions)
                        }
                    }
                }
            }
        }
    }
   
    
    func makeAlert(alertTitle:String, alertMessage:String,alertStyle:UIAlertController.Style, buttonTitle:String, buttonStyle:UIAlertAction.Style, handler:String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let okButton = UIAlertAction(title: buttonTitle, style: buttonStyle) { UIAlertAction in
            switch (handler) {
                case "done":
                    break
                case "failed":
                    break
                default:
                    break
            }
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    

}
