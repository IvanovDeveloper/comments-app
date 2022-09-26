//
//  SecondController.swift
//  CommentsApp
//
//  Created by Vitalii on 24.09.2022.
//

import UIKit
import SnapKit

class SecondController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var viewModel: FilteredViewModel
    private var pagination = Pagination.default
    
    // MARK: - 
    init(viewModel: FilteredViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CommentCell.self, forCellReuseIdentifier: "cell")
        tableView.register(LoadMoreCell.self, forCellReuseIdentifier: "loadMoreCell")
    }
}

extension SecondController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.dataSource(pagination: pagination).count + (viewModel.isPosibleToLoadMore(pagination: pagination) ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = "cell"
        if indexPath.item == viewModel.dataSource(pagination: pagination).count {
            identifier = "loadMoreCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let cell = cell as? CommentCell {
            cell.update(with: viewModel.item(by: indexPath))
        }

        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == viewModel.dataSource(pagination: pagination).count {
            self.pagination = Pagination(page: self.pagination.page + 1, offset: pagination.offset)
            // delay for showing activity indicator
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                self?.tableView.reloadData()
            })
            
        }
    }
}
