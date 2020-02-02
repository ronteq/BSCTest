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
        colors.append(Color(name: "vacation".localize(), hex: "#33d236"))
        colors.append(Color(name: "work".localize(), hex: "#FF0000"))
        colors.append(Color(name: "personal_life".localize(), hex: "#ff791e"))
        colors.append(Color(name: "sports".localize(), hex: "#e2a0ff"))
        colors.append(Color(name: "trivial".localize(), hex: "#000000"))
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ColorCellViewModel {
        return ColorCellViewModel(color: colors[indexPath.row])
    }
    
    func getColor(at indexPath: IndexPath) -> Color {
        return colors[indexPath.row]
    }
    
}
