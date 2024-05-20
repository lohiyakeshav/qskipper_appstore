//
//  RestaurantTableViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 16/05/24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    
    var restaurant : [Restaurant] = [
        
        Restaurant(restImage: "big_1", restName: "PR Live Foods", restWaitingTime: 10, cuisine: "North Indian", dish: [Dish(image: "big_2", name: "Samosa", description: "Potato Dish", price: 17, rating: 4.1, foodType: "Veg", favourites: true), Dish(image: "big_3", name: "Bread Pakora", description: "Indian Bread Dish", price: 30, rating: 3.6, foodType: "Veg", favourites: false)], rating: 4.3),
        Restaurant(restImage: "big_2", restName: "Bistro House", restWaitingTime: 10, cuisine: "Fast Food", dish: [Dish(image: "big_3", name: "Pizza", description: "Italian Dish", price: 120, rating: 4.0, foodType: "Veg", favourites: true), Dish(image: "big_1", name: "Omelete", description: "Egg Dish", price: 50, rating: 3.4, foodType: "Non-Veg", favourites: false)], rating: 4.0),
        Restaurant(restImage: "big_3", restName: "Doctor Dosa", restWaitingTime: 10, cuisine: "South Indian", dish: [Dish(image: "big_1", name: "Dosa", description: "South Indian Food", price: 80, rating: 3.9, foodType: "Veg", favourites: true), Dish(image: "big_2", name: "Idli Sambhar", description: "Rice Dish", price: 70, rating: 3.2, foodType: "Veg", favourites: false)], rating: 3.7)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurant.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantListTableViewCell

        let rest = restaurant[indexPath.row]
        cell.update(with: rest)
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    @IBSegueAction func restaurantMenu(_ coder: NSCoder, sender: Any?) -> MenuViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            
            let rest = restaurant[indexPath.row]
            return MenuViewController(coder: coder, restaurant: rest)
        }
        return nil
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
