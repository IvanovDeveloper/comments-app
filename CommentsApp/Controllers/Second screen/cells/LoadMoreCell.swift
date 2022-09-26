//
//  LoadMoreCell.swift
//  CommentsApp
//
//  Created by Vitalii on 26.09.2022.
//

import UIKit

class LoadMoreCell: UITableViewCell {
    private var label = UILabel(frame: .zero)
    private var activity = UIActivityIndicatorView(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemCyan
        label.text = "Load more..."
        
        contentView.addSubview(activity)
        activity.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activity.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            activity.startAnimating()
            activity.isHidden = false
            label.isHidden = true
        } else {
            activity.stopAnimating()
            activity.isHidden = true
            label.isHidden = false
        }
    }
}
