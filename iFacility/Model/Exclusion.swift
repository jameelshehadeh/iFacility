//
//  Exclusion.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import Foundation

struct Exclusion: Codable {
    let facilityID, optionsID: String

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}
