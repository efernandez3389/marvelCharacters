//
//  CustomNavigationBar.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

import UIKit
import SnapKit

class CustomNavigationBar: UIView {

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.background
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
        
        backgroundView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(Constants.Size.logoHeight)
            make.height.equalTo(Constants.Size.logoHeight)
            make.centerX.bottom.equalToSuperview()
        }
    }
}
