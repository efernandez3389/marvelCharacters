//
//  AppFlowCoordinator.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import UIKit

final class AppFlowCoordinator {

    lazy var rootVc: UINavigationController = UINavigationController()

    init() {
    }

    func start() {
        rootVc.modalPresentationStyle = .fullScreen
        goToCharacterListView()
    }
    
    private func goToCharacterListView() {
        let vc =  CharacterListViewController(viewModel: CharacterListViewModel(appNavigator: self))

        self.rootVc.pushViewController(vc, animated: true)
    }
    
    private func goToCharacterDetailView(characterId: Int) {
        
        let vc = CharacterDetailViewController(viewModel: CharacterDetailViewModel(characterId: characterId))
        self.rootVc.pushViewController(vc, animated: true)
    }
}

extension AppFlowCoordinator: AppNavigator {
    func navigate(to view: NavigationView) {
        switch view {
        case .characterList:
            goToCharacterListView()
        case .characterDetails(let characterId):
            goToCharacterDetailView(characterId: characterId)
        }
    }
}
