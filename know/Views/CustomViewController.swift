//
//  CustomViewController.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 06/04/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//


import UIKit

class CustomViewController: UIViewController {

    let containerView = UIView()
    let bodyLabel = UILabel()
    let stateLabel = UILabel()
    let actionButton = UIButton()
    
    var state: String!
    var body: String!
    var buttonTitle: String!
    
    let padding:CGFloat = 20
    
    init(state: String, body: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.state = state
        self.body = body
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        stateLabel.textColor = .label
        stateLabel.adjustsFontSizeToFitWidth = true
        stateLabel.minimumScaleFactor = 0.9
        stateLabel.textAlignment = .center
        stateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        stateLabel.lineBreakMode = .byTruncatingTail
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.textColor = .systemPink
        bodyLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        bodyLabel.adjustsFontSizeToFitWidth = true
        bodyLabel.minimumScaleFactor = 0.75
        bodyLabel.lineBreakMode = .byWordWrapping
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.layer.cornerRadius = 10
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.backgroundColor = .systemRed
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureBodyLabel()
        
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        
    }
    func configureTitleLabel(){
        containerView.addSubview(stateLabel)
        stateLabel.text = state
        
        NSLayoutConstraint.activate([
            stateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            stateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            stateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            stateLabel.heightAnchor.constraint(equalToConstant: 28)
          
        ])
    }
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        
        actionButton.setTitle(buttonTitle ?? "Done", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
        
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func configureBodyLabel() {
        containerView.addSubview(bodyLabel)
        bodyLabel.text = body ?? ""
        bodyLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
}

