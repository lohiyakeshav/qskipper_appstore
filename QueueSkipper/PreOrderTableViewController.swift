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

}
