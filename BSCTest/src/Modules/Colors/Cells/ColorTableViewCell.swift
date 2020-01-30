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
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        
        colorView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func fillUI() {
        nameLabel.text = viewModel?.color.name
        colorView.backgroundColor = UIColor(hexString: viewModel?.color.hex ?? "")
    }
    
}
