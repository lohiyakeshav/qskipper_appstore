//
//  MyOrdersViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 16/05/24.
//

import UIKit

class MyOrdersViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "My Orders"
        self.tabBarItem.image = UIImage(systemName: "bag")
        self.tabBarItem.selectedImage = UIImage(systemName: "bag.fill")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
