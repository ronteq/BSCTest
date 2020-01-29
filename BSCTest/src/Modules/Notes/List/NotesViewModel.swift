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
    
    private var notes: [String] = []
    
    @objc
    func getNotes() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.notes = [
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vel augue arcu. Sed varius viverra dolor, eu rhoncus felis consequat non. Vivamus congue ligula et fringilla lobortis. In id pulvinar lectus, nec dapibus felis. In non nisl pretium, pellentesque eros quis, congue eros. Vivamus quis tempus lacus. Sed urna quam, aliquam id aliquet in, venenatis fringilla urna. Integer rhoncus ultrices nisl. Sed facilisis imperdiet velit. Ut ut tempus nisl. Vivamus ullamcorper, eros eu vestibulum dapibus, mauris libero luctus lectus, ac sagittis arcu metus sit amet nisl.",
                "Aliquam sit amet interdum urna. Pellentesque sagittis auctor mi, in laoreet nunc mattis et. Maecenas in lacinia arcu. Aliquam placerat orci ac turpis tincidunt, blandit consectetur nunc hendrerit. Vestibulum dapibus, eros sed ultricies pretium, nibh ligula rutrum nibh, a molestie odio dui eu est. Nam consectetur eu sem eu sagittis. Integer luctus ex iaculis, tincidunt justo vitae, suscipit velit. Donec varius dictum euismod. Etiam vehicula libero sit amet tortor malesuada sodales sit amet quis tortor. Quisque id iaculis nisl. Sed gravida dolor eu lorem fermentum, vel sagittis libero gravida. Donec eleifend porta est, eu consectetur erat lobortis quis. Etiam pharetra vulputate neque, at porttitor risus tempus ut. Ut eget faucibus nunc. Integer in consequat nunc.",
                "Nullam eget arcu varius, ullamcorper elit malesuada, faucibus massa. Phasellus vitae arcu fermentum, feugiat mi vitae, commodo neque. Duis id iaculis nunc, ac interdum neque. Phasellus ultricies tristique elit sed blandit. Etiam ac finibus quam, vitae molestie est. Mauris blandit accumsan fermentum. Etiam non lorem felis."
            ]
            self.notesDidLoad?()
        }
    }
    
    func getNoteCellViewModel(at indexPath: IndexPath) -> NoteCellViewModel {
        return NoteCellViewModel(note: notes[indexPath.row])
    }
    
}
