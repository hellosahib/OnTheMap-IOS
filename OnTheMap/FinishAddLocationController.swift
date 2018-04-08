//
//  FinishAddLocationController.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit
import MapKit

class FinishAddLocationController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var annot = MKPointAnnotation()
    static var studentTosave = StudentInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: annot.coordinate.latitude, longitude: annot.coordinate.longitude), MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        mapView.addAnnotation(annot)
        
    }
    
    @IBAction func finishBtn(_ sender: Any) {
        UdacityNetworking().getUserName { (fname, lname) in
            FinishAddLocationController.studentTosave.firstName = fname
            FinishAddLocationController.studentTosave.lastName = lname
            var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
             request.httpMethod = "POST"
             request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
             request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"\(FinishAddLocationController.studentTosave.firstName)\", \"lastName\": \"\(FinishAddLocationController.studentTosave.lastName)\",\"mapString\": \"\(FinishAddLocationController.studentTosave.mapString)\", \"mediaURL\": \"\(FinishAddLocationController.studentTosave.mediaURL)\",\"latitude\": \(self.annot.coordinate.latitude), \"longitude\": \(self.annot.coordinate.longitude)}".data(using: .utf8)
             let session = URLSession.shared
             let task = session.dataTask(with: request) { data, response, error in
             if error != nil {
             // Handle error…
             print(error?.localizedDescription as Any)
             return
             }
             print(String(data: data!, encoding: .utf8)!)
             }
             task.resume()
        }
        
        
    }
    
    
}
