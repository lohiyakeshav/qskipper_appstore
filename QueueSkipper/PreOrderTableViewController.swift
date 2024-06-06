//
//  PreOrderTableViewController.swift
//  QueueSkipper
//
//  Created by Vinayak Bansal on 27/05/24.
//

import UIKit

class PreOrderTableViewController: UITableViewController {
    
    @IBOutlet var scheduleDateLabel: UILabel!
    @IBOutlet var scheduleDatePicker: UIDatePicker!
    
    //var isDatePickerHidden = true
    
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 2, section: 1)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let today = Date()
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
            let tomorrowMidnight = Calendar.current.startOfDay(for: tomorrow)
                .addingTimeInterval(86399)
            
            scheduleDatePicker.minimumDate = today
            scheduleDatePicker.maximumDate = tomorrowMidnight
            
            scheduleDatePicker.date = today
            
            updateDueDateLabel(date: today)
        }
    
    func updateDueDateLabel(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, hh:mm a"
        let dateString = dateFormatter.string(from: date)
        scheduleDateLabel.text = dateString
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return nil
        }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
//        performSegue(withIdentifier: "unwindToMyCart", sender: self)
        
    }
    
    
        

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
