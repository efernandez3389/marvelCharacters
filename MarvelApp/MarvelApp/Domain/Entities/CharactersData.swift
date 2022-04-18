//
//  CharactersData.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public struct CharactersData: Codable {
    public let results: [Character]
    
    public init(results: [Character]) {
        self.results = results
    }
}
