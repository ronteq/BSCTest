//
//  NoteCellViewModel.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

class NoteCellViewModel {
    
    var noteSummary: String { note.title.getFirst24Characters() }
    
    private let note: Note
    
    init(note: Note) {
        self.note = note
    }
    
}
