//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Sultan on 08/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import Foundation
import MapKit

struct StudentInformation {
    var uniqueKey = ""
    var firstName = ""
    var lastName = ""
    var mapString = ""
    var mediaURL = ""
    var longitude = Double()
    var latitude = Double()
    
    init(studentDict : [String:Any]) {
        firstName = "\(studentDict["firstName"] ?? "")"
        lastName = "\(studentDict["lastName"] ?? "")"
        mapString = "\(studentDict["mapString"] ?? "")"
        mediaURL = "\(studentDict["mediaURL"] ?? "")"
        longitude = studentDict["longitude"] as! Double
        latitude = studentDict["latitude"] as! Double
    }
    
    func getAnnotaions() -> MKAnnotation{
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = latitude
        annotation.coordinate.longitude = longitude
        annotation.title = "\(firstName)+\(lastName)"
        annotation.subtitle = mediaURL
        return annotation
    }
}
