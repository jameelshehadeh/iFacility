//
//  FacilitiesViewModel.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import Foundation

protocol NetworkService {
    
    func fetchRequest<T: Codable>(endPoint: Endpoint,method: HTTPMethod, completion: @escaping (APIResponse<T>) -> Void)
    
}

class FacilitiesViewModel  {
    
    private let networkService : NetworkService
    
    private var facilities = [Facility](){
        didSet {
            didUpdateFacilities()
        }
    }
    
    var numberOfFacilities: Int {
        return facilities.count
    }
    
    private var exclusions = [[Exclusion]]()
    
    var selectedOptions : [String:Option] = [:]
    
    var didUpdateFacilities : ()->() = {}
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchFacilities(){
        
        networkService.fetchRequest(endPoint: .getFacilities,method: .get) { (response: APIResponse<FacilitiesData>) in

            switch response.result {
            case .success(let facilitiesData):
                self.facilities = facilitiesData.facilities ?? []
                self.facilities.forEach { fac in
                    fac.options?.forEach({ option in
                        option.isSelected = false
                    })
                }
                self.exclusions = facilitiesData.exclusions ?? []
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func facility(at index: Int) -> Facility {
        facilities[index]
    }
    
    
    func selectOption(option: Option,facilityId: String)  {
        
        guard isOptionExcluded(option: option,facilityId: facilityId) == false else
        {return}
    
        selectedOptions.removeValue(forKey: facilityId)
        selectedOptions[facilityId] = option
        
    }
        
    
    func isOptionExcluded(option: Option,facilityId: String) -> Bool {
        
        guard selectedOptions.count > 0 , let selectedOptionId = option.id else {
            return false
        }
        
        let selectedOptionIDs = selectedOptions.values.compactMap { $0.id }
        
        let filteredExclusions = exclusions.filter { exclusions in
            exclusions.contains { $0.optionsID == selectedOptionId }
        }
        
        let filteredExcludedIds = filteredExclusions.map { exclusion in
            exclusion.filter { $0.optionsID != selectedOptionId }
        }.compactMap { exclusions in
            exclusions.compactMap { $0.optionsID }
        }
        
        if selectedOptionIDs.allSatisfy({ id in
            filteredExcludedIds.allSatisfy { $0.contains { $0 != id}}
        }) {
            option.isSelected?.toggle()
            return false
        }
        else {
            selectedOptions[facilityId] = nil
            return true
        }
    }
    
}
