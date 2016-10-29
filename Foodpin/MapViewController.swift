//
//  MapViewController.swift
//  Foodpin
//
//  Created by ScofieldNguyen on 10/29/16.
//  Copyright © 2016 ensteintApp. All rights reserved.
//

import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    var restaurant: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.location, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error)
                return
            }
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                let anotation = MKPointAnnotation()
                anotation.title = self.restaurant.name
                anotation.subtitle = self.restaurant.type
                if let location = placemark.location {
                    anotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([anotation], animated: true)
                    self.mapView.selectAnnotation(anotation, animated: true)
                }
            }
        })
        
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        var anotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        if anotationView == nil {
            anotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            anotationView?.canShowCallout = true
        }
        
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(named: restaurant.image)
        anotationView?.leftCalloutAccessoryView = leftIconView
        return anotationView
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
