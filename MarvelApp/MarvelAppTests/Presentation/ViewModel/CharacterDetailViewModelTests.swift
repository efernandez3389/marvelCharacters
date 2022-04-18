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
    
    let characters: CharactersAPIResponse = {
        CharactersAPIResponse(
            data: CharactersData(
                results: [
                Character(id: 123, name: "Name 1", description: "Desc 1", thumbnail: Thumbnail(path: "path", fileExtension: "png"))
                ]
            )
        )
    }()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_whenFetchCharacterById_thenViewModelContainsOneCharacter() {
        // given
        let getCharacterByIdUseCaseMock = GetCharacterByIdUseCaseMock()
        getCharacterByIdUseCaseMock.expectation = self.expectation(description: "contains two characters")
        getCharacterByIdUseCaseMock.characters = characters
        let viewModel = CharacterDetailViewModel(characterId: 123, getCharacterByIdUseCase: getCharacterByIdUseCaseMock)
        
        // when
        viewModel.getCharacterById()
        
        //  then
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(try viewModel._characters.value().count, 1)
        XCTAssertEqual(try viewModel._characters.value().first?.id, characters.data.results.first?.id)
        XCTAssertEqual(try viewModel._characters.value().first?.name, characters.data.results.first?.name)
        XCTAssertEqual(try viewModel._characters.value().first?.description, characters.data.results.first?.description)
        XCTAssertEqual(try viewModel._characters.value().first?.thumbnail.path, characters.data.results.first?.thumbnail.path)
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
        XCTAssertEqual(try viewModel._characters.value().count, 0)
        XCTAssertNotNil(viewModel.error)
    }
}
