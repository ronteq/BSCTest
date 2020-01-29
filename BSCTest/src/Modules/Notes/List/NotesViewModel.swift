//
//  NotesViewModel.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

class NotesViewModel {
    
    var notesCount: Int { notes.count }
    var notesDidLoad: (() -> Void)?
    var notesDidLoadWithError: ((String) -> Void)?
    
    private var notes: [Note] = []
    private let noteProvider: NoteProvider
    
    init(noteProvider: NoteProvider = NoteProvider()) {
        self.noteProvider = noteProvider
    }
    
    @objc
    func getNotes() {
        noteProvider.getNotes { result in
            switch result {
            case .success(let notes):
                self.notes = notes
                self.notesDidLoad?()
            case .failure(let error):
                self.notesDidLoadWithError?(error.localizedDescription)
            }
        }
    }
    
    func getNoteCellViewModel(at indexPath: IndexPath) -> NoteCellViewModel {
        return NoteCellViewModel(note: notes[indexPath.row])
    }
    
}
