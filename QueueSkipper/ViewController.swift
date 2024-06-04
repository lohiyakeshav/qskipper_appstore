//
//
//  ViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 29/04/24.
//
//my comment

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var sliderContainerView: UIView!
    
    
    @IBOutlet var sliderView: UIView!
    
    var initialCenter: CGPoint!
    
    @IBAction func panGestureHandler(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        let sliderWidth = sliderView.frame.width
        let containerWidth = sliderContainerView.frame.width
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let newCenterX = initialCenter.x + translation.x
            if newCenterX >= sliderWidth / 2 && newCenterX <= containerWidth - sliderWidth / 2 {
                sliderView.center.x = newCenterX
            }
        } else if gestureRecognizer.state == .ended {
            if sliderView.frame.maxX > containerWidth * 0.75 {
                unlockAction()
            } else {
                resetSlider()
            }
        }
        
        
    }
    
    private func configureNavigationBarHidden(_ hidden: Bool) {
            navigationController?.setNavigationBarHidden(hidden, animated: false)
        }
        
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
        //configureNavigationBarHidden(true)
            initialCenter = sliderView.center
//        
//        UserDefaults.standard.register(defaults: ["isLoggedIn": false])
//                
//                let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//                
//                if isLoggedIn {
//                    navigateToHomeScreen()
//                } else {
//                    navigateToLoginScreen()
//                }
        
//               UserDefaults.standard.register(defaults: ["isLoggedIn": false])
//               
//               let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//               
//               if isLoggedIn {
//                   let storyboard = UIStoryboard(name: "Restaurants", bundle: nil)
//                   let mainVC = storyboard.instantiateViewController(withIdentifier: "restaurantVC")
//
//                   let navVC = UINavigationController()
//                   navVC.pushViewController(mainVC, animated: true)
//                  
//
//                   //window?.rootViewController = navVC
//               } else {
//                   
//                   let storyboard = UIStoryboard(name: "auth", bundle: nil)
//                   let authVC = storyboard.instantiateViewController(withIdentifier: "authVC")
//                   let navVC = UINavigationController()
//                   navVC.pushViewController(authVC, animated: true)
//                 
//                   //window?.rootViewController = navVC
//                   
//               }
//               
            
           
        
        
        
        
            
            
        }
        
        func resetSlider() {
            UIView.animate(withDuration: 0.3) {
                self.sliderView.center = self.initialCenter
            }
        }
        
        func unlockAction() {
            //configureNavigationBarHidden(true)
            print("Unlocked!")
            self.navigateToLoginScreen()
            
        }
    
    func navigateToHomeScreen() {
           let storyboard = UIStoryboard(name: "Restaurants", bundle: nil)
           let viewController = storyboard.instantiateViewController(withIdentifier: "restaurantVC") as! HomeViewController
           let navVC = UINavigationController(rootViewController: viewController)
           navVC.modalPresentationStyle = .fullScreen
           present(navVC, animated: true, completion: nil)
       }
       
       func navigateToLoginScreen() {
           let storyboard = UIStoryboard(name: "auth", bundle: nil)
           let authVC = storyboard.instantiateViewController(withIdentifier: "authVC")
           let navVC = UINavigationController(rootViewController: authVC)
           navVC.modalPresentationStyle = .fullScreen
           present(navVC, animated: true, completion: nil)
       }
    
    
    func navigateToRestaurantScreen() {
        let storyboard = UIStoryboard(name: "auth", bundle: nil)
               let viewController = storyboard.instantiateViewController(withIdentifier: "authVC") as! LoginViewController
               navigationController?.pushViewController(viewController, animated: true)
               
        //self.navigationController?.pushViewController(viewController, animated: true)
        //show(viewController, sender: nil)
      
//
//        let navVC = UINavigationController()
//        navVC.pushViewController(viewController, animated: true)
    }


    }
