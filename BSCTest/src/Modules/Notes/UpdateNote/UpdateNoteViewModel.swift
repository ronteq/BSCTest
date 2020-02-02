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
    
    private var note: Note
    private let noteProvider: NoteProviderProtocol
    
    init(note: Note, noteProvider: NoteProviderProtocol = NoteProvider()) {
        self.note = note
        self.noteProvider = noteProvider
    }
    
    func updateNote(title: String, body: String, color: Color) {
        note.title = title
        note.body = body
        note.colorHex = color.hex
        
        showLoader?()
        noteProvider.updateNote(note: note) { result in
            switch result {
            case .success: self.noteDidUpdate?(self.note)
            case .failure(let error): self.noteDidUpdateWithError?(error.localizedDescription)
            }
        }
    }
    
    func deleteNote() {
        showLoader?()
        noteProvider.deleteNote(id: note.id) { result in
            switch result {
            case .success: self.noteDidDelete?(self.note)
            case .failure(let error): self.noteDidUpdateWithError?(error.localizedDescription)
            }
        }
    }
    
}
