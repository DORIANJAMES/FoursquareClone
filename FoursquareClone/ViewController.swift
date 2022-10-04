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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Apple"
        parseObject["calories"] = 100
        
        parseObject.saveInBackground { success, error in
            if error != nil {
                
            } else {
                print("uploaded")
            }
        }
        
    }


}

