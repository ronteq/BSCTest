//
//  NoteCollectionViewCell.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    var viewModel: NoteCellViewModel? {
        didSet {
            fillUI()
        }
    }
    
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let noteTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let noteSummaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray2
        return label
    }()
    
    private let noteDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addShadow()
        layer.cornerRadius = 10
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    private func setupViews() {
        let verticalStackView = UIStackView(arrangedSubviews: [noteTitleLabel, noteSummaryLabel, noteDateLabel])
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.spacing = 8
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        
        addSubview(colorView)
        addSubview(verticalStackView)
        
        colorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        colorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        noteTitleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        noteDateLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        verticalStackView.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 8).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    private func fillUI() {
        guard viewModel != nil else { return }
        colorView.backgroundColor = UIColor(hexString: viewModel!.noteColorHex)
        noteTitleLabel.text = viewModel?.noteTitle
        noteSummaryLabel.text = viewModel?.noteSummary
        noteDateLabel.text = viewModel?.noteDate
    }
    
}
