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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        return tableView
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
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
                self?.tableView.reloadData()
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
        
    }
    
    private func showDetailNote(at indexPath: IndexPath) {
        
    }
    
}

extension NotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetailNote(at: indexPath)
    }
    
}

extension NotesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as? NoteTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getNoteCellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            viewModel.deleteTask(atIndexPath: indexPath)
//            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
}
