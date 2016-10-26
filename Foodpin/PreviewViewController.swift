//
//  PreviewViewController.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 10/25/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var ratingStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        ratingStackView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.7, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.ratingStackView.transform = CGAffineTransformIdentity
            }, completion: nil)
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
