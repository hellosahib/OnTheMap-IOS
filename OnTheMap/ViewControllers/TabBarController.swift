//
//  TabBarController.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func reloadData(_ sender: Any) {
        StudentDataSource.sharedInstance.studentData.removeAll()
        ParseNetworking().fetchStudentsFromParse { (data,errorMessage)  in
            if errorMessage == ""{
                let resultsData = data["results"] as! NSArray
                for key in resultsData{
                    StudentDataSource.sharedInstance.studentData.append(StudentInformation(studentDict: key as! [String:Any]))
                }
            } else {
                self.showAlertView(alertMessage: errorMessage)
            }
    }
}
    
    
    @IBAction func logoutSession(_ sender: Any) {
        UdacityNetworking().logOutUser { (data) in
            print(String(data: data, encoding: .utf8))
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    


}
