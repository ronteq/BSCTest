//
//  NoteCellViewModel.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

class NoteCellViewModel {
    
    var noteColorHex: String { note.colorHex }
    var noteTitle: String { note.title }
    var noteSummary: String { note.body.getFirst24Characters() }
    var noteDate: String { "29-01-2020" }
    
    private let note: Note
    
    init(note: Note) {
        self.note = note
    }
    
}
