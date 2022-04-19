//
//  GetCharactersUsecCase.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public protocol GetCharactersUseCaseProtocol {
    func execute(offset: Int, completionHandler: @escaping (Result<[Character], Error>) -> Void)
}

public class GetCharactersUseCase: GetCharactersUseCaseProtocol {
    
    private let characterRepository: CharacterRepository
    
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
    
    public func execute(offset: Int, completionHandler: @escaping (Result<[Character], Error>) -> Void) {
        return characterRepository.fetchCharacters(offset: offset, completionHandler: { result in
            completionHandler(result)
        })
    }
}
