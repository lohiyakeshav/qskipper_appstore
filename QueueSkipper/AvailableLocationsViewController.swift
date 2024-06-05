import UIKit
import MapKit

class AvailableLocationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var locations: [Location] = []
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Register the cell programmatically (if not using storyboard prototype cell)
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let location = locations[indexPath.row]
        cell.textLabel?.text = location.name
        
        
       
        
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath {
                   let previousCell = tableView.cellForRow(at: selectedIndexPath)
                   previousCell?.accessoryType = .none
               }

               let currentCell = tableView.cellForRow(at: indexPath)
               currentCell?.accessoryType = .checkmark

               selectedIndexPath = indexPath

               tableView.deselectRow(at: indexPath, animated: true)
           
               let selectedLocation = locations[indexPath.row]
               if selectedLocation.name == "Galgotias University" {
                   navigateToHomeScreen()
               } else {
                   showAlert(message: "We are coming soon!")
               }
           }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    func navigateToHomeScreen() {
        print("keshav")
        let storyboard1 = UIStoryboard(name: "Restaurants", bundle: nil)
        let viewController = storyboard1.instantiateViewController(withIdentifier: "restaurantVC") as! HomeViewController
        
        let storyboard2 = UIStoryboard(name: "Favourites", bundle: nil)
        let storyboard3 = UIStoryboard(name: "MyOrders", bundle: nil)
        let storyboard4 = UIStoryboard(name: "Profile", bundle: nil)
        print("vinayak")
        let favVC = storyboard2.instantiateViewController(withIdentifier: "favouriteVC") as! FavouritesViewController
        let orderVC = storyboard3.instantiateViewController(withIdentifier: "myOrdersVC") as! MyOrdersTableViewController
        let profileVC = storyboard4.instantiateViewController(withIdentifier: "profileVC") as! ProfileTableViewController
        
        let viewNavController = UINavigationController(rootViewController: viewController)
        let favNavVC = UINavigationController(rootViewController: favVC)
        let orderNavVC = UINavigationController(rootViewController: orderVC)
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        
        viewNavController.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "list.bullet"), tag: 0)
        favNavVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        orderNavVC.tabBarItem = UITabBarItem(title: "My Orders", image: UIImage(systemName: "bag"), selectedImage: UIImage(systemName: "bag.fill"))
        profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [viewNavController, favNavVC, orderNavVC, profileNavVC]
        //tabBarController.tabBarItem.standardAppearance?.selectionIndicatorTintColor = .systemGreen
        tabBarController.tabBar.tintColor = .systemGreen
        //navigationController?.pushViewController(tabBarController, animated: true)
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
       //show(tabBarController, sender: self)
        print("Haan bvhai")
    }
}
