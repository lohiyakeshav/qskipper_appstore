//
//  LoginViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 01/06/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        
        guard let email = emailAddressTextField.text, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }
        
        guard let password = passwordTextField.text, isValidPassword(password) else {
            showAlert(message: "Password must be at least 6 characters long.")
            return
        }
        
        showLoading(true)
        
        Task {
            do {
                let (username, userId) = try await NetworkUtils.shared.loginUser(email: email)
                let user = User(userId: userId, userName: username, emailAddress: email, password: password)
                
                UserController.shared.loginUser(user: user)
                navigateToHomeScreen()
            } catch {
                showLoading(false)
                showAlert(message: "Login failed: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
     
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func navigateToHomeScreen() {
        let storyboard1 = UIStoryboard(name: "Restaurants", bundle: nil)
        let viewController = storyboard1.instantiateViewController(withIdentifier: "restaurantVC") as! HomeViewController
        
        let storyboard2 = UIStoryboard(name: "Favourites", bundle: nil)
        let storyboard3 = UIStoryboard(name: "MyOrders", bundle: nil)
        let storyboard4 = UIStoryboard(name: "Profile", bundle: nil)
        
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
        tabBarController.tabBar.tintColor = .systemGreen
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showLoading(_ show: Bool) {
        // Implement loading indicator logic if needed
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
