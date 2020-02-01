//
//  BscEndpoint.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

enum BscEndpoint {
    var baseURL: String { "https://private-anon-48d21db1ad-note10.apiary-mock.com" }
    
    func getUrlWithEndpoint(_ endpoint: String) -> URL {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            fatalError("Are you sure your endpoints doesn't have a typo?")
        }
        
        return url
    }
    
    case addNote(note: Note)
    case notes
    
    var endpoint: String {
        switch self {
        case .notes,
             .addNote: return "/notes"
        }
    }
    
    var method: String {
        switch self {
        case .notes: return "GET"
        case .addNote: return "POST"
        }
    }
}


extension BscEndpoint: RequestProvider {
  var urlRequest: URLRequest {
    switch self {
    case .notes:
      let url = getUrlWithEndpoint(endpoint)
      return URLRequest(url: url)
        
    case .addNote(let note):
        let url = getUrlWithEndpoint(endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = try! JSONEncoder().encode(note)
        return urlRequest
    }
  }
}
