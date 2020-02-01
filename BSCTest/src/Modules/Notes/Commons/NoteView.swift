//
//  NoteView.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/30/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

protocol NoteViewDelegate: class {
    func noteViewDidSelectChangeColor()
    func noteViewDidSave(title: String, body: String, color: Color)
}

class NoteView: UIView {
    
    weak var delegate: NoteViewDelegate?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.placeholder = "Amazing title for your note" // TODO: localize
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: currentColor.hex)
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
        textView.autocorrectionType = .no
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
    
    private var bodyTextViewHeightConstraint: NSLayoutConstraint!
    private var isObservingKeyboard = false
    
    private enum UIProperties {
        static let margin: CGFloat = 24
        static let buttonHeight: CGFloat = 44
        
    }
    
    private var currentColor: Color = Color(name: "Trivial", hex: "#000000") {
        didSet {
            colorView.backgroundColor = UIColor(hexString: currentColor.hex)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isObservingKeyboard {
            beginObservingKeyboard()
            bodyTextView.becomeFirstResponder()
        }
    }
    
    deinit {
        endObservingKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setTitle(_ title: String) {
        titleTextField.text = title
    }
    
    func setBody(_ body: String) {
        bodyTextView.text = body
    }
    
    func setColor(_ color: Color) {
        currentColor = color
    }
    
    func setColorHex(_ hex: String) {
        currentColor.hex = hex
    }
    
    private func beginObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        isObservingKeyboard = true
    }
    
    private func endObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        
        horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: UIProperties.margin).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIProperties.margin).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIProperties.margin).isActive = true
        
        let horizontalButtonsStackView = UIStackView(arrangedSubviews: [changeColorButton, saveButton])
        horizontalButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalButtonsStackView.alignment = .fill
        horizontalButtonsStackView.distribution = .fillEqually
        horizontalButtonsStackView.axis = .horizontal
        horizontalButtonsStackView.spacing = 16
        addSubview(horizontalButtonsStackView)
        
        changeColorButton.heightAnchor.constraint(equalToConstant: UIProperties.buttonHeight).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: UIProperties.buttonHeight).isActive = true
        
        horizontalButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIProperties.margin).isActive = true
        horizontalButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIProperties.margin).isActive = true
        horizontalButtonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIProperties.margin).isActive = true
        
        addSubview(bodyTextView)
        bodyTextView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: UIProperties.margin).isActive = true
        bodyTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIProperties.margin).isActive = true
        bodyTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIProperties.margin).isActive = true
            
        let bodyTextViewBottomConstraint = bodyTextView.bottomAnchor.constraint(lessThanOrEqualTo: horizontalButtonsStackView.topAnchor, constant: -UIProperties.margin)
        bodyTextViewBottomConstraint.priority = UILayoutPriority(1000)
        bodyTextViewBottomConstraint.isActive = true
        
        bodyTextViewHeightConstraint = bodyTextView.heightAnchor.constraint(equalToConstant: 10000)
        bodyTextViewHeightConstraint.priority = UILayoutPriority(500)
        bodyTextViewHeightConstraint.isActive = true
    }
    
    @objc
    private func saveButtonPressed() {
        // TODO: Make some validations
        delegate?.noteViewDidSave(title: titleTextField.text ?? "", body: bodyTextView.text, color: currentColor)
    }
    
    @objc
    private func changeColorButtonPressed() {
        delegate?.noteViewDidSelectChangeColor()
    }
    
    @objc
    private func keyboardWillShow(sender: Notification) {
        if let userInfo = sender.userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = UIApplication.shared.windows.first {
            
            let bottomPadding = window.safeAreaInsets.bottom
            let diff = keyboardSize.height - bottomPadding - UIProperties.margin - UIProperties.margin - UIProperties.buttonHeight - 8
            bodyTextViewHeightConstraint.constant = bodyTextView.frame.height - diff
        }
    }
    
    @objc
    private func keyboardWillHide() {
        bodyTextViewHeightConstraint.constant = 1000
    }
    
}

extension NoteView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.setContentOffset(CGPoint.zero, animated: true)
    }
    
}
