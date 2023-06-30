//
//  NetworkManager.swift
//  iFacility
//
//  Created by Jameel Shehadeh on 28/06/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
}

struct APIResponse<T: Decodable> {
    let result: Result<T, NetworkError>
}

class NetworkManager : NetworkService {
 
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchRequest<T: Codable>(endPoint: Endpoint ,method: HTTPMethod = .get,completion: @escaping (APIResponse<T>) -> ()) {
        
        guard let url = URL(string: endPoint.url) else {
            completion(APIResponse(result: .failure(.invalidURL)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(APIResponse(result: .failure(.requestFailed(error))))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(APIResponse(result: .failure(.invalidResponse)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(APIResponse(result: .failure(.invalidResponse)))
                return
            }
            
            guard let data = data else {
                completion(APIResponse(result: .failure(.invalidData)))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(APIResponse(result: .success(decodedObject)))
            } catch {
                completion(APIResponse(result: .failure(.invalidData)))
            }
            
        }.resume()
        
    }
 
}
