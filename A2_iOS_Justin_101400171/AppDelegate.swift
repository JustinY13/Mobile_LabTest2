//
//  AppDelegate.swift
//  A2_iOS_Justin_101400171
//
//  Created by Justin Yeh on 2025-03-23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "A2_iOS_Justin_101400171")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func preloadData() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                let products = [
                    (1, "Xbox Series S", "Fourth Generation Xbox", 399.99, "Microsoft"),
                    (2, "Playstation 5", "Sony's latest video game console", 199.99, "Sony"),
                    (3, "Nintendo Switch", "Newest Gaming Console", 650.00, "Nintendo"),
                    (4, "Asus Vivobook", "School Laptop", 445.50, "Asus"),
                    (5, "MacBook Pro", "Great-level Laptop", 500.00, "Apple"),
                    (6, "Samsung Galaxy", "New Samsung Tablet", 750.00, "Samsung"),
                    (7, "Sony Walkman", "Great for listening music", 865.00, "Sony"),
                    (8, "iPhone 16", "Latest iPhone", 250.00, "Apple"),
                    (9, "Street Fighter 6", "New Game Developed on RE Engine", 650.00, "Capcom"),
                    (10, "Panasonic Television", "New TV with great graphics", 400.00, "Panasonic")
                ]
                
                for product in products {
                    let newProduct = Product(context: context)
                    newProduct.productId = Int32(product.0)
                    newProduct.productName = product.1
                    newProduct.productDescription = product.2
                    newProduct.productPrice = product.3
                    newProduct.productProvider = product.4
                }
                try context.save()
            }
        } catch {
            print("Error preloading products: \(error)")
        }
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        preloadData()
        return true
    }
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

