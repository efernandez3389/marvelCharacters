//
//  CharacterRepository.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 19/4/22.
//

import Foundation

final class DefaultCharacterRepository: APIService<CharactersAPI>, CharacterRepository {
    func fetchCharacters(offset: Int, completionHandler: @escaping (Result<[Character], MarvelError>) -> Void) {
        self.fetchData(target: .getCharacters(offset: offset), responseClass: CharactersAPIResponseDTO.self) { (result) in
            switch result {
            case .success(let response):
                completionHandler(.success(response.data.results.map {$0.toDomain()}))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchCharacterById(id: Int, completionHandler: @escaping (Result<Character, MarvelError>) -> Void) {
        self.fetchData(target: .getCharacterById(id: id), responseClass: CharactersAPIResponseDTO.self) { (result) in
            switch result {
            case .success(let response):
                if let character = response.data.results.first {
                    completionHandler(.success(character.toDomain()))
                } else {
                    completionHandler(.failure(MarvelError.notFound))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
