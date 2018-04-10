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
    
    init() {return}
    init(studentDict : [String:Any]) {
        firstName = "\(studentDict["firstName"] ?? "")"
        lastName = "\(studentDict["lastName"] ?? "")"
        mapString = "\(studentDict["mapString"] ?? "")"
        mediaURL = "\(studentDict["mediaURL"] ?? "")"
        longitude = studentDict["longitude"] as? Double ?? 0
        latitude = studentDict["latitude"] as? Double ?? 0
    }
    
    func getAnnotaions() -> MKPointAnnotation{
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = self.latitude
        annotation.coordinate.longitude = self.longitude
        annotation.title = "\(self.firstName) \(self.lastName)"
        annotation.subtitle = self.mediaURL
        return annotation
    }
    
}
