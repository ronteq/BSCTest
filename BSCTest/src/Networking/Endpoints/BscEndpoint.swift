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
    
    case notes
    
    var endpoint: String {
        switch self {
        case .notes: return "/notes"
        }
    }
}


extension BscEndpoint: RequestProvider {
  var urlRequest: URLRequest {
    switch self {
    case .notes:
      guard let url = URL(string: "\(baseURL)\(endpoint)") else { fatalError("Are you sure your endpoints doesn't have a typo?") }
      return URLRequest(url: url)
    }
  }
}
