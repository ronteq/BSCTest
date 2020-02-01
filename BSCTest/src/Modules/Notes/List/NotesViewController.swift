//
//  NotesViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, Loadable {
    
    var containerLoader: ContainerLoader?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
        cv.backgroundColor = .systemGray6
        return cv
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(viewModel, action: #selector(viewModel.getNotes), for: .valueChanged)
        return refreshControl
    }()
    
    private let viewModel: NotesViewModel
    
    init(viewModel: NotesViewModel) {
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
        startLoading()
        viewModel.getNotes()
    }
    
    private func initialSetup() {
        // TODO: Localized
        view.backgroundColor = .systemGray6
        title = "Notes"
        setupTableView()
        addBarButtons()
    }
    
    private func setupTableView() {
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addBarButtons() {
        let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNotePressed))
        navigationItem.rightBarButtonItems = [addTaskButton]
    }
    
    private func makeBindings() {
        viewModel.notesDidLoad = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.stopLoading()
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.notesDidLoadWithError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.stopLoading()
                self?.createAlert(withMessage: errorMessage)
            }
        }
    }
    
    @objc
    private func addNotePressed() {
        let addNoteViewModel = AddNoteViewModel(nextId: viewModel.notesCount)
        let addNoteViewController = AddNoteViewController(viewModel: addNoteViewModel)
        addNoteViewController.delegate = self
        present(BscNavigationController(rootViewController: addNoteViewController), animated: true, completion: nil)
    }
    
    private func showDetailNote(at indexPath: IndexPath) {
        let note = viewModel.getNote(at: indexPath)
        let updateNoteViewModel = UpdateNoteViewModel(note: note)
        let updateNoteViewController = UpdateNoteViewController(viewModel: updateNoteViewModel)
        updateNoteViewController.delegate = self
        navigationController?.pushViewController(updateNoteViewController, animated: true)
    }
    
}

extension NotesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.notesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identifier, for: indexPath) as? NoteCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.getNoteCellViewModel(at: indexPath)
        return cell
    }
    
}

extension NotesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let halfScreenWidth = screenWidth / 2
        return CGSize(width: halfScreenWidth - 32, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailNote(at: indexPath)
    }
    
}

extension NotesViewController: AddNoteViewControllerDelegate {
    
    func addNoteViewControllerDidCreateNote(_ note: Note) {
        viewModel.addNote(note)
        let indexPath = IndexPath(row: viewModel.notesCount - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
    
}

extension NotesViewController: UpdateNoteViewControllerDelegate {
    
    func updateNoteViewControllerDidDelete(_ note: Note) {
        viewModel.deleteNote(note)
        collectionView.reloadData()
    }
    
    func updateNoteViewControllerDidUpdate(_ note: Note) {
        viewModel.updateNote(note)
        collectionView.reloadData()
    }
    
}
