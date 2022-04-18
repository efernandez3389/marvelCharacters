//
//  Character.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public struct Character: Codable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    
    public init(id: Int, name: String, description: String, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}
