//
//  CharactersAPIResponse.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public struct CharactersAPIResponse: Codable {
    public let data: CharactersData
    
    public init(data: CharactersData) {
        self.data = data
    }
}
