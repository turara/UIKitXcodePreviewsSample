//
//  ViewController.swift
//  UIKitXcodePreviewsSample
//
//  Created by Turara on 2020/08/27.
//  Copyright © 2020 Turara. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    var presenter: PresenterInput!
    
    private let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "No Data."
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseIdentifier)
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noDataLabel)
        view.addSubview(tableView)
        title = "Stationary List"
        
        navigationItem.rightBarButtonItem = .init(title: "Fetch", style: .plain, target: self, action: #selector(didPushFetchButton))
        
        NSLayoutConstraint.activate([
            noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func didPushFetchButton() {
        presenter.didPushFetchButton()
    }

}

extension ViewController: PresenterOutput {
    func updateData(_ data: [CellProp]) {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = presenter?.data.count ?? 0
        tableView.isHidden = count == 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseIdentifier, for: indexPath)
        (cell as? MyTableViewCell)?.configure(with: presenter.data[indexPath.row])
        return cell
    }
}

#if DEBUG

final class PresenterStub: PresenterInput {
    weak var view: PresenterOutput!
    
    var data: [CellProp] = []
    
    private let set1: [CellProp] = [
        ("Pencil 1", .pencil),
        ("Scribble 1", .scribble),
        ("Scissors 1", .scissors),
    ]
    
    private let set2: [CellProp] = [
        ("Pencil 2", .pencil),
        ("Scribble 3", .scribble),
        ("Scissors 2", .scissors),
        ("Scissors 3", .scissors),
        ("Scissors 4", .scissors),
    ]

    func didPushFetchButton() {
        data = set1
        data = set1 + set2
        view.updateData(data)
    }
}

import SwiftUI

struct ViewController_Wrapper: UIViewControllerRepresentable {
    var presenter: PresenterStub
    
    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController()
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
    
    func updateUIViewController(_ vc: ViewController, context: Context) {
        presenter.didPushFetchButton()
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = PresenterStub()
        return ViewController_Wrapper(presenter: presenter)
    }
}

#endif
