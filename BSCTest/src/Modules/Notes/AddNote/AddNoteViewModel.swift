//
//  AddNoteViewModel.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

class AddNoteViewModel {
    
    var showLoader: (() -> Void)?
    var noteDidCreate: ((Note) -> Void)?
    var noteDidCreateWithError: ((String) -> Void)?
    
    private let noteProvider: NoteProvider
    
    init(noteProvider: NoteProvider = NoteProvider()) {
        self.noteProvider = noteProvider
    }
    
    func saveNote(title: String, body: String, color: Color) {
        showLoader?()
        let note = Note(title: title, body: body, colorHex: color.hex)
        noteProvider.createNote(note: note) { result in
            switch result {
            case .success: self.noteDidCreate?(note)
            case .failure(let error): self.noteDidCreateWithError?(error.localizedDescription)
            }
        }
    }
    
}
