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
    
    func addNote(_ note: Note) {
        notes.append(note)
    }
    
    @objc
    func getNotes() {
        /// I do this guard because the API is always returning the same notes.
        /// Each endpoint it's independent of each other. Tha's why I prefer to just rely on the
        /// endpoint for the first time and then mantain any other action in memory on the app.
        guard notes.isEmpty else {
            self.notesDidLoad?()
            return
        }
        
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
    
    func getNote(at indexPath: IndexPath) -> Note {
        return notes[indexPath.row]
    }
    
    func deleteNote(_ note: Note) {
        notes.removeAll(where: { $0.id == note.id })
    }
    
    func updateNote(_ note: Note) {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { return }
        notes.remove(at: index)
        notes.insert(note, at: index)
    }
    
}
