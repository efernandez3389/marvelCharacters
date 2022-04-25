//
//  getCharacterByIdUseCase.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

import Foundation

public protocol GetCharacterByIdUseCaseProtocol {
    func execute(id: Int, completionHandler: @escaping (Result<Character, MarvelError>) -> Void)
}

public class GetCharacterByIdUseCase: GetCharacterByIdUseCaseProtocol {
    
    private let characterRepository = DefaultCharacterRepository()
        
    public func execute(id: Int, completionHandler: @escaping (Result<Character, MarvelError>) -> Void) {
        return characterRepository.fetchCharacterById(id: id, completionHandler: { result in
            completionHandler(result)
        })
    }
}
