//
//  AddNoteViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Amazing title for your note"
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.secondaryColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: AddNoteViewModel
    
    init(viewModel: AddNoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        // TODO: Localized
        view.backgroundColor = .systemGray6
        title = "Add a note"
        addBarButtons()
        setupViews()
    }
    
    private func addBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
    }
    
    private func setupViews() {
        let verticalStackView = UIStackView(arrangedSubviews: [titleTextField, bodyTextView])
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        view.addSubview(verticalStackView)
        
        titleTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        bodyTextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3).isActive = true
        
        verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
        view.addSubview(saveButton)
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
    }
    
    @objc
    private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func saveButtonPressed() {
        // TODO: Make some validations
        viewModel.saveNote(title: titleTextField.text ?? "", body: bodyTextView.text)
    }
    
}
