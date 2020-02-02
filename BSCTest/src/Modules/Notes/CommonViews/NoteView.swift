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
        textField.placeholder = "add_note_title_placeholder".localize()
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
        button.setTitle("change_color".localize(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.info
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(changeColorButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("save".localize(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.secondary
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
    
    private var currentColor: Color = Color(name: "trivial".localize(), hex: "#000000") {
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
        let horizontalStackView = createHorizontalStackView(withViews: [titleTextField, colorView])
        addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate(colorView.constraintsForAnchoring(to: self, anchors: [.width(60), .height(60)]))
        NSLayoutConstraint.activate(horizontalStackView.constraintsForAnchoring(to: self, anchors: [.top(.parent), .leading(.parent), .trailing(.parent)], constant: UIProperties.margin))
        
        let horizontalButtonsStackView = createHorizontalStackView(withViews: [changeColorButton, saveButton])
        horizontalButtonsStackView.distribution = .fillEqually
        addSubview(horizontalButtonsStackView)
        
        changeColorButton.heightAnchor.constraint(equalToConstant: UIProperties.buttonHeight).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: UIProperties.buttonHeight).isActive = true
        
        NSLayoutConstraint.activate(horizontalButtonsStackView.constraintsForAnchoring(to: self, anchors: [.bottom(.parent), .leading(.parent), .trailing(.parent)], constant: UIProperties.margin))
        
        addSubview(bodyTextView)
        NSLayoutConstraint.activate(bodyTextView.constraintsForAnchoring(to: self, anchors: [.top(.customView(horizontalStackView)), .leading(.parent), .trailing(.parent)], constant: UIProperties.margin))
            
        let bodyTextViewBottomConstraint = bodyTextView.bottomAnchor.constraint(lessThanOrEqualTo: horizontalButtonsStackView.topAnchor, constant: -UIProperties.margin)
        bodyTextViewBottomConstraint.priority = UILayoutPriority(1000)
        bodyTextViewBottomConstraint.isActive = true
        
        bodyTextViewHeightConstraint = bodyTextView.heightAnchor.constraint(equalToConstant: 10000)
        bodyTextViewHeightConstraint.priority = UILayoutPriority(500)
        bodyTextViewHeightConstraint.isActive = true
    }
    
    private func createHorizontalStackView(withViews views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews:views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
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
