//
//  ViewController.swift
//  LocationNetwork
//
//  Created by student on 17/4/17.
//  Copyright © 2017 ISS. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate  {

    @IBOutlet weak var textView: UITextView!
    
    var locationManager:CLLocationManager!
    var noUpdates:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy =
        kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last?.description as String!
        displayLocation(lastLocation!);
        noUpdates+=1;  // increment by 1
        print (noUpdates)
        if (noUpdates > 50) {
            locationManager.stopUpdatingLocation(); }
    }
    func displayLocation (_ locationDesc : String) { var newMessage:String = "Update " +
        String(noUpdates) + "\n";
        newMessage += locationDesc;
        textView.text = newMessage + "\n" +
            textView.text;
        print("locations = \(locationDesc)") }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    // println("Could not locate location : %@",error)
    print("Could not locate location : \(error)")
        } 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

