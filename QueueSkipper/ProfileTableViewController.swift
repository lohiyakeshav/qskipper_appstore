//
//  ProfileTableViewController.swift
//  QueueSkipper
//
//  Created by Vinayak Bansal on 20/05/24.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        self.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileInfoCell")
        
        if let currentUser = UserController.shared.getCurrentUser() {
            print(currentUser.userName)
            self.navigationItem.title = "Hello, \(String(describing: currentUser.userName))"
                }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Profile Information"
                cell.imageView?.image = UIImage(systemName: "info")
                cell.accessoryType = .disclosureIndicator
            case 1:
                cell.textLabel?.text = "My Orders"
                cell.imageView?.image = UIImage(systemName: "cart")
                cell.accessoryType = .disclosureIndicator
            case 2:
                cell.textLabel?.text = "Notifications"
                cell.imageView?.image = UIImage(systemName: "bell.badge")
                cell.accessoryType = .disclosureIndicator 
            case 3:
                cell.textLabel?.text = "Referral"
                cell.imageView?.image = UIImage(systemName: "square.and.arrow.up")
                cell.accessoryType = .disclosureIndicator
            case 4:
                cell.textLabel?.text = "FAQs"
                cell.imageView?.image = UIImage(systemName: "magnifyingglass")
                cell.accessoryType = .disclosureIndicator
            case 5:
                cell.textLabel?.text = "Help"
                cell.imageView?.image = UIImage(systemName: "questionmark.circle")
                cell.accessoryType = .disclosureIndicator
            case 6:
                cell.textLabel?.text = "Logout"
                cell.imageView?.image = UIImage(systemName: "power")
                cell.accessoryType = .disclosureIndicator
            default:
                cell.textLabel?.text = "Profile Item \(indexPath.row + 1)"
                cell.imageView?.image = nil
                cell.accessoryType = .none
            }
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            
            func navigateToOrderScreen() {
                let storyboard = UIStoryboard(name: "MyOrders", bundle: nil)
                let authVC = storyboard.instantiateViewController(withIdentifier: "myOrdersVC")
                let navVC = UINavigationController(rootViewController: authVC)
                navVC.modalPresentationStyle = .popover
                present(navVC, animated: true, completion: nil)
            }
//            func navigateToOrderScreen() {
//                
//                let storyboard1 = UIStoryboard(name: "MyOrders", bundle: nil)
//                let viewController = storyboard1.instantiateViewController(withIdentifier: "myOrdersVC") as! MyOrdersTableViewController
//                
//                let storyboard2 = UIStoryboard(name: "Favourites", bundle: nil)
//                let storyboard3 = UIStoryboard(name: "MyOrders", bundle: nil)
//                let storyboard4 = UIStoryboard(name: "Profile", bundle: nil)
//                print("vinayak")
//                let favVC = storyboard2.instantiateViewController(withIdentifier: "favouriteVC") as! FavouritesViewController
//                let orderVC = storyboard3.instantiateViewController(withIdentifier: "myOrdersVC") as! MyOrdersTableViewController
//                let profileVC = storyboard4.instantiateViewController(withIdentifier: "profileVC") as! ProfileTableViewController
//                
//                let viewNavController = UINavigationController(rootViewController: viewController)
//                let favNavVC = UINavigationController(rootViewController: favVC)
//                let orderNavVC = UINavigationController(rootViewController: orderVC)
//                let profileNavVC = UINavigationController(rootViewController: profileVC)
//                
//                viewNavController.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "list.bullet"), tag: 0)
//                favNavVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
//                orderNavVC.tabBarItem = UITabBarItem(title: "My Orders", image: UIImage(systemName: "bag"), selectedImage: UIImage(systemName: "bag.fill"))
//                profileNavVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
//                
//                let tabBarController = UITabBarController()
//                tabBarController.viewControllers = [viewNavController, favNavVC, orderNavVC, profileNavVC]
//                //tabBarController.tabBarItem.standardAppearance?.selectionIndicatorTintColor = .systemGreen
//                tabBarController.tabBar.tintColor = .systemGreen
//                //navigationController?.pushViewController(tabBarController, animated: true)
//                tabBarController.modalPresentationStyle = .fullScreen
//                present(tabBarController, animated: true)
//               //show(tabBarController, sender: self)
//                print("Haan bvhai")
                
//                
//                
//                let storyboard = UIStoryboard(name: "MyOrders", bundle: nil)
//                let authVC = storyboard.instantiateViewController(withIdentifier: "myOrdersVC")
//                let navVC = UINavigationController(rootViewController: authVC)
//                navVC.modalPresentationStyle = .popover
//                present(navVC, animated: true, completion: nil)
            //}
            navigateToOrderScreen()
            
//                let storyboard = UIStoryboard(name: "MyOrders", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "myOrdersVC") as! MyOrdersTableViewController
//            navigationController?.isNavigationBarHidden = false
//                
//            viewController.modalPresentationStyle = .fullScreen
//            present(viewController, animated: true)
            
        }
        if indexPath.row == 6 {
                UserController.shared.logoutUser()
            
            func navigateToLoginScreen() {
                let storyboard = UIStoryboard(name: "auth", bundle: nil)
                let authVC = storyboard.instantiateViewController(withIdentifier: "authVC")
                let navVC = UINavigationController(rootViewController: authVC)
                navVC.modalPresentationStyle = .fullScreen
                present(navVC, animated: true, completion: nil)
            }
            navigateToLoginScreen()
            
//                let storyboard = UIStoryboard(name: "auth", bundle: nil)
//                let viewController = storyboard.instantiateViewController(withIdentifier: "authVC") as! LoginViewController
//                
//                viewController.modalPresentationStyle = .fullScreen
//                present(viewController, animated: true)
//                
//            
        }
    }
}
