//
//  BscColor.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 2/2/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

enum BscColor: String {
    case main
    case secondary
    case info
    case warning
}

extension UIColor {
    
    convenience init?(bscColor type: BscColor) {
        self.init(named: type.rawValue)
    }
    
    static let main = UIColor(bscColor: .main)!
    static let secondary = UIColor(bscColor: .secondary)!
    static let info = UIColor(bscColor: .info)!
    static let warning = UIColor(bscColor: .warning)!

}
