//
//  NoteProviderMock.swift
//  BSCTestTests
//
//  Created by Daniel Fernandez on 2/2/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation
@testable import BSCTest

class NoteProviderMock: NoteProviderProtocol {
    
    enum Mode {
        case success(Any)
        case fail(ApplicationError)
    }
    
    var mode: Mode = Mode.fail(.unknown)
    
    func getNotes(_ completion: @escaping (Result<[Note], ApplicationError>) -> Void) {
        switch mode {
        case .success(let response):
            completion(.success(response as! [Note]))
        case .fail(let error):
            completion(.failure(error))
        }
    }
    
    func createNote(note: Note, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void) {
       
    }
    
    func updateNote(note: Note, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void) {
        
    }
    
    func deleteNote(id: Int, _ completion: @escaping (Result<EmptyObject, ApplicationError>) -> Void) {
        
    }
    
}
