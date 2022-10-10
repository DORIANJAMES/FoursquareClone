//
//  AddNewVC.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 6.10.2022.
//

import UIKit
import Parse

// Bu ekranda alınması gereken bilgileri burada global değişken olarak kaydedip MapVC'ye gönderebiliriz ancak bu güvenlik açısından çok tehlikeli olabilir. Bundan dolayı bu durum çok geliştiricili projelerde tercih edilmemektedir.

class AddNewVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameTF: UITextField!
    @IBOutlet weak var placeTypeTF: UITextField!
    @IBOutlet weak var placeAtmosphereTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goToMapButton: UIButton!
    
    
    var placeTypeEditingChanged : Bool?
    var placeNameEditingChanged : Bool?
    var picking:Bool?
    
    @IBAction func placeAtmosphereEditingChanged(_ sender: Any) {
        if placeAtmosphereTF.text == "" {
            goToMapButton.isEnabled = false
        } else {
            if placeTypeEditingChanged == true {
                if placeNameEditingChanged == true {
                    goToMapButton.isEnabled = true
                }
            }
        }
    }
    
    
    @IBAction func placeTypeEditingChanged(_ sender: Any) {
        if placeTypeTF.text == "" {
            placeTypeEditingChanged = false
            goToMapButton.isEnabled = false
        } else {
            placeNameEditingChanged = true
        }
    }
    
    
    @IBAction func placeNameEditingChanged(_ sender: Any) {
        if placeNameTF.text == "" {
            placeNameEditingChanged = false
            goToMapButton.isEnabled = false
        } else {
            placeNameEditingChanged = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        goToMapButton.isEnabled = false
        
    }
       
    
    
    @objc func selectImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true)
    }
        
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        if placeNameTF.text != "" && placeTypeTF.text != "" && placeAtmosphereTF.text != "" {
            goToMapButton.isEnabled = true
        } else {
            goToMapButton.isEnabled = false
        }
    }
    
    
    
    @IBAction func goToMapButtonClicked(_ sender: Any) {
        
        
        // Applikasyonu güvene alıyoruz
        if placeTypeTF.text != "" && placeNameTF.text != "" && placeAtmosphereTF.text != "" {
            if let chosenImage = imageView.image {
                // PlaceInfo Singleton Instance oluşturuluyor.
                let placeInfo = PlaceInfo.sharedInstance
                // Değerler global değişkene atanıyor.
                placeInfo.placeName = placeNameTF.text!
                placeInfo.placeType = placeTypeTF.text!
                placeInfo.placeAtmosphere = placeAtmosphereTF.text!
                placeInfo.placeImage = chosenImage
                
                // Artık aşağıdaki segue'ye ihtiyacımız kalmıyor. Gönderilmek istenilen tüm değişkenleri Singleton Class içerisinde tanımladık ve istediğimiz class ya da fonksiyon içerisinden çağırabiliyoruz.
                performSegue(withIdentifier: "toMapVC", sender: nil)
            } else {
                makeAlert(alertTitle: "Missing Image", alertMessage: "Please select and Image by tapping shown area", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default)
            }
        } else {
            makeAlert(alertTitle: "Missing Information", alertMessage: "Please fill the related areas first", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default)
        }
    }
    
    func makeAlert (alertTitle:String, alertMessage:String, alertStyle:UIAlertController.Style, buttonTitle:String, buttonStyle:UIAlertAction.Style){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let okButton = UIAlertAction(title: buttonTitle, style: buttonStyle)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
        
    
    /* Dolayısıyla yukarıdaki segue ile işimiz kalmadığına göre aşağıdaki fonksiyon ile de işimiz kalmadı bunu da yorum satırı haline getiriyoruz.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MapVC
        if placeNameTF.text != nil && placeTypeTF.text != nil && placeAtmosphereTF.text != nil {
                destinationVC.placeName = placeNameTF.text!
                destinationVC.placeType = placeTypeTF.text!
                destinationVC.placeAtmosphere = placeAtmosphereTF.text!
                destinationVC.imageViewImage = imageView.image?.jpegData(compressionQuality: 0.5)!
        
        }
    }
    */
    

}
