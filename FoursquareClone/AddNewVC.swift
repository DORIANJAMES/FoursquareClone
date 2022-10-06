//
//  AddNewVC.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 6.10.2022.
//

import UIKit

class AddNewVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameTF: UITextField!
    @IBOutlet weak var placeTypeTF: UITextField!
    @IBOutlet weak var placeAtmosphereTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var goToMapButton: UIButton!
    
    var picking:Bool?
    
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
            if info[.originalImage] != nil {
                goToMapButton.isEnabled = true
            }
        }
    }
    

    @IBAction func goToMapButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MapVC
        if placeNameTF.text != nil && placeTypeTF.text != nil && placeAtmosphereTF.text != nil {
            if picking == true {
                
                
    
                destinationVC.placeName = placeNameTF.text!
                destinationVC.placeType = placeTypeTF.text!
                destinationVC.placeAtmosphere = placeAtmosphereTF.text!
                destinationVC.imageViewImage = imageView.image!
            }
        }
    }
    

}
