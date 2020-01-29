//
//  UIView+Constraints.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraintEqual(to parent: UIView) {
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
    }
    
}
