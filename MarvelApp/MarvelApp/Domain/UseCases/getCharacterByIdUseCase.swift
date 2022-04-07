//
//  getCharacterByIdUseCase.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 7/4/22.
//

import Foundation

public protocol GetCharacterByIdUseCaseProtocol {
    func execute(id: Int, completionHandler: @escaping (Result<CharactersAPIResponse, Error>) -> Void)
}

public class GetCharacterByIdUseCase: APIService<CharactersAPI>, GetCharacterByIdUseCaseProtocol {
    
    public override init() {
        super.init()
    }
    
    public func execute(id: Int, completionHandler: @escaping (Result<CharactersAPIResponse, Error>) -> Void) {
        self.fetchData(target: .getCharacterById(id: id), responseClass: CharactersAPIResponse.self) { (result) in
            completionHandler(result)
        }
    }
}
