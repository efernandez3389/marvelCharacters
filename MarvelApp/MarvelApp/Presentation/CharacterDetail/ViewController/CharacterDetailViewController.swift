//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class CharacterDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private let viewModel: CharacterDetailViewModel
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = Constants.Color.background
        label.textColor = Constants.Color.lightText
        label.font = UIFont.boldSystemFont(ofSize: Constants.FontSize.large)
        label.numberOfLines = 0
        return label
    }()
    
    private let characterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let customNavigationBar =  CustomNavigationBar()
    
    public init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        viewModel.fetch.onNext(())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = Constants.Color.lightBackground
        configureViewHierarchy()
        setupConstraints()
        setupBindings()
    }
    
    private func configureViewHierarchy() {
        view.addSubview(characterImageView)
        view.addSubview(activityIndicator)
        view.addSubview(characterNameLabel)
        view.addSubview(characterDescriptionLabel)
    }
    
    private func setupConstraints() {
        let layoutGuide = view.safeAreaLayoutGuide
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor)
            
        ])
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            characterNameLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 1),
            characterNameLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        characterDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            characterDescriptionLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor),
            characterDescriptionLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 16),
            characterDescriptionLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -16),
            characterDescriptionLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
            
        ])
    }
    
    private func setupBindings() {
        viewModel.isLoading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.characters.drive(onNext: {[unowned self] (characters) in
            self.characterNameLabel.text = characters?.name
            self.characterDescriptionLabel.text = characters?.description
        }).disposed(by: disposeBag)
        
        viewModel.imageURLString.drive(onNext: { (_imageURLString) in
            self.characterImageView.sd_setImage(with: URL(string: _imageURLString ?? ""))
        }).disposed(by: disposeBag)
        
        viewModel.error.drive(onNext: { (error) in
            guard !error.isEmpty else { return }
            self.showAlert(title: "Error", message: error)
        }).disposed(by: disposeBag)
    }
}
