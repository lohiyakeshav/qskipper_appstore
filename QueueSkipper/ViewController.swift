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
            
            
        }
        
        func resetSlider() {
            UIView.animate(withDuration: 0.3) {
                self.sliderView.center = self.initialCenter
            }
        }
        
        func unlockAction() {
            //configureNavigationBarHidden(true)
            print("Unlocked!")
            self.navigateToRestaurantScreen()
            
        }
    
    
    func navigateToRestaurantScreen() {
        let storyboard = UIStoryboard(name: "Restaurants", bundle: nil)
        let storyboard2 = UIStoryboard(name: "Favourites", bundle: nil)
        let storyboard3 = UIStoryboard(name: "MyOrders", bundle: nil)
        let storyboard4 = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "restaurantVC") as! HomeViewController
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
            tabBarController.viewControllers = [viewNavController,favNavVC,orderNavVC,profileNavVC]

        navigationController?.pushViewController(tabBarController, animated: true)
        
//
//        let navVC = UINavigationController()
//        navVC.pushViewController(viewController, animated: true)
    }

    }
