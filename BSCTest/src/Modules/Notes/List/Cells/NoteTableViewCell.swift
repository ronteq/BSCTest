//
//  NoteTableViewCell.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    private let noteSummaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var viewModel: NoteCellViewModel? {
        didSet {
            if viewModel != nil {
                fillUI()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
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
        addSubview(noteSummaryLabel)
        noteSummaryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        noteSummaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
    }
    
    private func fillUI() {
        noteSummaryLabel.text = viewModel?.noteSummary
    }
    
}
