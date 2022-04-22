//
//  CharacterDTO.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 22/4/22.
//

import Foundation

public struct CharacterDTO: Codable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: ThumbnailDTO
}

extension CharacterDTO {
    func toDomain() -> Character {
        return .init(id: id, name: name, description: description, thumbnail: thumbnail.toDomain())
    }
}
