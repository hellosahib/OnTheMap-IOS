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
            ParseNetworking().postStudentInfo(studentcoords: self.annot, completitionHandler: { (data) in
                self.callDismiss()
            })
        }
    }
    func callDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    
}
