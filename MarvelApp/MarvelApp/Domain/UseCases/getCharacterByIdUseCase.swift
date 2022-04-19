//
//  getCharacterByIdUseCase.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

import Foundation

public protocol GetCharacterByIdUseCaseProtocol {
    func execute(id: Int, completionHandler: @escaping (Result<Character, Error>) -> Void)
}

public class GetCharacterByIdUseCase: GetCharacterByIdUseCaseProtocol {
    
    private let characterRepository: CharacterRepository
    
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
    
    public func execute(id: Int, completionHandler: @escaping (Result<Character, Error>) -> Void) {
        return characterRepository.fetchCharacterById(id: id, completionHandler: { result in
            completionHandler(result)
        })
    }
}
