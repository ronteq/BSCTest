//
//  ColorTableViewCell.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/30/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    var viewModel: ColorCellViewModel? {
        didSet {
            fillUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        addSubview(nameLabel)
        addSubview(colorView)
        
        NSLayoutConstraint.activate(nameLabel.constraintsForAnchoring(to: self, anchors: [.top(.parent), .leading(.parent)], constant: 24))
        NSLayoutConstraint.activate(colorView.constraintsForAnchoring(to: self, anchors: [.top(.parent), .trailing(.parent), .width(60), .height(15)], constant: 24))
    }
    
    private func fillUI() {
        nameLabel.text = viewModel?.color.name
        colorView.backgroundColor = UIColor(hexString: viewModel?.color.hex ?? "")
    }
    
}
