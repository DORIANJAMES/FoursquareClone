//
//  SettingsVC.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 4.10.2022.
//

import UIKit
import Parse

class SettingsVC: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signOutButtonClicked(_ sender: Any) {
        PFUser.logOutInBackground { error in
            if error != nil {
                self.makeAlert(alertTitle: "LogOut Failed", alertMessage: "\(error?.localizedDescription ?? "ERROR")", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.destructive)
                //print("Error = \(error?.localizedDescription ?? "Error")")
            } else {
                self.makeAlert(alertTitle: "LogOut", alertMessage: "Completed", alertStyle: UIAlertController.Style.alert, buttonTitle: "OK", buttonStyle: UIAlertAction.Style.destructive)
                self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                
            }
        }
    }
    
    func makeAlert(alertTitle:String, alertMessage:String, alertStyle:UIAlertController.Style, buttonTitle:String, buttonStyle:UIAlertAction.Style) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let okButton = UIAlertAction(title: buttonTitle, style: buttonStyle) { UIAlertAction in
            if UIAlertAction.isEnabled == true {
                self.performSegue(withIdentifier: "toLoginVC", sender: nil)
            }
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
