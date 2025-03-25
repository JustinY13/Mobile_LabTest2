

import UIKit

class ProductTableViewController: UITableViewController {
    
    var products: [Product]?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }

    // function for creating tableview to view all products in the database
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        if let products = products {
            let product = products[indexPath.row]
            cell.textLabel?.text = product.productName ?? "no product name"
            cell.detailTextLabel?.text = product.productDescription ?? "no product description"
        }
        return cell
    }
}
