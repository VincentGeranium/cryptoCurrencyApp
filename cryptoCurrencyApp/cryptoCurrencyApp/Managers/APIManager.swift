//
//  APIManager.swift
//  cryptoCurrencyApp
//
//  Created by Kwangjun Kim on 2022/04/22.
//

import Foundation
import UIKit

final class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
}

// MARK: - Public
extension APIManager {
    public func filterAsset(for assetID: String, completion: @escaping (Result<[FilterAssetResponse], Error>) -> Void) {
        let url = url(for: .asset, queryParams: ["filter_asset_id": assetID])
        
        request(url: url, expecting: [FilterAssetResponse].self, completion: completion)
    }
    
}

// MARK: - Private
private extension APIManager {
    private struct Constants {
        static let baseURL: String = "https://rest.coinapi.io/v1"
        static let apiKey: String = "89734974-A5B3-4AAC-BD41-8E6E9D953099"
        static let day: TimeInterval = 3600 * 24
    }
    
    private enum EndPoint: String {
        case asset = "/assets"
        
    }
    
    private enum APIError: String, Error {
        case badRequest = "404 Bad Request -- There is something wrong with your request"
        case unauthorized = "401 Unauthorized -- Your API key is wrong"
        case forbidden = "403 Forbidden -- Your API key doesnt't have enough privileges to access this resource"
        case tooManyRequests = "429 Too many requests -- You have exceeded your API key rate limitsv"
        case noData = "550 No data -- You requested specific single item that we don't have at this moment."
        case unknownError
        case requestTimeOut
    }
    
    private func url(for endPoint: EndPoint, queryParams: [String: String] = [:]) -> URL? {
        var urlString = Constants.baseURL + endPoint.rawValue
        var queryItems: [URLQueryItem] = []
        // Add any parameters
        for (name, value) in queryParams {
            queryItems.append(.init(name: name, value: value))
        }
        
        // Convert query items to suffix string
        let queryString = queryItems.map {"\($0.name)=\($0.value ?? APIError.noData.rawValue)"}.joined()
        
        urlString += "?" + queryString
        
        print("\n\(urlString)\n")
        
        let returnURL = URL(string: urlString)
        
        return returnURL
    }
    
    private func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void )
    {
        guard let url = url else {
            completion(.failure(APIError.badRequest))
            return
        }
        
        // MARK: - Add api token in header and url
        // Add api token in the header
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("89734974-A5B3-4AAC-BD41-8E6E9D953099", forHTTPHeaderField: "X-CoinAPI-Key")
        request.setValue("deflate, gzip", forHTTPHeaderField: "Accept-Encoding")
        request.timeoutInterval = 60.0
        
        if request.timeoutInterval < 60.0 {
            print(APIError.requestTimeOut.rawValue)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data , response, error in
            guard let data = data else {
                return
            }
            
            guard error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.unauthorized))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

