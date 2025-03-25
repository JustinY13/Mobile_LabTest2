// Justin Yeh
// 101400171

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate {

    // Defined outlets for main page
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productProvider: UILabel!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var products: [Product] = []
    var productsBySearch: [Product] = []
    var mainIndex = 0
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getProducts()
        showProduct()
    }
    
    func getProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let getRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(getRequest)
            productsBySearch = products
        } catch {
            print("Fetching products failed: \(error)")
        }
    }
    
    // If the product does not exist then the message will say "Failed To Fetch Product"
    func showProduct() {
        guard productsBySearch.count > 0 else {
            productName.text = "Failed to Fetch Product"
            productDescription.text = ""
            productPrice.text = ""
            productProvider.text = ""
            previousButton.isEnabled = false
            nextButton.isEnabled = false
            return
        }
        let product = productsBySearch[mainIndex]
        productName.text = product.productName
        productDescription.text = product.productDescription
        productPrice.text = String(product.productPrice)
        productProvider.text = product.productProvider
        
        previousButton.isEnabled = mainIndex > 0
        nextButton.isEnabled = mainIndex < productsBySearch.count - 1
    }
    
    @IBAction func nextProduct(_ sender: UIButton) {
        if mainIndex < productsBySearch.count - 1 {
            mainIndex = mainIndex + 1
            showProduct()
        }
    }
    
    @IBAction func previousProduct(_ sender: UIButton) {
        if mainIndex > 0 {
            mainIndex = mainIndex - 1
            showProduct()
        }
    }
    
    // Added a search bar for the user to search on the product
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            productsBySearch = products
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let getRequest: NSFetchRequest<Product> = Product.fetchRequest()
            
            getRequest.predicate = NSPredicate(format: "productName CONTAINS[c] %@ OR productDescription CONTAINS[c] %@", searchText, searchText)
            do {
                productsBySearch = try context.fetch(getRequest)
            } catch {
                print("Search Result Failed: \(error)")
            }
        }
        mainIndex = 0
        showProduct()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productTable = segue.destination as? ProductTableViewController
        productTable?.products = products
    }
    
    // Called function to update main and list pages with new item added
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts()
        showProduct()
    }
}

