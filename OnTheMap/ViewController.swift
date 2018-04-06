//
//  ViewController.swift
//  OnTheMap
//
//  Created by Sultan on 06/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudentsFromParse()
    }
    
    
    fileprivate func fetchStudentsFromParse() {
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation"
        let urlToUse = URL(string: urlString)
        var request = URLRequest(url: urlToUse!)
        request.addValue(NetworkConstant.ParseKeyValue.AppIdValue, forHTTPHeaderField: NetworkConstant.ParseKeys.ApplicationID)
        request.addValue(NetworkConstant.ParseKeyValue.APIKeyValue, forHTTPHeaderField: NetworkConstant.ParseKeys.APIKey)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                print(String(data: data!, encoding: .utf8))
            }
            }.resume()
    }
    
}

