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
                    
                    
                    //self.showAlert(message: "Login successful")
                    self.navigateToHomeScreen()
                }
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                self.navigationItem.setHidesBackButton(true, animated: false)
               
                self.navigationController?.navigationBar.isHidden = false
                
            }
            
            
    
    func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: "Restaurants", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "restaurantVC") as! HomeViewController
        let tabVC = UITabBarController()
        tabVC.tabBar.isHidden = false
        navigationController?.pushViewController(viewController, animated: true)
      
    }

            
            func showAlert(message: String) {
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
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
