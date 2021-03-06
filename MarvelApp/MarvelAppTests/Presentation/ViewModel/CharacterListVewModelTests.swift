//
//  CharacterListVewModelTests.swift
//  MarvelAppTests
//
//  Created by Estefania Fernandez on 18/4/22.
//

import XCTest
@testable import MarvelApp

class CharacterListVewModelTests: XCTestCase {
    
    let characters: [Character] = {
        [
            Character(id: 123, name: "Name 1", description: "Desc 1", thumbnail: Thumbnail(path: "path", fileExtension: "png")),
            Character(id: 321, name: "Name 2", description: "Desc 2", thumbnail: Thumbnail(path: "path2", fileExtension: "png"))
        ]
    }()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_whenFetchCharacters_thenViewModelContainsTwoCharacters() {
        // given
        let getCharactersUseCaseMock = GetCharactersUseCaseMock()
        getCharactersUseCaseMock.expectation = self.expectation(description: "contains two characters")
        getCharactersUseCaseMock.characters = characters
        let viewModel = CharacterListViewModel(getCharactersUseCase: getCharactersUseCaseMock, appNavigator: AppFlowCoordinator())
        
        // when
        viewModel.getCharacters()
        
        //  then
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(viewModel.numberOfCharacters, 2)
        
        XCTAssertEqual(viewModel.characterAtIndex(index: 0).id, characters[0].id)
        XCTAssertEqual(viewModel.characterAtIndex(index: 1).id, characters[1].id)
        
        XCTAssertEqual(viewModel.characterAtIndex(index: 0).name, characters[0].name)
        XCTAssertEqual(viewModel.characterAtIndex(index: 1).name, characters[1].name)
        
        XCTAssertEqual(viewModel.characterAtIndex(index: 0).description, characters[0].description)
        XCTAssertEqual(viewModel.characterAtIndex(index: 1).description, characters[1].description)
        
        XCTAssertEqual(viewModel.characterAtIndex(index: 0).thumbnail.path, characters[0].thumbnail.path)
        XCTAssertEqual(viewModel.characterAtIndex(index: 1).thumbnail.path, characters[1].thumbnail.path)
    }
    
    func test_whenFetchCharactersReturnsError_thenViewModelContainsError() {
        // given
        let getCharactersUseCaseMock = GetCharactersUseCaseMock()
        getCharactersUseCaseMock.expectation = self.expectation(description: "contains two characters")
        getCharactersUseCaseMock.error = MarvelError.unknown
        let viewModel = CharacterListViewModel(getCharactersUseCase: getCharactersUseCaseMock, appNavigator: AppFlowCoordinator())
        
        // when
        viewModel.getCharacters()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.numberOfCharacters, 0)
        XCTAssertNotNil(viewModel.error)
    }
}
