//
//  ViewController.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterListViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private let viewModel: CharacterListViewModel
    private let charactersTableView: UITableView =  {
        let tableView =  UITableView()
        tableView.separatorStyle =  .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let customNavigationBar =  CustomNavigationBar()
    
    public init(viewModel: CharacterListViewModel) {
        
        self.viewModel = viewModel
        viewModel.fetch.onNext(())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureViewHierarchy()
        setupConstraints()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func configureViewHierarchy() {
        view.addSubview(charactersTableView)
        view.addSubview(activityIndicator)
        view.addSubview(customNavigationBar)
        
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
    }
    
    private func setupConstraints() {
        let layoutGuide = view.safeAreaLayoutGuide
        
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            charactersTableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            charactersTableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor)
        ])
    }
    
    func setupBindings() {
        viewModel.isLoading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.characters.drive(onNext: {[unowned self] (_) in
            self.charactersTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = 180
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height - offset) {
            viewModel.fetch.onNext(())
        }
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.characterSelectedAtIndex(index: indexPath.row)
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell",
                                      for: indexPath) as? CharacterTableViewCell
        if let cell = cell {
            cell.configure(withViewModel: viewModel.characterViewModelCellForCharacterAtIndex(index: indexPath.row))
            return cell
        }
        
        return UITableViewCell()
    }
}
