//
//  ViewController.swift
//  OnTheMap
//
//  Created by Sultan on 06/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    var keyParsed = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInAction(_ sender: Any) {
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(emailTextField.text!)\", \"password\": \"\(passwordTextField.text!)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                self.showAlertView(alertMessage: (error?.localizedDescription)!)
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            var parsedData = [String:Any]()
            parsedData = try! JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String : Any]
            if let newData = parsedData["account"] as? [String:Any]{
                self.keyParsed = newData["key"] as! String
                _ = UdacityNetworking(keyToUse: self.keyParsed)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ToMainScreen", sender: self)
                }
            } else {
                let errorData = parsedData["error"]
                print("Printing Error Data")
                let errorMessage = errorData as! String
                self.showAlertView(alertMessage: errorMessage)
            }
        }
        task.resume()
    }
    
    
}

extension UIViewController{
    func showAlertView(alertMessage : String){
        DispatchQueue.main.async {
            let alertController = UIAlertController()
            alertController.title = "Error"
            alertController.message = alertMessage
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}


