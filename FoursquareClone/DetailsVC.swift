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
    
    override func viewWillDisappear(_ animated: Bool) {
        selectedPlaceId.removeAll()
        selectedPlaceName.removeAll()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchDataFromParse()
    }
   
    
    
    
    func fetchDataFromParse () {
        
        let parse = PFQuery(className: "Places")
        parse.whereKey("objectId", equalTo: selectedPlaceId)
        parse.findObjectsInBackground { (parseObjects, error) in
            if error != nil {
                self.makeAlert(alertTitle: "Fetching Failed", alertMessage: "\(error?.localizedDescription ?? "Error")", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, handler: "failed")
            } else {
                for object in parseObjects! {
                    if let name = object.object(forKey: "name") as? String {
                        self.placeNameLabel.text = name
                    }
                    if let type = object.object(forKey: "type") as? String {
                        self.placeTypeLabel.text = type
                    }
                    if let atmosphere = object.object(forKey: "atmosphere") as? String {
                        self.placeAtmosphereLabel.text = atmosphere
                    }
                    if let image = object.object(forKey: "image") as? PFFileObject {
                        image.getDataInBackground { fetchedImage, error in
                            if error == nil {
                                if fetchedImage != nil {
                                    self.imageView.image = UIImage(data: fetchedImage!)
                                }
                            }
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
