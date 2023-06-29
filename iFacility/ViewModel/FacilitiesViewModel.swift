//
//  FacilitiesViewModel.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import Foundation

protocol NetworkService {
    
    func fetchRequest<T: Codable>(endPoint: Endpoint, completion: @escaping (APIResponse<T>) -> Void)
    
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
    
    var selectedOptions : [Option] = []
                                             
    var didUpdateFacilities : ()->() = {}
    
    var didUpdateExclusions : ()->() = {}
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchFacilities(){
        
        networkService.fetchRequest(endPoint: .getFacilities) { (response: APIResponse<FacilitiesData>) in

            switch response.result {
            case .success(let facilitiesData):
                self.facilities = facilitiesData.facilities
                self.exclusions = facilitiesData.exclusions
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func facility(at index: Int) -> Facility {
        facilities[index]
    }
    
    func selectOption(option: Option) {
        
        guard isOptionExcluded(option: option) == false else {return}
        selectedOptions.append(option)
        print(selectedOptions)
    }
    
    func isOptionExcluded(option: Option) -> Bool {
        
        guard selectedOptions.count > 0 else {
            return false
        }
        
        let filteredExclusions = exclusions.filter { exclusions in
            exclusions.contains { $0.optionsID == option.id }
        }
        
        for exclusions in filteredExclusions {
            for ex in exclusions {
                if ex.optionsID != option.id {
                    return selectedOptions.contains { $0.id == ex.optionsID}
                }
            }
        }
        
        return false
        
    }
    
}
    
    



