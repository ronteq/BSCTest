//
//  NotesViewModelTests.swift
//  BSCTestTests
//
//  Created by Daniel Fernandez on 2/2/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import XCTest
@testable import BSCTest

class NotesviewModelTests: XCTestCase {

    var sut: NotesViewModel!
    var providerMock: NoteProviderMock!
    var mockData = MockData()
    
    override func setUp() {
        super.setUp()
        providerMock = NoteProviderMock()
        sut = NotesViewModel(noteProvider: providerMock)
    }

    override func tearDown() {
        sut = nil
        providerMock = nil
        super.tearDown()
    }
    
    func testGetNotesWithSuccess() {
        let notes: [Note] = mockData.dataFromJson(fromFileType: .notes)
        providerMock.mode = .success(notes)
        sut.getNotes()
        XCTAssertEqual(sut.notesCount, notes.count)
    }
    
    func testGetNotesWithFailure() {
        let expectedMessage = "Test should fail!"
        providerMock.mode = .fail(.network(expectedMessage))
        
        sut.notesDidLoadWithError = { errorMessage in
            XCTAssertEqual(errorMessage, expectedMessage)
        }
        
        sut.getNotes()
        XCTAssertEqual(sut.notesCount, 0)
    }

}
