//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 4.10.2022.
//

import UIKit
import ParseSwift
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // PARSE üzerine bir FPObject kaydını gerçekleştiren fonksiyonlar.
        /*let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        
        parseObject.saveInBackground { success, error in
            if error != nil {
                
            } else {
                print("uploaded")
            }
        }*/
        
        
        // PARSE üzerindeki verilerin çekilme işlemini gerçekleştiren fonksiyonlar.
        /*let query = PFQuery(className: "Fruits")
        query.whereKey("calories", greaterThan: 100)
        query.findObjectsInBackground { queryObject, error in
            if error != nil {
                
            } else {
                print(queryObject)
            }
        }*/
        
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        if usernameTextInput.text == "" && passwordTextInput.text == "" {
            makeAlert(alertTitle: "Empty Fields", alertMessage: "Login requires boh your 'User Name' and 'Password' been placed in related fields", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, isAnimated: true)
        }else {
            PFUser.logInWithUsername(inBackground: usernameTextInput.text!, password: passwordTextInput.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(alertTitle: "Login Failed", alertMessage: "\(error?.localizedDescription ?? "Error")", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, isAnimated: true)
                } else {
                    self.performSegue(withIdentifier: "logedin", sender: user)
                }
            }
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if usernameTextInput.text != "" {
            if passwordTextInput.text != "" {
                let user = PFUser()
                user.username = usernameTextInput.text
                user.password = passwordTextInput.text
                
                user.signUpInBackground { (success,error) in
                    if error != nil {
                        self.makeAlert(alertTitle: "Sign Up Failed", alertMessage: error?.localizedDescription ?? "Error", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, isAnimated: true)
                    } else {
                        self.performSegue(withIdentifier: "logedin", sender: nil)
                    }
                }
                
            } else {
                makeAlert(alertTitle: "Fields Empty", alertMessage: "You should chose a pasword to complete Sign Up process.", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, isAnimated: true)
            }
        } else {
            makeAlert(alertTitle: "Fields Empty", alertMessage: "Username should be placed and be unique to continue on Sign Up process.", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.default, isAnimated: true)
        }
    }
    
    
    
    // Kullanıcıya gösterilecek Alert Fonksiyonu.
    func makeAlert(alertTitle:String, alertMessage:String, alertStyle:UIAlertController.Style, buttonTitle:String, buttonStyle:UIAlertAction.Style, isAnimated:Bool) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let okButton = UIAlertAction(title: buttonTitle, style: buttonStyle)
        alert.addAction(okButton)
        self.present(alert, animated: isAnimated)
    }
    
    func fetchFromParse() {
        
    }
}

