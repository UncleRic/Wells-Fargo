//  PageViewController.swift
//  WellsFargo
//
//  Created by Frederick C. Lee on 10/18/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

let skyBlue = UIColor(red: 83/255, green: 117/255, blue: 182/255, alpha: 1.0)
let offWhite = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
let kShopVC = "ShopVC"

class PageViewController: UIViewController {
    
    @IBOutlet weak var VogueStoreStartupImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tintedCoverView: UIView!
    @IBOutlet weak var pressFingerButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var page1View: UIView!
    @IBOutlet weak var page2View: UIView!
    @IBOutlet weak var page3View: UIView!
    @IBOutlet weak var page4View: UIView!
    
    @IBOutlet weak var pressFingerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var page1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var page1LeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var page1RightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var page2LeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var page2WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var page3WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var page3LeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var page4WidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var page4LeftConstraint: NSLayoutConstraint!
    
    static var shopVC:UIViewController?
    
    let kPressFingerTopConstant:CGFloat = 260.0
    let kPressFingerExitConstant:CGFloat = 800.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tintedCoverView.alpha = 0.0
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        PageViewController.shopVC = storyboard.instantiateViewController(withIdentifier: kShopVC)
        self.title = "Vogue Store"
        let vogueStoreImage = UIImage(named:"VogueStore.png")
        self.navigationItem.titleView = UIImageView(image: vogueStoreImage)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    override func viewDidLayoutSubviews() {
        
        pageControl.numberOfPages = 4
        page1LeftConstraint.constant = 0
        page2LeftConstraint.constant = 0
        page3LeftConstraint.constant = 0
        page4LeftConstraint.constant = 0
        
        page1WidthConstraint.constant = UIScreen.main.bounds.size.width
        page2WidthConstraint.constant = UIScreen.main.bounds.size.width
        page3WidthConstraint.constant = UIScreen.main.bounds.size.width
        page4WidthConstraint.constant = UIScreen.main.bounds.size.width
        
        pageControl.size(forNumberOfPages: 4)
        pageControl.pageIndicatorTintColor = offWhite
        pageControl.currentPageIndicatorTintColor = skyBlue
        scrollView.contentSize.width = 1280.0
        
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @objc func handleContextMenu() {
        showAlert(sender: self, withTitle: "Contextual Menu", withMessage: "This is where a contextual menu would be displayed.")
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @objc func handlePersonalMenu() {
        showAlert(sender: self, withTitle: "Personal Menu", withMessage: "This is where a menu of systemic personal-items would be displayed.")
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func setupMenuBarItems() {
        let barsImage = UIImage(named:"bars.png")
        let headImage = UIImage(named:"head.png")
        let leftItem = UIBarButtonItem(image: barsImage, style: .plain, target: self, action: #selector(handleContextMenu))
        self.navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem(image: headImage, style: .plain, target: self, action: #selector(handlePersonalMenu))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animateOpeningSession() {
        
        UIView.animate(withDuration: 1.0, animations: {
            self.pressFingerTopConstraint.constant = self.kPressFingerExitConstant
            self.view.layoutIfNeeded()
        }) {(MiddleFinger) in
            UIView.animate(withDuration: 0.2, animations: {
                self.tintedCoverView.alpha = 0.0
                self.view.layoutIfNeeded()
            }) {(Two) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.VogueStoreStartupImageView.alpha = 0.0
                    self.setupMenuBarItems()
                })
            }
        }
    }
    // -----------------------------------------------------------------------------------------------------
    
    func animatePressFingerButton() {
        UIView.animate(withDuration: 0.2, animations: {
            self.tintedCoverView.alpha = 0.8
            self.view.layoutIfNeeded()
        }) {(MiddleFinger) in
            UIView.animate(withDuration: 1, animations: {
                self.pressFingerTopConstraint.constant = self.kPressFingerTopConstant
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    @IBAction func loginButtonAction() {
        tintedCoverView.isHidden = false
        loginButton.isHidden = true
        animatePressFingerButton()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func pressFingerAction() {
        animateOpeningSession()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func shopButtonAction() {
        guard let showVC = PageViewController.shopVC else {
            return
        }
        self.navigationController!.pushViewController(showVC, animated: true)
    }
}

// ===================================================================================================


extension PageViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let frameWidth = scrollView.frame.size.width
        let pageNumber = offset/frameWidth
        pageControl.currentPage = Int(pageNumber)
    }
}





