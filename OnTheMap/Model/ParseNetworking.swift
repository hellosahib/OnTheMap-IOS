//
//  ParseNetworking.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import Foundation
import MapKit

class ParseNetworking{
    
    func fetchStudentsFromParse(completion:@escaping (_ data:[String:Any]) -> ()){
        var parsedData = [String:Any]()
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt"
        let urlToUse = URL(string: urlString)
        var request = URLRequest(url: urlToUse!)
        request.addValue(NetworkConstant.ParseKeyValue.AppIdValue, forHTTPHeaderField: NetworkConstant.ParseKeys.ApplicationID)
        request.addValue(NetworkConstant.ParseKeyValue.APIKeyValue, forHTTPHeaderField: NetworkConstant.ParseKeys.APIKey)
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    parsedData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                    completion(parsedData)
                }
            }.resume()
        }
    }
    
    func postStudentInfo(studentcoords : MKPointAnnotation,completitionHandler: @escaping (_ data:Data)->()){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"\(FinishAddLocationController.studentTosave.firstName)\", \"lastName\": \"\(FinishAddLocationController.studentTosave.lastName)\",\"mapString\": \"\(FinishAddLocationController.studentTosave.mapString)\", \"mediaURL\": \"\(FinishAddLocationController.studentTosave.mediaURL)\",\"latitude\": \(studentcoords.coordinate.latitude), \"longitude\": \(studentcoords.coordinate.longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle error…
                
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
