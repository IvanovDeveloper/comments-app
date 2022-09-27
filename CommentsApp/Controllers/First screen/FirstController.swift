//
//  FirstController.swift
//  CommentsApp
//
//  Created by Vitalii on 24.09.2022.
//

import UIKit
import SnapKit

class FirstController: BaseViewController {
    private var stackView = UIStackView(frame: .zero)
    private var lowerBoundTextField = UITextField(frame: .zero)
    private var upperBoundTextField = UITextField(frame: .zero)
    private var doneButton = UIButton(type: .system)
    
    private var viewModel: CommentViewModel! // Я стараюсь избегать форсов, инициальзацию viewModel я бы вынес в init. В свою очередь отдельная фабрика бы собирал экран и подгатавливала voewModel
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupContent()
                
        viewModel = CommentViewModel()
        viewModel.updateCall = { [weak self] error in
            // delay for showing activity indicator
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                if let error {
                    self?.controllerState = .empty(error.localizedDescription)
                } else {
                    self?.controllerState = .general
                }
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lowerBoundTextField.becomeFirstResponder()
        updateDoneButtonState()
    }

    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leadingMargin.equalTo(35)
            make.top.equalTo(150)
        }
        
        stackView.addArrangedSubview(lowerBoundTextField)
        stackView.addArrangedSubview(upperBoundTextField)
        stackView.addArrangedSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
    }
    
    private func setupContent() {
        view.backgroundColor = .systemBackground
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.setCustomSpacing(15, after: upperBoundTextField)
        
        lowerBoundTextField.backgroundColor = .systemFill
        upperBoundTextField.backgroundColor = .systemFill
        
        lowerBoundTextField.borderStyle = .roundedRect
        upperBoundTextField.borderStyle = .roundedRect
        
        lowerBoundTextField.text = "1"
        lowerBoundTextField.placeholder = "min value is 1"
        upperBoundTextField.text = "500"
        upperBoundTextField.placeholder = "max value is 500"
        
//        lowerBoundTextField.delegate = self
//        upperBoundTextField.delegate = self
        lowerBoundTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        upperBoundTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        lowerBoundTextField.keyboardType = .numberPad
        upperBoundTextField.keyboardType = .numberPad
        
        doneButton.setTitle("Show comments", for: .normal)
        doneButton.setTitleColor(.systemBackground, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        doneButton.layer.cornerRadius = 6
        doneButton.backgroundColor = .systemGreen
        doneButton.addAction(UIAction(handler: { [weak self] _ in
            self?.openCommentsScreen()
        }), for: .touchUpInside)
        
        let reloadButton = UIButton(frame: .zero)
        reloadButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        reloadButton.addAction(UIAction(handler: { [weak self] _ in
            self?.controllerState = .loading
            self?.viewModel.fetchAllComments()
        }), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: reloadButton)
    }
    
    @objc private func openCommentsScreen() {
        guard let fromId = Int(lowerBoundTextField.text ?? ""), let toId = Int(upperBoundTextField.text ?? "") else {
            return
        }
        guard let filteredComments = viewModel.fetchComments(fromIndex: fromId, toIndex: toId) else {
            return
        }
        let viewModel = FilteredViewModel(comments: filteredComments)
        let controller = SecondController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension FirstController: UITextFieldDelegate {
    @objc func textChanged(_ value: UITextField) {
        updateDoneButtonState()
    }
    
    func updateDoneButtonState() {
        guard let loTxt = lowerBoundTextField.text, let upTxt = upperBoundTextField.text else {
            doneButton.isEnabled = false
            return
        }
        doneButton.isEnabled = !(loTxt.isEmpty || upTxt.isEmpty)
    }
}
