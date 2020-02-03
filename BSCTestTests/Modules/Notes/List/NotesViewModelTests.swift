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
    
    func testGetNoteCellViewModel() {
        let notes: [Note] = mockData.dataFromJson(fromFileType: .notes)
        providerMock.mode = .success(notes)
        sut.getNotes()
        
        let firstNoteIndex = IndexPath(row: 0, section: 0)
        let noteCellViewModel = sut.getNoteCellViewModel(at: firstNoteIndex)
        XCTAssertEqual(noteCellViewModel.noteTitle, notes[firstNoteIndex.row].title)
    }
    
    func testGetNote() {
        let notes: [Note] = mockData.dataFromJson(fromFileType: .notes)
        providerMock.mode = .success(notes)
        sut.getNotes()
        
        let firstNoteIndex = IndexPath(row: 0, section: 0)
        let note = sut.getNote(at: firstNoteIndex)
        XCTAssertEqual(note.title, notes[firstNoteIndex.row].title)
    }
    
    func testDeleteNote() {
        let notes: [Note] = mockData.dataFromJson(fromFileType: .notes)
        providerMock.mode = .success(notes)
        sut.getNotes()
        
        XCTAssertEqual(sut.notesCount, 6)
        
        sut.deleteNote(notes.first!)
        sut.deleteNote(notes.last!)
        
        XCTAssertEqual(sut.notesCount, 4)
    }
    
    func testUpdateNote() {
        let notes: [Note] = mockData.dataFromJson(fromFileType: .notes)
        providerMock.mode = .success(notes)
        sut.getNotes()
        
        let newTitle = "Test update note!"
        let note = Note(id: 1, title: newTitle, body: "", colorHex: "")
        sut.updateNote(note)
        
        let firstNoteIndex = IndexPath(row: 0, section: 0)
        
        XCTAssertEqual(sut.getNote(at: firstNoteIndex).title, newTitle)
    }

}
