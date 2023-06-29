//
//  FacilitiesData.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 29/06/2023.
//

import Foundation

struct FacilitiesData: Codable {
    let facilities: [Facility]?
    let exclusions: [[Exclusion]]?
}
