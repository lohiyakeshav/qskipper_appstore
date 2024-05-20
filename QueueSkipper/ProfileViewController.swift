//
//  ProfileViewController.swift
//  QueueSkipper
//
//  Created by Vinayak Bansal on 20/05/24.
//

import UIKit
    
class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
        
        
        @IBOutlet var profileTableView: UITableView!
        
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.tabBarItem.title = "Profile"
            self.tabBarItem.image = UIImage(systemName: "person.crop.circle")
            self.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            profileTableView.dataSource = self
            profileTableView.delegate = self
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
