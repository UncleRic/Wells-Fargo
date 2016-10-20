//  Alerts.swift
//  WellsFargo
//
//  Created by Frederick C. Lee on 10/19/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

enum AlertPurpose:Int {
    case simple // ...generic OK response.
}

func showAlert(sender:UIViewController, withTitle title:String, withMessage msg:String, alertPurpose:AlertPurpose = .simple) {
    
    DispatchQueue.main.async(execute: {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        if alertPurpose == .simple {
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print("OK Action acknowledged.")
            }
            
            alertController.addAction(OKAction)
        }
        sender.present(alertController, animated: true, completion: nil)
    })
}
