//
//  ColorsViewModel.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/30/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

class ColorsViewModel {
    
    var colorsCount: Int { colors.count }
    private var colors: [Color] = []
    
    
    init() {
        colors.append(Color(name: "Vacation", hex: "#33d236"))
        colors.append(Color(name: "Work", hex: "#FF0000"))
        colors.append(Color(name: "Personal life", hex: "#ff791e"))
        colors.append(Color(name: "Sports", hex: "#e2a0ff"))
        colors.append(Color(name: "Trivial", hex: "#000000"))
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ColorCellViewModel {
        return ColorCellViewModel(color: colors[indexPath.row])
    }
    
    func hexString(at indexPath: IndexPath) -> String {
        return colors[indexPath.row].hex
    }
    
}
