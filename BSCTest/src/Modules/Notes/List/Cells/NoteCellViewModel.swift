//
//  NoteCellViewModel.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

class NoteCellViewModel {
    
    var noteSummary: String { note.getFirst24Characters() }
    
    private let note: String
    
    init(note: String) {
        self.note = note
    }
    
}
