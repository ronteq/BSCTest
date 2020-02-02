//
//  ColorsViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/30/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

protocol ColorsViewControllerDelegate: class {
    func colorsViewControllerDelegate(didSelectColor color: Color)
}

class ColorsViewController: UIViewController {
    
    weak var delegate: ColorsViewControllerDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: ColorTableViewCell.identifier)
        return tableView
    }()
    
    private let viewModel: ColorsViewModel
    
    init(viewModel: ColorsViewModel) {
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
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        NSLayoutConstraint.activate(tableView.constraintsForAnchoring(to: view))
    }
    
}

extension ColorsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let color = viewModel.getColor(at: indexPath)
        delegate?.colorsViewControllerDelegate(didSelectColor: color)
        dismiss(animated: true, completion: nil)
    }
    
}

extension ColorsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.colorsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColorTableViewCell.identifier, for: indexPath) as? ColorTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
    
}
