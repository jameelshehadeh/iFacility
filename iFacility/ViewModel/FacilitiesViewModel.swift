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
    
    var didUpdateFacilities : ()->() = {}
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchFacilities(){
        
        networkService.fetchRequest(endPoint: .getFacilities) { (response: APIResponse<FacilitiesData>) in

            switch response.result {
            case .success(let facilitiesData):
                self.facilities = facilitiesData.facilities
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func facility(at index: Int) -> Facility {
        facilities[index]
    }
    
}
    
    



