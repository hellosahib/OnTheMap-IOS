//
//  NetworkingConstants.swift
//  OnTheMap
//
//  Created by Sultan on 07/04/18.
//  Copyright © 2018 Sultan. All rights reserved.
//

import Foundation

struct NetworkConstant {
    struct StudentResponse {
        static let objectID = "objectId"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    struct ParseKeys {
        static let ApplicationID = "X-Parse-Application-Id"
        static let APIKey = "X-Parse-REST-API-Key"
    }
    struct ParseKeyValue {
        static let AppIdValue = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKeyValue = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
}
