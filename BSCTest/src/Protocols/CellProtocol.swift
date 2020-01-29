//
//  CellProtocol.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

protocol CellProtocol: class {
    static var identifier: String { get }
}

extension CellProtocol where Self: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension CellProtocol where Self: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: CellProtocol {}
extension UICollectionViewCell: CellProtocol {}
