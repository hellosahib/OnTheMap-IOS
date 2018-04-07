//
//  ParseNetworking.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import Foundation

class ParseNetworking{
    
    func fetchStudentsFromParse(completion:@escaping (_ data:[String:Any]) -> ()){
        var parsedData = [String:Any]()
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?limit=10&order=-updatedAt"
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
}
