//
//  UrlSessionManagerMock.swift
//  BSCTestTests
//
//  Created by Daniel Fernandez on 2/2/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation
@testable import BSCTest

class URLSessionManagerMock: URLSessionManager {
    
    private var data: Data?
    private var response: URLResponse?
    private var error: Error?
    
    func setData(_ data: Data) {
        self.data = data
    }
    
    func setResponse(_ response: URLResponse) {
        self.response = response
    }
    
    func setError(_ error: Error) {
        self.error = error
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return URLSession.shared.dataTask(with: request)
    }
    
}
