//
//  GetCharactersUsecCase.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public protocol GetCharactersUseCaseProtocol {
    func execute(offset: Int, completionHandler: @escaping (Result<CharactersAPIResponse, Error>) -> Void)
}

public class GetCharactersUseCase: APIService<CharactersAPI>, GetCharactersUseCaseProtocol {
    
    public override init() {
        super.init()
    }
    
    public func execute(offset: Int, completionHandler: @escaping (Result<CharactersAPIResponse, Error>) -> Void) {
        self.fetchData(target: .getCharacters(offset: offset), responseClass: CharactersAPIResponse.self) { (result) in
            completionHandler(result)
        }
    }
}
