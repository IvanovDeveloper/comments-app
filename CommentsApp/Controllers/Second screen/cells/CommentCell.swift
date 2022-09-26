//
//  CommentCell.swift
//  CommentsApp
//
//  Created by Vitalii on 26.09.2022.
//

import UIKit

class CommentCell: UITableViewCell {
    private var stackView = UIStackView(frame: .zero)
    private var bodyLabel = UILabel(frame: .zero)
    private var emailLabel = UILabel(frame: .zero)

    // MARK: -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        selectionStyle = .none
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.top.equalTo(15)
            make.bottom.trailing.equalTo(-15)
        }
        
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(emailLabel)
        
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        
        bodyLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        bodyLabel.numberOfLines = 3
        
        emailLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
    }
    
    func update(with comment: Comment) {
        bodyLabel.text = "[\(comment.id)] -- \(comment.body)"
        emailLabel.text = comment.email
    }
}
