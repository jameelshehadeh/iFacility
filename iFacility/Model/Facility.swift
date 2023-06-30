//
//  Facility.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import Foundation

class Facility: Codable {
    
    let facilityID, name: String?
    var options: [Option]?

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
    
}


