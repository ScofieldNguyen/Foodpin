//
//  RestaurantDetailViewController.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 10/13/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantDetailTableView: UITableView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantDetailTableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
        restaurantDetailTableView.tableFooterView = UIView(frame: CGRectZero)
        // Setting UINavigationBar
        let navigationBarApperance = UINavigationBar.appearance()
        navigationBarApperance.barTintColor = UIColor(red: 244.0/255.0, green: 137.0/255.0, blue: 141.0/255.0, alpha: 1.0)
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            navigationBarApperance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:barFont]
        }
        navigationBarApperance.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Been there"
            cell.valueLabel.text = restaurant.isVisisted ? "Yes i've been here" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
