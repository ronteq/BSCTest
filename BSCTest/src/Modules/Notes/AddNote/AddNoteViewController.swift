//
//  AddNoteViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

protocol AddNoteViewControllerDelegate: class {
    func addNoteViewControllerDidCreateNote(_ note: Note)
}

class AddNoteViewController: ToggleKeyboardViewController, Loadable {
    
    var containerLoader: ContainerLoader?
    weak var delegate: AddNoteViewControllerDelegate?
    
    private lazy var noteView: NoteView = {
        let view = NoteView()
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
        makeBindings()
    }
    
    private func initialSetup() {
        view.backgroundColor = .systemGray6
        title = "add_note_title".localize()
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
        view.addSubview(noteView)
        
        noteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        noteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        noteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        noteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
    }
    
    private func makeBindings() {
        viewModel.showLoader = { [weak self] in
            self?.startLoading()
        }
        
        viewModel.noteDidCreate = { [weak self] note in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.dismiss(animated: true, completion: {
                    self?.delegate?.addNoteViewControllerDidCreateNote(note)
                })
            }
        }
        
        viewModel.noteDidCreateWithError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.createAlert(withMessage: errorMessage)
            }
        }
    }
    
}

extension AddNoteViewController: NoteViewDelegate {
    
    func noteViewDidSelectChangeColor() {
        let colorsViewModel = ColorsViewModel()
        let colorsViewController = ColorsViewController(viewModel: colorsViewModel)
        colorsViewController.delegate = self
        present(colorsViewController, animated: true, completion: nil)
    }
    
    func noteViewDidSave(title: String, body: String, color: Color) {
        viewModel.saveNote(title: title, body: body, color: color)
    }
    
}

extension AddNoteViewController: ColorsViewControllerDelegate {
    
    func colorsViewControllerDelegate(didSelectColor color: Color) {
        noteView.setColor(color)
    }
    
}
