//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Sultan on 06/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var keyParsed = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        subscribeToKeyboardNotification();
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func logInAction(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UdacityNetworking().logInUser(emailText: emailTextField.text!, passwordText: passwordTextField.text!) { (accountKey,errorMessage) in
            if (errorMessage == ""){
                _ = UdacityNetworking(keyToUse: accountKey)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "ToMainScreen", sender: self)
                }
            } else {
                DispatchQueue.main.async {
                  self.activityIndicator.stopAnimating()
                }
                self.showAlertView(alertMessage: errorMessage)
            }
        }
    }
    //Ends Here
}

extension UIViewController{
    func showAlertView(alertMessage : String){
        DispatchQueue.main.async {
            let alertController = UIAlertController()
            alertController.title = "Error"
            alertController.message = alertMessage
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                //self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

extension LoginViewController : UINavigationControllerDelegate{
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
        if (passwordTextField.isFirstResponder||emailTextField.isFirstResponder) {
            view.frame.origin.y -= (getKeyboardHeight(notification) - 100)
        }
    }
    @objc func returnKeyboardBack(){
        if (passwordTextField.isFirstResponder||emailTextField.isFirstResponder) {
            view.frame.origin.y=0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}


