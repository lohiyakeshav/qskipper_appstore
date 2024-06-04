//
//  LoginViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 01/06/24.
//

import UIKit
import FirebaseAuth





class LoginViewController: UIViewController {
    
    @IBOutlet var emailAddressTextField: UITextField!
    
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let email = emailAddressTextField.text, isValidEmail(email) else {
                    showAlert(message: "Please enter a valid email address.")
                    return
                }
                
                guard let password = passwordTextField.text, isValidPassword(password) else {
                    showAlert(message: "Password must be at least 6 characters long.")
                    return
                }
                
                showLoading(true)
                
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    self.showLoading(false)
                    
                    if let error = error {
                        self.showAlert(message: "Error logging in: \(error.localizedDescription)")
                        return
                    }
                    
                    UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
                    
                    //self.showAlert(message: "Login successful")
                    self.navigateToHomeScreen()
                }
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                //self.navigationItem.setHidesBackButton(true, animated: false)
               self.navigationController?.navigationBar.isHidden = false
                
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

        //navigationController?.pushViewController(tabBarController, animated: true)
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
       //show(tabBarController, sender: self)
        print("Haan bvhai")
    }

            
            func showAlert(message: String) {
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default,handler: { _ in
                    self.navigateToHomeScreen()
                }))
                present(alert, animated: true)
            }
            
            func showLoading(_ show: Bool) {
            }
            
            func isValidEmail(_ email: String) -> Bool {
                return email.contains("@") && email.contains(".")
            }
            
            func isValidPassword(_ password: String) -> Bool {
                return password.count >= 6
            }
    

}
