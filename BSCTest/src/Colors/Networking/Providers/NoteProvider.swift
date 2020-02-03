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
    func createNote(note: Note, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void)
    func updateNote(note: Note, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void)
    func deleteNote(id: Int, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void)
}

struct NoteProvider: NoteProviderProtocol {
    
    private let networkManager: Networking
    
    init(networkManager: Networking = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getNotes(_ completion: @escaping (Result<[Note], ApplicationError>) -> Void) {
        networkManager.execute(BscEndpoint.getNotes, completion: completion)
    }
    
    func createNote(note: Note, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void) {
        networkManager.execute(BscEndpoint.addNote(note: note), completion: completion)
    }
    
    func updateNote(note: Note, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void) {
        networkManager.execute(BscEndpoint.updateNote(note: note), completion: completion)
    }
    
    func deleteNote(id: Int, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void) {
        networkManager.execute(BscEndpoint.deleteNote(id: id), completion: completion)
    }
    
}
