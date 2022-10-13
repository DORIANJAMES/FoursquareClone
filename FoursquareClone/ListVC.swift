//
//  ListVC.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 4.10.2022.
//

import UIKit
import Parse
import ParseSwift

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
 
    
    @IBOutlet weak var tableView: UITableView!
    var placeNameArray = [String]()
    var placeTypeArray = [String]()
    var placeAtmosphereArray = [String]()
    var placeImageArray = [Data]()
    var placeObjectId = [String]()
    var chosenPlaceId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromParse()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = placeNameArray[indexPath.row]
        cell.contentConfiguration = context
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        chosenPlaceId = placeObjectId[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedPlaceId = chosenPlaceId
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            chosenPlaceId = placeObjectId[indexPath.row]
            let query = PFQuery(className: "Places")
            query.whereKey("objectId", equalTo: chosenPlaceId)
            query.findObjectsInBackground { pfObjects, error in
                pfObjects![0].deleteEventually()
                self.tableView.reloadData()
                // Burada da çalıştırdım ancak yine olmadı
            }
            
        }
        
    }
    
   
    
    
    func getDataFromParse() {
        let queryFromServer = PFQuery(className: "Places")
        placeNameArray.removeAll()
        placeTypeArray.removeAll()
        placeAtmosphereArray.removeAll()
        placeImageArray.removeAll()
        placeObjectId.removeAll()
        chosenPlaceId.removeAll()
        
        queryFromServer.findObjectsInBackground { parseObjecs, error in
            if error != nil {
                self.makeAlert(alertTitle: "Fetching Failed", alertMessage: "\(error?.localizedDescription ?? "ERROR")", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, handler: "failed")
            } else {
                for object in parseObjecs! {
                    if let name = object.object(forKey: "name") as? String {
                        self.placeNameArray.append(name)
                    }
                    if let type = object.object(forKey: "type") as? String {
                        self.placeTypeArray.append(type)
                    }
                    if let atmosphere = object.object(forKey: "atmosphere") as? String {
                        self.placeAtmosphereArray.append(atmosphere)
                    }
                    if let image = object.object(forKey: "image") as? Data {
                        self.placeImageArray.append(image)
                    }
                    if let id = object.objectId {
                        self.placeObjectId.append(id)
                    }
                    
                }
                // Tablonun görünmesini istiyorsan bu fonksiyonu mutlaka çağırmak gerekli for'dan sonra.
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    
    
    
    func makeAlert (alertTitle:String,alertMessage:String,alertStyle:UIAlertController.Style, buttonTitle:String, buttonStyle:UIAlertAction.Style, handler:String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let okButton = UIAlertAction(title: buttonTitle, style: buttonStyle) { UIAlertAction in
            switch handler {
                case "fetched":
                    break
                case "failed":
                    break
                default:
                    break
                    
            }
        }
    }
}
