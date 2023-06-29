//
//  Endpoint.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import Foundation

enum Endpoint : String {

    var baseUrl : String {
        return "https://my-json-server.typicode.com/"
    }
  
    var url : String {
        return self.baseUrl + self.rawValue
    }
        
    case getFacilities = "iranjith4/ad-assignment/db"
    
}
