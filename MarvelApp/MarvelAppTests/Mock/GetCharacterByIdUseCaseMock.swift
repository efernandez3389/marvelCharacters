//
//  GetCharacterByIdUseCaseMock.swift
//  MarvelAppTests
//
//  Created by Estefania Fernandez on 18/4/22.
//

import Foundation
import MarvelApp
import XCTest

class GetCharacterByIdUseCaseMock: GetCharacterByIdUseCaseProtocol {
    
    var expectation: XCTestExpectation?
    var error: MarvelError?
    var character: Character?
    
    func execute(id: Int, completionHandler: @escaping (Result<Character, MarvelError>) -> Void) {
        if let error = error {
            completionHandler(.failure(error))
        } else {
            completionHandler(.success(character!))
        }
        
        expectation?.fulfill()
    }

}
