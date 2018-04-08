//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var geoStringTextField: UITextField!
    @IBOutlet weak var mediaURLTextField: UITextField!
    
    var annotToSend  = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func cancelAddLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationBtn(_ sender: Any) {
        if(geoStringTextField.text != "" && mediaURLTextField.text != ""){
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = geoStringTextField.text
            let localRequest = MKLocalSearch(request: request)
            localRequest.start { (response, error) in
                if error == nil {
                    let coords = response?.boundingRegion.center
                    let annot = MKPointAnnotation()
                    annot.coordinate = coords!
                    self.annotToSend = annot
                    self.performSegue(withIdentifier: "FinalAddLocation", sender: AnyObject.self)
                } else {
                    self.showAlertView(alertMessage: (error?.localizedDescription)!)
                }
            }//End of LocalRequest
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "FinalAddLocation") {
            if let destinationVC = segue.destination as? FinishAddLocationController{
                FinishAddLocationController.studentTosave.latitude = annotToSend.coordinate.latitude
                FinishAddLocationController.studentTosave.longitude = annotToSend.coordinate.longitude
                FinishAddLocationController.studentTosave.mapString = geoStringTextField.text!
                FinishAddLocationController.studentTosave.mediaURL = mediaURLTextField.text!
                destinationVC.annot = annotToSend
            }
            
        }
    }
}
