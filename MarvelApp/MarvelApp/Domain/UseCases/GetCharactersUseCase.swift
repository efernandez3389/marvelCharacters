//
//  GetCharactersUsecCase.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

protocol GetCharactersUseCaseProtocol {
    func execute(completionHandler: @escaping (Result<CharactersAPIResponse, Error>) -> Void)
}

class GetCharactersUseCase: APIService<CharactersAPI>, GetCharactersUseCaseProtocol {
    func execute(completionHandler: @escaping (Result<CharactersAPIResponse, Error>) -> Void) {
        self.fetchData(target: .getCharacters, responseClass: CharactersAPIResponse.self) { (result) in
            completionHandler(result)
        }
    }
    
    
}
