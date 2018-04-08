//
//  UdacityNetworking.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import Foundation
class UdacityNetworking {
    static var AccountKey = String()
    
    init() {return}
    
    init(keyToUse : String) {
        UdacityNetworking.AccountKey = keyToUse
    }
    
    func returnAccountKey() -> String{
        return UdacityNetworking.AccountKey
    }
    
    func getUserName(completitionHandler : @escaping (_ fullname : String,_ lastname : String) -> ()){
        let request = URLRequest(url: URL(string: "https://www.udacity.com/api/users/\(UdacityNetworking.AccountKey)")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                print(error?.localizedDescription ?? "")
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            let parsedData = try? JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as! [String:Any]
            let userData = parsedData!["user"] as? [String:Any]
            let lname = userData!["last_name"] as! String
            let fname = userData!["first_name"] as! String
            completitionHandler(fname,lname)
        }
        task.resume()
    }
    
    func logOutUser(completitionHandler: @escaping (_ data : Data) -> ()){
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            completitionHandler(newData!)
        }
        task.resume()
    }
    
}
