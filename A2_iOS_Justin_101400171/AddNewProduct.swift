//
//  AddNewProduct.swift
//  A2_iOS_Justin_101400171
//
//  Created by Justin Yeh on 2025-03-24.
//
/*
 import Foundation
 import UIKit
 import CoreData
 
 class AddNewProduct: UIViewController {
 
 }
 */

import Foundation
import UIKit
import CoreData

class AddNewProduct: UIViewController {

    
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var providerField: UITextField!
    
    var products: [Product]?
    override func viewDidLoad() {
        super.viewDidLoad()
       /* NotificationCenter.default.addObserver(self, selector: #selector(saveData), name: UIApplication.willResignActiveNotification, object: nil)*/
    }
    
    
    @objc func saveData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Error Saving Product \(error.localizedDescription)")
        }
    }

    
    @IBAction func addProduct(_ sender: UIButton) {
        let productName = productNameField.text ?? ""
        let productDescription = descriptionField.text ?? ""
        let productPrice = priceField.text ?? "0"
        let productProvider = providerField.text ?? ""
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)
        product.productName = productName
        product.productDescription = productDescription
        product.productPrice = Double(productPrice) ?? 0.0
        product.productProvider = productProvider
        
        products?.append(product)
        saveData()
    }
    /*@IBAction func addProduct(_ sender: UIButton) {
        let productName = productNameField.text ?? ""
        let productDescription = descriptionField.text ?? ""
        let productPrice = priceField.text ?? "0"
        let productProvider = providerField.text ?? ""
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)
        product.productName = productName
        product.productDescription = productDescription
        product.productPrice = Double(productPrice) ?? 0.0
        product.productProvider = productProvider
        
        products?.append(product)
        saveData()
    } */
}
