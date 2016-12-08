//
//  RestaurantTableViewController.swift
//  Foodpin
//
//  Created by Nguyen Vinh Tien on 10/5/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var restaurants:[Restaurant] = []
    
    var fetchResultController: NSFetchedResultsController!
    
    var searchController: UISearchController!
    var searchResult: [Restaurant] = []
    
    
    func filterContentForSearchText(searchText: String) {
        searchResult = restaurants.filter({
            (restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            let locationMatch = restaurant.location.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            return (nameMatch != nil || locationMatch != nil)
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Load walkthrough
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .Plain, target: nil, action: nil)
        
        
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search restaurants..."
        
        tableView.tableHeaderView = searchController.searchBar
    
        // Show walkthough cuoi cung
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        
        if hasViewedWalkthrough {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController") as? WalkthroughPageViewController {
            presentViewController(pageViewController, animated: true, completion: nil)
            defaults.setBool(true, forKey: "hasViewedWalkthrough")
        }
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let manageObjecContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: manageObjecContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            } catch {
                print(error)
            }
        }
        
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
        if searchController.active {
            return searchResult.count
        }else {
            return restaurants.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RestaurantTableViewCell {
        let cellIndentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        // configurate the cell...
        let restaurantToDisplay = searchController.active ? searchResult[indexPath.row] : restaurants[indexPath.row]
        cell.nameLabel.text = restaurantToDisplay.name
        cell.locationLabel.text = restaurantToDisplay.location
        cell.typeLabel.text = restaurantToDisplay.type
        cell.accessoryType = restaurantToDisplay.isVisited!.boolValue ? .Checkmark : .None
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let imageView = UIImageView(frame: CGRectMake(10, 10, cell.frame.width - 10, cell.frame.height - 10))
        let image = UIImage(data: restaurants[indexPath.row].image!)
        imageView.image = image
        cell.backgroundView = imageView
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationSource = segue.destinationViewController as! RestaurantDetailViewController
                destinationSource.restaurant = (searchController.active) ? searchResult[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "What do you want to do ?", preferredStyle: .ActionSheet)
//        // Create action
//        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
//        
//        let phoneCallHandler = {
//            (action: UIAlertAction) -> Void in
//                let alertMessage = UIAlertController(title: "Service unavailable", message: "Sorry, the call feture is not available yet. Please call later.", preferredStyle: .Alert)
//                let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
//                alertMessage.addAction(okAction)
//                self.presentViewController(alertMessage, animated: true, completion: nil)
//        }
//        let phoneCallAction = UIAlertAction(title: "Call 094328915\(indexPath.row)", style: .Default, handler: phoneCallHandler)
//        // Add action to controller
//        optionMenu.addAction(cancelAction)
//        optionMenu.addAction(phoneCallAction)
//        if restaurantIsVisited[indexPath.row] {
//            let unvisitedAction = UIAlertAction(title: "I haven't been here", style: .Default, handler: {
//                (action: UIAlertAction) -> Void in
//                let currentSelectedCell = tableView.cellForRowAtIndexPath(indexPath)
//                currentSelectedCell?.accessoryType = .None
//                self.restaurantIsVisited[indexPath.row] = false
//            })
//            optionMenu.addAction(unvisitedAction)
//        }else{
//            let visitedAction = UIAlertAction(title: "I've been here", style: .Default, handler: {
//                (action: UIAlertAction) -> Void in
//                let currentSelectedCell = tableView.cellForRowAtIndexPath(indexPath)
//                currentSelectedCell?.accessoryType = .Checkmark
//                self.restaurantIsVisited[indexPath.row] = true
//            })
//            optionMenu.addAction(visitedAction)
//        }
//        // Present
//        self.presentViewController(optionMenu, animated: true, completion: nil)
//        // Deselect Row
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
////        if editingStyle == .Delete {
////            restaurantNames.removeAtIndex(indexPath.row)
////            restaurantTypes.removeAtIndex(indexPath.row)
////            restaurantIsVisited.removeAtIndex(indexPath.row)
////            restaurantLocations.removeAtIndex(indexPath.row)
////            restaurantImageNames.removeAtIndex(indexPath.row)
////            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
////        }
//    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // Social sharing button
        let shareAction = UITableViewRowAction(style: .Default, title: "Share", handler: {
            (action, indexPath) -> Void in
            let defaultText = "Just checking at " + self.restaurants[indexPath.row].name
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
        })
        // Delete button
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: {
            (action, indexPath) -> Void in
            if let manageObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                manageObjectContext.deleteObject(restaurantToDelete)
                do {
                    try manageObjectContext.save()
                } catch {
                    print(error)
                }
            }
        })
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0,
                                              blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        return [deleteAction, shareAction]
    }


    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return (searchController.active ? false : true)
    }

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
