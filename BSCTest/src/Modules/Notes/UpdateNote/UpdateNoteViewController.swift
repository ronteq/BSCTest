//
//  UpdateNoteViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 2/1/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

protocol UpdateNoteViewControllerDelegate: class {
    func updateNoteViewControllerDidUpdate(_ note: Note)
    func updateNoteViewControllerDidDelete(_ note: Note)
}

class UpdateNoteViewController: ToggleKeyboardViewController, Loadable {
    
    var containerLoader: ContainerLoader?
    weak var delegate: UpdateNoteViewControllerDelegate?
    
    private lazy var noteView: NoteView = {
        let view = NoteView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private let viewModel: UpdateNoteViewModel
    
    init(viewModel: UpdateNoteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "update_note_title".localize()
        addBarButtons()
        setupViews()
        fillUI()
        makeBindings()
    }
        
    private func addBarButtons() {
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(showOptions))
    }
        
    @objc
    private func showOptions() {
        let actionSheet = UIAlertController(title: "", message: "update_note_options".localize(), preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "delete_option".localize(), style: .destructive) { _ in
            self.createAlertWithCancel(withMessage: "delete_confirmation".localize()) { _ in
                self.viewModel.deleteNote()
            }
        }
        
        let cancelAction = UIAlertAction(title: "cancel".localize(), style: .cancel, handler: nil)
        
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(noteView)
        
        noteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        noteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        noteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        noteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
    }
    
    private func fillUI() {
        noteView.setTitle(viewModel.noteTitle)
        noteView.setBody(viewModel.noteBody)
        noteView.setColorHex(viewModel.noteColorHex)
    }
    
    private func makeBindings() {
        viewModel.showLoader = { [weak self] in
            self?.startLoading()
        }
        
        viewModel.noteDidUpdate = { [weak self] note in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.navigationController?.popViewController(animated: true)
                self?.delegate?.updateNoteViewControllerDidUpdate(note)
            }
        }
        
        viewModel.noteDidDelete = { [weak self] note in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.delegate?.updateNoteViewControllerDidDelete(note)
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.noteDidUpdateWithError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.createAlert(withMessage: errorMessage)
            }
        }
    }
    
}

extension UpdateNoteViewController: NoteViewDelegate {
    
    func noteViewDidSelectChangeColor() {
        let colorsViewModel = ColorsViewModel()
        let colorsViewController = ColorsViewController(viewModel: colorsViewModel)
        colorsViewController.delegate = self
        present(colorsViewController, animated: true, completion: nil)
    }
    
    func noteViewDidSave(title: String, body: String, color: Color) {
        viewModel.updateNote(title: title, body: body, color: color)
    }
    
}

extension UpdateNoteViewController: ColorsViewControllerDelegate {
    
    func colorsViewControllerDelegate(didSelectColor color: Color) {
        noteView.setColor(color)
    }
    
}
