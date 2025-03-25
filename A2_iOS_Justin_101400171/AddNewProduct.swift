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

    @IBOutlet var textFields: [UITextField]!
    
    var products: [Product]?
    override func viewDidLoad() {
        super.viewDidLoad()
       NotificationCenter.default.addObserver(self, selector: #selector(saveData), name: UIApplication.willResignActiveNotification, object: nil)
        getData()
    }
    
    func getData() {
        products = [Product]()
        
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            products = try context.fetch(request)
        } catch {
            print("error while loading data from database: \(error.localizedDescription)")
        }
    }
    
    // Function for Adding Product to the database
    @IBAction func addProduct(_ sender: UIButton) {
        let productName = textFields[0].text ?? ""
        let productDescription = textFields[1].text ?? ""
        let productPrice = textFields[2].text ?? "0.0"
        let productProvider = textFields[3].text ?? ""
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let product = Product(context: context)
        product.productName = productName
        product.productDescription = productDescription
        product.productPrice = Double(productPrice) ?? 0.0
        product.productProvider = productProvider
        
        products?.append(product)
        saveData()
    }
    
    // add item to the database
    @objc func saveData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Error Saving Product \(error.localizedDescription)")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productTable = segue.destination as? ProductTableViewController
        productTable?.products = products
    }
}
