//
//  APIManager.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import Foundation

enum BHError : Error {
    case noInternet
    case invalidURL
    case authenticationFailed
    case invalidResponse(Int?)
    case noDataFound
    case invalidData
    case networkError(Error?, Int?)
} // Custom Error cases for Error Handling

final class APIManager {
    
    static var shared : APIManager = APIManager()
    
    func getPhotos<T:Codable>(endpoint : String, completionHandler: @escaping (Result<[T], BHError>) -> Void) {
        
        let urlString = "\(BASEURL)"+"\(endpoint)"
        
        let url = URL.init(string: urlString)
        
        guard url != nil else {
            completionHandler(.failure(BHError.invalidURL))
            return
        }
        
        let request = URLRequest.init(url: url!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(.failure(BHError.networkError(error, (response as! HTTPURLResponse).statusCode)))
                return
            }
            
            guard let serverResponse =  response as? HTTPURLResponse, 200...299 ~= serverResponse.statusCode else {
                completionHandler(.failure(BHError.invalidResponse((response as! HTTPURLResponse).statusCode)))
                return
            }
            
            guard data != nil else {
                completionHandler(.failure(BHError.noDataFound))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let photos = try jsonDecoder.decode([T].self, from: data!)
                print(photos.count)
                completionHandler(.success(photos))
            }
            catch {
                completionHandler(.failure(BHError.invalidData))
            }
        }
        .resume()
    }
}
