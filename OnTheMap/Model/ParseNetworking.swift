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
    
    func fetchStudentsFromParse(completion:@escaping (_ data:NSArray,_ errorMessage : String) -> ()){
        let prototypeData : NSArray = []
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt"
        let urlToUse = URL(string: urlString)
        var request = URLRequest(url: urlToUse!)
        request.addValue(NetworkConstant.ParseKeyValue.AppIdValue, forHTTPHeaderField: NetworkConstant.ParseKeys.ApplicationID)
        request.addValue(NetworkConstant.ParseKeyValue.APIKeyValue, forHTTPHeaderField: NetworkConstant.ParseKeys.APIKey)
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    let parsedData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                    if let resultsData = parsedData["results"] as? NSArray{
                            completion(resultsData,"")
                    } else {
                        //Error occurs On Client Side Here
                        completion(prototypeData,"API Key/App ID is wrong, Kindly Check")
                    }
                } else {
                    completion(prototypeData,(error?.localizedDescription)!)
                }
            }.resume()
        }
    }
    
    func postStudentInfo(studentcoords : MKPointAnnotation,completitionHandler: @escaping (_ data:Data,_ errorMessage : String)->()){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue(NetworkConstant.ParseKeyValue.AppIdValue, forHTTPHeaderField: NetworkConstant.ParseKeys.ApplicationID)
        request.addValue(NetworkConstant.ParseKeyValue.APIKeyValue, forHTTPHeaderField: NetworkConstant.ParseKeys.APIKey)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"\(FinishAddLocationController.studentTosave.firstName)\", \"lastName\": \"\(FinishAddLocationController.studentTosave.lastName)\",\"mapString\": \"\(FinishAddLocationController.studentTosave.mapString)\", \"mediaURL\": \"\(FinishAddLocationController.studentTosave.mediaURL)\",\"latitude\": \(studentcoords.coordinate.latitude), \"longitude\": \(studentcoords.coordinate.longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                // Handle error…
                completitionHandler(data!,(error?.localizedDescription)!)
                return
            }
            let parsedData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
            if parsedData!["error"] != nil{
                completitionHandler(data!,"API Key/APP ID is wrong , Kindly Check")
            }
            print(parsedData as Any)
        }
        task.resume()
    }
}
