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
    private let charactersTableView:  UITableView =  {
        let tableView =  UITableView()
        tableView.separatorStyle =  .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public init(viewModel: CharacterListViewModel) {
        
        self.viewModel = viewModel
        viewModel.fetch.onNext(())
        super.init(nibName: nil, bundle: nil)
        title = "MArvelApp"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewHierarchy()
        setupBindings()
    }
    
    private func configureViewHierarchy()  {
        view.addSubview(charactersTableView)
        let layoutGuide = view.safeAreaLayoutGuide
        
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            charactersTableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            charactersTableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
        
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterTableViewCell")
        //charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        charactersTableView.delegate = self
        charactersTableView.dataSource = self

    }
    
    func setupBindings() {        
        viewModel.characters.drive(onNext: {[unowned self] (_) in
            self.charactersTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = 180
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height - offset) {
            //responder.tableViewDidReachEnd()
            viewModel.fetch.onNext(())
        }
    }
}


extension CharacterListViewController: UITableViewDelegate {
    
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = viewModel.characterAtIndex(index: indexPath.row)
        let cell =
        tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell",
                                      for: indexPath) as? CharacterTableViewCell
        // Sets the text of the Label in the Table View Cell
        if let cell = cell {
            cell.configure(withViewModel: CharacterTableViewCellViewModel(character: character))
            return cell
        }
    
        return UITableViewCell()
    }
    
    
}
