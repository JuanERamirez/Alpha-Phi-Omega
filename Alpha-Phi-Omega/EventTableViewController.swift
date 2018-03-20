//
//  EventTableViewController.swift
//  Alpha-Phi-Omega
//
//  Created by CheckoutUser on 3/19/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit
import os.log

class EventTableViewController: UITableViewController {
    
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleEvents()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadSampleEvents() {
        let photo1 = UIImage(named: "ServicePin")
        let photo2 = UIImage(named: "apo-hq")
        let photo3 = UIImage(named: "avatar2")
        
        guard let event1 = Event(name: "Krispy Kreme Fundraiser", date: "03/19/2018", time: "11:00AM", location: "Dexter Lawn - Cal Poly", summary: "Sell donuts", photo: photo1) else {
            fatalError("Unable to instantiate event1")
        }
        
        guard let event2 = Event(name: "Event 2", date: "03/22/2018", time: "12:00PM", location: "TBD", summary: "TBA", photo: photo2) else {
            fatalError("Unable to instantiate event2")
        }
        
        guard let event3 = Event(name: "Easter Estravaganza", date: "03/31/2018", time: "8:00AM", location: "Dinosaur Caves Park, Pismo Beach, CA", summary: "Help setup for children's easter event.", photo: photo3) else {
            fatalError("Unable to instantiate event3")
        }
        
        events += [event1, event2, event3]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }
        
        let event = events[indexPath.row]

        cell.eventNameLabel.text = event.name
        cell.eventImageView.image = event.photo
        cell.eventLocationLabel.text = event.location
        cell.eventSummaryLabel.text = event.summary
        cell.eventDateLabel.text = event.date

        return cell
    }
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {

        if let sourceViewController = sender.source as? EventsViewController, let event = sourceViewController.event {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                events[selectedIndexPath.row] = event
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: events.count, section: 0)
                events.append(event)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddEvent":
                os_log("Adding a new event.", log: OSLog.default, type: .debug)
            case "ShowDetail":
                guard let eventDetailViewController = segue.destination as? EventsViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedEventCell = sender as? EventTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                fatalError("The selected cell is not being displayed by the table.")
                }
                let selectedEvent = events[indexPath.row]
                eventDetailViewController.event = selectedEvent
            default:
                fatalError("Unexpected segue identifier: \(String(describing: segue.identifier))")
            
        }
    }
 

}
