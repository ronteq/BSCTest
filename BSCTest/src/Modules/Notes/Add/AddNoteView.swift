//
//  AddNoteView.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/30/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

protocol AddNoteViewDelegate: class {
    func addNoteDidSelectChangeColor()
    func addNoteDidSave()
}

class AddNoteView: UIView {
    
    weak var delegate: AddNoteViewDelegate?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = "Amazing title for your note" // TODO: localize
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .systemGray6
        textView.delegate = self
        return textView
    }()
    
    private lazy var changeColorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change color", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.infoColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(changeColorButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.secondaryColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        bodyTextView.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setColor(_ color: UIColor) {
        colorView.backgroundColor = color
    }
    
    private func setupViews() {
        let horizontalStackView = UIStackView(arrangedSubviews: [titleTextField, colorView])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fill
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 16
        addSubview(horizontalStackView)
        
        colorView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor, multiplier: 1).isActive = true
        
        let horizontalButtonsStackView = UIStackView(arrangedSubviews: [changeColorButton, saveButton])
        horizontalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalButtonsStackView.alignment = .fill
        horizontalButtonsStackView.distribution = .fillEqually
        horizontalButtonsStackView.axis = .horizontal
        horizontalButtonsStackView.spacing = 16
        addSubview(horizontalButtonsStackView)
        
        changeColorButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let verticalStackView = UIStackView(arrangedSubviews: [horizontalStackView, bodyTextView, horizontalButtonsStackView])
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        addSubview(verticalStackView)

        verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
    }
    
    @objc
    private func saveButtonPressed() {
        // TODO: Make some validations
        delegate?.addNoteDidSave()
    }
    
    @objc
    private func changeColorButtonPressed() {
        delegate?.addNoteDidSelectChangeColor()
    }
    
}

extension AddNoteView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textView.setContentOffset(CGPoint.zero, animated: true)
    }
    
}
