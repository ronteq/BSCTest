//
//  String.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

extension String {
    
    func getFirst24Characters() -> String {
        if self.count <= 24 {
            return self
        }
        
        // TODO: Regex to see if the last character is special character
        
        return "\(String(self.prefix(24)))..."
    }
    
    func localize() -> String {
        NSLocalizedString(self, comment: "")
    }
    
}
