//  Shop.swift
//  WellsFargo
//
//  Created by Frederick C. Lee on 10/18/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

protocol CellProtocol {
    func shoppingCart(desc:String)
}

struct itemStuct {
    var itemImage:UIImage?
    var desc:String?
    var price:String?
    init(image:UIImage, desc:String, price:String) {
        self.itemImage = image
        self.desc = desc
        self.price = price
    }
}

typealias ItemData = itemStuct

var dataArray = [ItemData]()

class ItemCollectionCell:UICollectionViewCell {
    var delegate:ShopViewController?
    var itemData:ItemData? {
        didSet {
            descLabel.text = itemData?.desc
            priceLabel.text = itemData?.price
            imageView.image = itemData?.itemImage
        }
    }
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func addToCartAction() {
        delegate?.shoppingCart(desc:descLabel.text!)
    }
}

// ===================================================================================================

class ShopViewController:UIViewController, CellProtocol {
    
    let kCellID = "ItemCell"
    
    @IBOutlet weak var featuredItemLabel: UILabel!
    @IBOutlet weak var featuredItemPriceLabel: UILabel!
    @IBOutlet weak var featuredItemImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        self.title = "Shop"
        loadData()
        let b = UIBarButtonItem(image:UIImage(named:"ShoppingCart.png"), style:.plain, target:self, action:#selector(handleShoppingCart))
        
        self.navigationItem.rightBarButtonItems = [b]
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func loadData() {
        guard
            let image1 = UIImage(named: "page1Shoes.png"),
            let image2 = UIImage(named:"page2Shoes.png"),
            let image3 = UIImage(named:"Dress1.png"),
            let image4 = UIImage(named:"Dress2.png") else {
                return
        }
        
        let data1 = ItemData(image: image1, desc: "Sneakers A", price: "$49.95")
        let data2 = ItemData(image: image2, desc: "Shoes B", price: "$79.95")
        let data3 = ItemData(image: image3, desc: "Dress A", price: "$99.00")
        let data4 = ItemData(image: image4, desc: "Dress B", price: "$89.00")
        
        dataArray = [data1, data2, data3, data4]
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @objc func handleShoppingCart() {
        showAlert(sender: self, withTitle: "Your Shopping Cart", withMessage: "...is full of neat surprises!")
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func shoppingCart(desc:String) {
        let msg = desc+" Added"
        showAlert(sender: self, withTitle: "Your Shopping Cart", withMessage: msg)
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action Methods
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        showAlert(sender: self, withTitle: "Your Shopping Cart", withMessage: "Add to Shopping Cart\n ...Pending.")
    }
}

// ===================================================================================================

extension ShopViewController:UICollectionViewDelegate {
    // ...do something.
}

// ===================================================================================================

extension ShopViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for:indexPath) as! ItemCollectionCell
        cell.delegate = self
        guard !dataArray.isEmpty else {
            let itemImageView = cell.viewWithTag(3)
            itemImageView?.layer.borderColor = UIColor.gray.cgColor
            itemImageView?.layer.masksToBounds = true
            itemImageView?.layer.borderWidth = 1.0
            return cell
        }
        cell.itemData = dataArray[indexPath.item]
        let itemImageView = cell.viewWithTag(3)
        itemImageView?.layer.borderColor = UIColor.gray.cgColor
        itemImageView?.layer.masksToBounds = true
        itemImageView?.layer.borderWidth = 1.0
        
        return cell
    }
    
}
