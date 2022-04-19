//
//  CharacterRepository.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 19/4/22.
//

import Foundation

protocol CharacterRepository {
    
    func fetchCharacters(offset: Int, completionHandler: @escaping (Result<[Character], Error>) -> Void)
    func fetchCharacterById(id: Int, completionHandler: @escaping (Result<Character, Error>) -> Void)
}
