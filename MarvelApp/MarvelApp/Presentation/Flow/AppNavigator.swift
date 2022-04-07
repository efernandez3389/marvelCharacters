//
//  AppNavigator.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

public protocol AppNavigator {
    func navigate(to view: NavigationView)
}

public enum NavigationView: Equatable {
    case characterList
    case characterDetails(characterId: Int)
}
