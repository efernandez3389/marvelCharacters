//
//  GetCharactersUseCaseMock.swift
//  MarvelAppTests
//
//  Created by Estefania Fernandez on 18/4/22.
//

import Foundation
import MarvelApp
import XCTest

class GetCharactersUseCaseMock: GetCharactersUseCaseProtocol {
    
    var expectation: XCTestExpectation?
    var error: MarvelError?
    var characters: [Character]?
    
    func execute(offset: Int, completionHandler: @escaping (Result<[Character], MarvelError>) -> Void) {
        if let error = error {
            completionHandler(.failure(error))
        } else {
            completionHandler(.success(characters!))
        }
        
        expectation?.fulfill()
    }
}
