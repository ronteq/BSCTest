//
//  UIView.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 2/1/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
    }

}
