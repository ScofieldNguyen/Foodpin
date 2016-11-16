//
//  PreviewViewController.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 10/25/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    let dislikeTagValue = 100
    let goodTagValue = 200
    let greatTagValue = 300
    var rate: String?
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var dislikeButton: UIButton!
    @IBOutlet var goodButton: UIButton!
    @IBOutlet var greatButton: UIButton!
    @IBAction func determineRatingSelected(senderButton: UIButton) -> Void {
        switch senderButton.tag {
        case dislikeTagValue:
            rate = "dislike"
        case goodTagValue:
            rate = "good"
        case greatTagValue:
            rate = "great"
        default:
            break
        }
        performSegueWithIdentifier("backToDetailView", sender: senderButton)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        let scaleToZeroTransform = CGAffineTransformMakeScale(0.0, 0.0)
        let movingOutTransform = CGAffineTransformMakeTranslation(0.0, 500.0)
        let transform = CGAffineTransformConcat(scaleToZeroTransform, movingOutTransform)
        dislikeButton.transform = transform
        goodButton.transform = transform
        greatButton.transform = transform
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.dislikeButton.transform = CGAffineTransformIdentity
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.goodButton.transform = CGAffineTransformIdentity
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                self.greatButton.transform = CGAffineTransformIdentity
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
