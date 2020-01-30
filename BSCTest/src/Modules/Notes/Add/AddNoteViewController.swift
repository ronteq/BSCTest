//
//  AddNoteViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

class AddNoteViewController: ToggleKeyboardViewController {
    
    private lazy var addNoteView: AddNoteView = {
        let view = AddNoteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
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
    
    @objc
    private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(addNoteView)
        
        addNoteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        addNoteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        addNoteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        addNoteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
    }
    
}

extension AddNoteViewController: AddNoteViewDelegate {
    
    func addNoteDidSelectChangeColor() {
        let colorsViewModel = ColorsViewModel()
        let colorsViewController = ColorsViewController(viewModel: colorsViewModel)
        colorsViewController.delegate = self
        present(colorsViewController, animated: true, completion: nil)
    }
    
    func addNoteDidSave(title: String, body: String, color: Color) {
        viewModel.saveNote(title: title, body: body, color: color)
    }
    
}

extension AddNoteViewController: ColorsViewControllerDelegate {
    
    func colorsViewControllerDelegate(didSelectColor color: Color) {
        addNoteView.setColor(color)
    }
    
}
