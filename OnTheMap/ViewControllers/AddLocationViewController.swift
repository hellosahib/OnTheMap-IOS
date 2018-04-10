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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var annotToSend  = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geoStringTextField.delegate = self
        mediaURLTextField.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func cancelAddLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationBtn(_ sender: Any) {
        if(geoStringTextField.text != "" && mediaURLTextField.text != ""){
            activityIndicator.startAnimating()
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
                    self.activityIndicator.stopAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                    self.showAlertView(alertMessage: (error?.localizedDescription)!)
                }
            }//End of LocalRequest
        }else {
            showAlertView(alertMessage: "Please Enter Details")
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

extension AddLocationViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}


extension AddLocationViewController : UINavigationControllerDelegate{
    //MARK: ViewHeightAdjustment
    //Adjust Height According To Height Of Keyboard
    
    func subscribeToKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(returnKeyboardBack), name: .UIKeyboardWillHide, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    //This Function Only Works For BottomTextArea
    @objc func keyboardWillShow(_ notification:Notification) {
        if (UIDeviceOrientationIsLandscape(UIDevice.current.orientation)){
            if (mediaURLTextField.isFirstResponder||geoStringTextField.isFirstResponder) {
                view.frame.origin.y -= (getKeyboardHeight(notification)-50)
            }
        }
    }
    @objc func returnKeyboardBack(){
        if (UIDeviceOrientationIsLandscape(UIDevice.current.orientation)){
            if (mediaURLTextField.isFirstResponder||geoStringTextField.isFirstResponder) {
                view.frame.origin.y=0
            }
        }
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
