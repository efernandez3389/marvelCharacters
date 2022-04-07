//
//  CharacterTableViewCellViewModel.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

struct CharacterTableViewCellViewModel {
    let name: String
    let imageURL: URL?
    
    // MARK: - Methods
    init(character: Character) {
        name = character.name
        imageURL = character.thumbnail.getUrl(quality: .landscape)
    }
}
