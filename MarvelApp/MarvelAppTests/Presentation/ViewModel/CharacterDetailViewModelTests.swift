//
//  CharacterDetailViewModelTests.swift
//  MarvelAppTests
//
//  Created by Estefania Fernandez on 18/4/22.
//

import XCTest
@testable import MarvelApp

class CharacterDetailViewModelTests: XCTestCase {
    
    private enum GetCharacterByIdUseCaseError: Error {
        case someError
    }
    
    let character: Character = {
        Character(id: 123, name: "Name 1", description: "Desc 1", thumbnail: Thumbnail(path: "path", fileExtension: "png"))
    }()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_whenFetchCharacterById_thenViewModelContainsOneCharacter() {
        // given
        let getCharacterByIdUseCaseMock = GetCharacterByIdUseCaseMock()
        getCharacterByIdUseCaseMock.expectation = self.expectation(description: "contains two characters")
        getCharacterByIdUseCaseMock.character = character
        let viewModel = CharacterDetailViewModel(characterId: 123, getCharacterByIdUseCase: getCharacterByIdUseCaseMock)
        
        // when
        viewModel.getCharacterById()
        
        //  then
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(try viewModel._characters.value()?.id, character.id)
        XCTAssertEqual(try viewModel._characters.value()?.name, character.name)
        XCTAssertEqual(try viewModel._characters.value()?.description, character.description)
        XCTAssertEqual(try viewModel._characters.value()?.thumbnail.path, character.thumbnail.path)
    }
    
    func test_whenFetchCharactersReturnsError_thenViewModelContainsError() {
        // given
        let getCharacterByIdUseCaseMock = GetCharacterByIdUseCaseMock()
        getCharacterByIdUseCaseMock.expectation = self.expectation(description: "contains two characters")
        getCharacterByIdUseCaseMock.error = GetCharacterByIdUseCaseError.someError
        let viewModel = CharacterDetailViewModel(characterId: 123, getCharacterByIdUseCase: getCharacterByIdUseCaseMock)
        
        // when
        viewModel.getCharacterById()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(try viewModel._characters.value())
        XCTAssertNotNil(viewModel.error)
    }
}
