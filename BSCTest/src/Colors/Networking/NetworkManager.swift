//
//  NetworkManager.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

protocol Networking {
    var urlSessionManager: URLSessionManager { get }
    func execute<T: Decodable>(_ endpoint: RequestProvider, completion: @escaping (Result<T, ApplicationError>) -> Void)
}

struct NetworkManager: Networking {
    
    let urlSessionManager: URLSessionManager
    
    init(urlSessionManager: URLSessionManager = URLSession.shared) {
        self.urlSessionManager = urlSessionManager
    }
    
    func execute<T: Decodable>(_ endpoint: RequestProvider, completion: @escaping (Result<T, ApplicationError>) -> Void) {
        let urlRequest = endpoint.urlRequest
        urlSessionManager.dataTask(with: urlRequest) { data, response, error in
            do {
                guard error == nil,
                    let httpResponse = response as? HTTPURLResponse else {
                        return completion(.failure(.unknown))
                }
                
                guard 200 ... 299 ~= httpResponse.statusCode else {
                    let networkError = ApplicationError(fromStatusCode: httpResponse.statusCode)
                    return completion(.failure(networkError))
                }
                
                guard let data = data else { return completion(.failure(.parse)) }
                
                let dataToDecode = data.isEmpty ? "{}".data(using: .utf8) : data
                
                let model = try JSONDecoder().decode(T.self, from: dataToDecode!)
                completion(.success(model))
            } catch {
                completion(.failure(.unknown))
            }
        }.resume()
    }
    
}
