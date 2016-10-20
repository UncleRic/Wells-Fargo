//  Login.swift
//  WellsFargo
//
//  Created by Frederick C. Lee on 10/19/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit


class LoginViewController:UIViewController {
   
    @IBOutlet weak var pressFingerButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tintedCoverView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var pressFingerTopConstraint: NSLayoutConstraint!
    
    let kPressFingerTopConstant:CGFloat = 360.0
    
    override func viewDidLoad() {
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func animatePressFingerButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.pressFingerTopConstraint.constant = self.kPressFingerTopConstant
            self.view.layoutIfNeeded()
        })
    }

    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action Methods
    
    @IBAction func loginAction() {
        tintedCoverView.isHidden = false
        loginButton.isHidden = true
        animatePressFingerButton()
        
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func pressFingerAction() {
        
    }
    
}
