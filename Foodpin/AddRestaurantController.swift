//
//  AddRestaurantController.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 11/2/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var buttonYes: UIButton!
    @IBOutlet var buttonNo: UIButton!
    @IBOutlet var restaurantNameTextField: UITextField!
    @IBOutlet var restaurantLocationTextField: UITextField!
    @IBOutlet var restaurantTypeTextField: UITextField!
    
    let yesButtonTagValue = 100
    let noButtonTagValue = 200
    var beenHere = true
    
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) || UIImagePickerController.isSourceTypeAvailable(.Camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                
                // Let use choose use photoLibrary or camera
                let sourceOptionMenu = UIAlertController(title: "", message: "Choose your source", preferredStyle: .ActionSheet)
                let sourceFromLibrary = UIAlertAction(title: "Photo Library", style: .Default, handler: {
                    (action: UIAlertAction) -> Void in
                    imagePicker.sourceType = .PhotoLibrary
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                })
                let sourceFromCamera = UIAlertAction(title: "Camera", style: .Default, handler: {
                    (action: UIAlertAction!) -> Void in
                    let alert = UIAlertController(title: "", message: "Sory, camera support will comming soon...", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(ok)
                    self.presentViewController(alert, animated: true, completion: nil)
                })
                let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                
                sourceOptionMenu.addAction(sourceFromLibrary)
                sourceOptionMenu.addAction(sourceFromCamera)
                sourceOptionMenu.addAction(cancel)
                
                self.presentViewController(sourceOptionMenu, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute:
            .Leading, relatedBy: .Equal, toItem:
            imageView.superview, attribute: .Leading, multiplier: 1,
                                 constant: 0)
        leadingConstraint.active = true
        
        
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute:
            NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem:
            imageView.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1,
                                 constant: 0)
        trailingConstraint.active = true
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute:
            NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Top, multiplier: 1, constant:
            0)
        topConstraint.active = true
        
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute:
            NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem:
            imageView.superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1,
                                 constant: 0)
        bottomConstraint.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func switchButtonBackground(sender: UIButton) -> Void {
        switch sender.tag {
        case yesButtonTagValue:
            buttonYes.backgroundColor = UIColor.redColor()
            buttonNo.backgroundColor = UIColor.grayColor()
            beenHere = true
        case noButtonTagValue:
            buttonYes.backgroundColor = UIColor.grayColor()
            buttonNo.backgroundColor = UIColor.redColor()
            beenHere = false
        default:
            break
        }
    }

    @IBAction func validateInfo() -> Void {
        // recieve all informations from text fields and buttons
        let restaurantName = restaurantNameTextField.text
        let restaurantLocation = restaurantLocationTextField.text
        let restaurantType = restaurantTypeTextField.text
        // if something's blank
        if restaurantName == "" || restaurantLocation == "" || restaurantType == "" {
            //  then post an error
            let alert = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all of fields are required", preferredStyle: .Alert)
            let okeAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(okeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            // else show everything on an alert
            let alert = UIAlertController(title: "Restaurant Infor", message: "Name:\(restaurantName) \nType: \(restaurantType) \nLocation: \(restaurantLocation) \nHave you been here: \(beenHere)", preferredStyle: .Alert)
            let okeAction = UIAlertAction(title: "OK", style: .Default, handler: {
                (action: UIAlertAction) -> Void in
                self.performSegueWithIdentifier("unwindToHomeScreen", sender: self)
            })
            alert.addAction(okeAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
