//
//  UpdateNoteViewModel.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 2/1/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

class UpdateNoteViewModel {
    
    var noteTitle: String { note.title }
    var noteBody: String { note.body }
    var noteColorHex: String { note.colorHex }
    
    var showLoader: (() -> Void)?
    var noteDidUpdate: ((Note) -> Void)?
    var noteDidDelete: ((Note) -> Void)?
    var noteDidUpdateWithError: ((String) -> Void)?
    
    private let note: Note
    private let noteProvider: NoteProvider
    
    init(note: Note, noteProvider: NoteProvider = NoteProvider()) {
        self.note = note
        self.noteProvider = noteProvider
    }
    
    func updateNote(title: String, body: String, color: Color) {
        showLoader?()
    }
    
    func deleteNote() {
        showLoader?()
        noteProvider.deleteNote(id: note.id) { result in
            switch result {
            case .success: self.noteDidDelete?(self.note)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
}
