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
        let viewController =  CharacterListViewController(
            viewModel: CharacterListViewModel(
                getCharactersUseCase: makeGetCharactersUseCase(),
                appNavigator: self
            )
        )

        self.rootVc.pushViewController(viewController, animated: true)
    }
    
    private func goToCharacterDetailView(characterId: Int) {
        
        let viewController = CharacterDetailViewController(
            viewModel: CharacterDetailViewModel(
                characterId: characterId,
                getCharacterByIdUseCase: makeGetCharacterByIdUseCase()
            )
        )
        self.rootVc.pushViewController(viewController, animated: true)
    }
    
    private func makeGetCharactersUseCase() -> GetCharactersUseCase {
        return GetCharactersUseCase()
    }
    
    private func makeGetCharacterByIdUseCase() -> GetCharacterByIdUseCase {
        return GetCharacterByIdUseCase()
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
