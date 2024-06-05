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
        
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileInfoCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath)
//        // Configure your cell here
//        if indexPath.row == 6 {
//            cell.textLabel?.text = "Logout"
//            cell.accessoryType = .disclosureIndicator
//        }
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 6 { // Logout cell tapped
//            // Perform logout action
//            // For example:
//            // UserDefaults.standard.removeObject(forKey: "isLoggedIn")
//            // Navigate back to the login page
//            if let loginViewController = storyboard?.instantiateViewController(withIdentifier: "authVC") as? LoginViewController {
//                navigationController?.pushViewController(loginViewController, animated: true)
//            }
//        }
//    }
}
