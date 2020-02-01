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
    
    func getUrlWithEndpoint(_ endpoint: String, id: String? = nil) -> URL {
        let urlString = id == nil ? "\(baseURL)\(endpoint)" : "\(baseURL)\(endpoint)/\(id!)"
        guard let url = URL(string: urlString) else {
            fatalError("Are you sure your endpoints doesn't have a typo?")
        }
        
        return url
    }
    
    case getNotes
    case addNote(note: Note)
    case updateNote(note: Note)
    case deleteNote(id: Int)
    
    var endpoint: String {
        switch self {
        case .getNotes,
             .addNote,
             .updateNote,
             .deleteNote: return "/notes"
        }
    }
    
    var method: String {
        switch self {
        case .getNotes: return "GET"
        case .addNote: return "POST"
        case .updateNote: return "PUT"
        case .deleteNote: return "DELETE"
        }
    }
}


extension BscEndpoint: RequestProvider {
  var urlRequest: URLRequest {
    switch self {
    case .getNotes:
      let url = getUrlWithEndpoint(endpoint)
      return URLRequest(url: url)
        
    case .addNote(let note):
        let url = getUrlWithEndpoint(endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = try! JSONEncoder().encode(note)
        return urlRequest
    
    case .updateNote(let note):
        let url = getUrlWithEndpoint(endpoint, id: "\(note.id)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = try! JSONEncoder().encode(note)
        return urlRequest
        
    case .deleteNote(let id):
        let url = getUrlWithEndpoint(endpoint, id: "\(id)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        return urlRequest
    }
  }
}
