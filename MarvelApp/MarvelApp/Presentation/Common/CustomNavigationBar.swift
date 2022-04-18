//
//  CustomNavigationBar.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

import UIKit

class CustomNavigationBar: UIView {

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 226.0/255, green: 0/255, blue: 26/255, alpha: 1.0)

        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image =  UIImage(named: "logo")
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func didMoveToWindow() {
        super.didMoveToWindow()
        
        configureViewHierarchy()
    }
    
    private func configureViewHierarchy() {
        addSubview(backgroundView)
        addSubview(logoImageView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
