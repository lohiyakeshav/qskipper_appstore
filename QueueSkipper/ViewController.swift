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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        
        Task.init {
            do {
                print("Called for menu")
                _ = try await  NetworkUtils.shared.fetchRestaurants()
                print("Called for dusra menu")
             
               
            } catch {
               print("erroe]")
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }


}

