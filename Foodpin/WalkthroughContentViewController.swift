//
//  WalkthroughContentViewController.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 11/19/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var fowardButton: UIButton!
    var index = 0
    var heading = ""
    var content = ""
    var imageFile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Load page's information
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        switch index {
        case 0...1:
            fowardButton.setTitle("NEXT", forState: .Normal)
        case 2:
            fowardButton.setTitle("DONE", forState: .Normal)
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fowardButtonTap(sender: UIButton) {
        switch index {
        case 0...1:
            if let pageViewController = parentViewController as? WalkthroughPageViewController {
                pageViewController.forward(index + 1)
            }
        case 2:
            dismissViewControllerAnimated(true, completion: nil)
        default:
            break
        }
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
