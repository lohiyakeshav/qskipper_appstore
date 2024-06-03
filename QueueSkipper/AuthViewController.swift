//
//  AuthViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 01/06/24.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class AuthViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var emailAddressTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        
        guard let username = userNameTextField.text, !username.isEmpty else {
                    showAlert(message: "Username cannot be empty.")
                    return
                }
                
                guard let email = emailAddressTextField.text, isValidEmail(email) else {
                    showAlert(message: "Please enter a valid email address.")
                    return
                }
                
                guard let password = passwordTextField.text, isValidPassword(password) else {
                    showAlert(message: "Password must be at least 6 characters long.")
                    return
                }
                
                //showLoading(true)
                
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    self.showLoading(false)
                    
                    if let error = error {
                        self.showAlert(message: "Error creating user: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = authResult?.user.uid else {
                        self.showAlert(message: "Unable to get user ID")
                        return
                    }

                    let usersRef = Database.database().reference().child("Users")
                    let userData = ["username": username, "email": email]
                    let userRef = usersRef.child(uid)
                    userRef.setValue(userData) { error, _ in
                        if let error = error {
                            self.showAlert(message: "Error updating user data: \(error.localizedDescription)")
                        } else {
                            //self.showAlert(message: "Account Created successfully")
                            let user = User(emailAddress: email, password: password)
                            UserController.shared.registerUser(user: user)
                            self.navigateToHomeScreen()
                            
                        }
                    }
                }
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
            }
            
    func navigateToHomeScreen() {
            print("navigateToHomeScreen called")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = (storyboard.instantiateViewController(withIdentifier: "mainVC") as! ViewController)
                    //viewController.modalPresentationStyle = .fullScreen
//                    self.present(viewController, animated: true, completion: nil)
                    print ("haha2")
                    present(viewController, animated: true)
//            if let viewController = storyboard.instantiateViewController(withIdentifier: "mainVC") as? ViewController {
//                print("ViewController instantiated")
//             //   viewController.modalPresentationStyle = .fullScreen
//                navigationController?.pushViewController(viewController, animated: true)
//            } else {
//                print("Failed to instantiate ViewController")
//            }
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
