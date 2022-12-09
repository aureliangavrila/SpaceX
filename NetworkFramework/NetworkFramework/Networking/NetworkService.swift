//
//  NetworkService.swift
//  NetworkingFramework
//
//  Created by Aurelian Gavrila on 14.11.2022.
//

import Foundation

public protocol NetworkServiceProtocol {
    func getCompanyDetails(completionHandler: @escaping (Result<Company, NetworkError>) -> Void)
    func getLaunches(completionHandler: @escaping (Result<[Launch], NetworkError>) -> Void)
}

public enum NetworkError: Error {
    case badURL
    case badResponse
    case invalidData
    case unknown
}

public class NetworkService: NetworkServiceProtocol {
    enum NetworkConstants {
        static let baseURLPath = "https://api.spacexdata.com/"
        static let companyPath = "v4/company"
        static let launchesPath = "v5/launches"
    }

    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    public func getCompanyDetails(completionHandler: @escaping (Result<Company, NetworkError>) -> Void) {
        getItems(url: NetworkConstants.companyPath) { (result: Result<Company, NetworkError>) in
            completionHandler(result)
        }
    }
    
    public func getLaunches(completionHandler: @escaping (Result<[Launch], NetworkError>) -> Void) {
        getItems(url: NetworkConstants.launchesPath) { (result: Result<[Launch], NetworkError>) in
            completionHandler(result)
        }
    }
}

extension NetworkService {
    func getItems<T>(url: String, completionHandler: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        guard let url = URL(string: NetworkConstants.baseURLPath + url) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        self.session.dataTask(with: request) { data, response, error in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(.failure(.unknown))
                return
            }
            
            guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            completionHandler(.success(decodedData))
            
        }.resume()
    }
}

