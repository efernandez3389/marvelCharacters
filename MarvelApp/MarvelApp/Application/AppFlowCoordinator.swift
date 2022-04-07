//
//  AppFlowCoordinator.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc =  CharacterListViewController(viewModel: CharacterListViewModel())

        self.navigationController.pushViewController(vc, animated: true)
    }
}
