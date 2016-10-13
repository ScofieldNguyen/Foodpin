//
//  RestaurantTableViewController.swift
//  Foodpin
//
//  Created by Nguyen Vinh Tien on 10/5/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
    var restaurantIsVisited: [Bool] = Array(count: 21, repeatedValue: false)
    var restaurantImageNames = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RestaurantTableViewCell {
        let cellIndentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        // configurate the cell...
        cell.nameLabel.text = restaurantNames[indexPath.row]
//        cell.thumbnailImageView.image = UIImage(named: restaurantImageNames[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .Checkmark : .None
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let imageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.width - 10, cell.frame.height - 10))
        let image = UIImage(named: restaurantImageNames[indexPath.row])
        imageView.image = image
        cell.backgroundView = imageView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do ?", preferredStyle: .ActionSheet)
        // Create action
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let phoneCallHandler = {
            (action: UIAlertAction) -> Void in
                let alertMessage = UIAlertController(title: "Service unavailable", message: "Sorry, the call feture is not available yet. Please call later.", preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
                alertMessage.addAction(okAction)
                self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        let phoneCallAction = UIAlertAction(title: "Call 094328915\(indexPath.row)", style: .Default, handler: phoneCallHandler)
        // Add action to controller
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(phoneCallAction)
        if restaurantIsVisited[indexPath.row] {
            let unvisitedAction = UIAlertAction(title: "I haven't been here", style: .Default, handler: {
                (action: UIAlertAction) -> Void in
                let currentSelectedCell = tableView.cellForRowAtIndexPath(indexPath)
                currentSelectedCell?.accessoryType = .None
                self.restaurantIsVisited[indexPath.row] = false
            })
            optionMenu.addAction(unvisitedAction)
        }else{
            let visitedAction = UIAlertAction(title: "I've been here", style: .Default, handler: {
                (action: UIAlertAction) -> Void in
                let currentSelectedCell = tableView.cellForRowAtIndexPath(indexPath)
                currentSelectedCell?.accessoryType = .Checkmark
                self.restaurantIsVisited[indexPath.row] = true
            })
            optionMenu.addAction(visitedAction)
        }
        // Present
        self.presentViewController(optionMenu, animated: true, completion: nil)
        // Deselect Row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            restaurantNames.removeAtIndex(indexPath.row)
            restaurantTypes.removeAtIndex(indexPath.row)
            restaurantIsVisited.removeAtIndex(indexPath.row)
            restaurantLocations.removeAtIndex(indexPath.row)
            restaurantImageNames.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
