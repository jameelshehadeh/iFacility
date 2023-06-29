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

struct FacilitiesViewModel  {
    
    private let networkService : NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchFacilities(){
        
        networkService.fetchRequest(endPoint: .getFacilities) { (response: APIResponse<FacilitiesData>) in

            switch response.result {
            case .success(let facilitiesData):
                print(facilitiesData)
            case .failure(let error):
                print(error)
            }
            
        }
    
    }
        
}
    
    



