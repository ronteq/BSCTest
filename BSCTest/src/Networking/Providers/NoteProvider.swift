//
//  NoteProvider.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

protocol NoteProviderProtocol {
    func getNotes(_ completion: @escaping (Result<[Note], ApplicationError>) -> Void)
}

struct NoteProvider: NoteProviderProtocol {
    
    private let networkManager: Networking
    
    init(networkManager: Networking = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getNotes(_ completion: @escaping (Result<[Note], ApplicationError>) -> Void) {
        networkManager.execute(BscEndpoint.notes, completion: completion)
    }
    
}
