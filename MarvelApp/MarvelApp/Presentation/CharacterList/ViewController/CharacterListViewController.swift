//
//  ViewController.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

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
        view.backgroundColor = Constants.Color.lightBackground
        
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
        
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
    }
    
    private func setupConstraints() {
        customNavigationBar.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(Constants.Size.navigationBarHeight)
        }
        
        charactersTableView.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(customNavigationBar.snp.bottom)
        }
        
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setupBindings() {
        viewModel.isLoading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.characters.drive(onNext: {[unowned self] (_) in
            self.charactersTableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.error.drive(onNext: { (error) in
            guard !error.isEmpty else { return }
            self.showAlert(title: "common.error".localized, message: error)
        }).disposed(by: disposeBag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = Constants.Size.scrollViewOffset
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
        return Constants.Size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier,
                                      for: indexPath) as? CharacterTableViewCell
        if let cell = cell {
            cell.configure(withViewModel: viewModel.characterViewModelCellForCharacterAtIndex(index: indexPath.row))
            return cell
        }
        
        return UITableViewCell()
    }
}
