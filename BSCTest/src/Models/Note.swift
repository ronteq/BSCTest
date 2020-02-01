//
//  Note.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

struct EmptyObject: Decodable {
    
}

struct Note: Codable {
    let id: Int
    let title: String
    let colorHex: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    init(id: Int, title: String, body: String, colorHex: String) {
        self.id = id
        self.title = title
        self.body = body
        self.colorHex = colorHex
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        let text = try values.decode(String.self, forKey: .title)
        
        title = Self.parseTitleFromText(text)
        colorHex = "#000000"
        body = ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        
        let text = "{\(title)}\n{\(body)\n{\(colorHex)}}"
        try container.encode(text, forKey: .title)
    }
    
    static func parseTitleFromText(_ text: String) -> String {
        return text
    }
    
    func parseHexFromText(_ text: String) -> String {
        return ""
    }
    
    func parseBodyFromText(_ text: String) -> String {
        return ""
    }
}
