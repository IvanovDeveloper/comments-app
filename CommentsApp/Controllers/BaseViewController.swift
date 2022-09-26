//
//  BaseViewController.swift
//  CommentsApp
//
//  Created by Vitalii on 26.09.2022.
//

import UIKit

enum State {
    case general
    case loading
    case empty(String)
}

class BaseViewController: UIViewController {
    private var containerView = UIView(frame: .zero)
    private var activityView = UIActivityIndicatorView(style: .medium)
    private var messageLabel = UILabel(frame: .zero)
    
    var controllerState: State = .general {
        didSet {
            stateDidUpdate()
        }
    }
    
    private func stateDidUpdate() {
        switch controllerState {
        case .general:
            containerView.isHidden = true
            activityView.stopAnimating()
        case .loading:
            view.bringSubviewToFront(containerView)
            containerView.isHidden = false
            activityView.startAnimating()
        case .empty(let txt):
            containerView.isHidden = false
            activityView.stopAnimating()
            messageLabel.text = txt
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.backgroundColor = .systemGroupedBackground
        containerView.alpha = 0.8
        
        containerView.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        containerView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(15)
            make.top.greaterThanOrEqualTo(55)
        }
        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        messageLabel.textColor = .systemRed
        
        // by default content view is hidden
        containerView.isHidden = true
    }
}
