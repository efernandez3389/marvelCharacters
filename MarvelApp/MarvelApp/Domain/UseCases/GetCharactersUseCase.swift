//
//  GetCharactersUsecCase.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public protocol GetCharactersUseCaseProtocol {
    func execute(offset: Int, completionHandler: @escaping (Result<[Character], MarvelError>) -> Void)
}

public class GetCharactersUseCase: GetCharactersUseCaseProtocol {
    
    private let characterRepository = DefaultCharacterRepository()
        
    public func execute(offset: Int, completionHandler: @escaping (Result<[Character], MarvelError>) -> Void) {
        return characterRepository.fetchCharacters(offset: offset, completionHandler: { result in
            completionHandler(result)
        })
    }
}
