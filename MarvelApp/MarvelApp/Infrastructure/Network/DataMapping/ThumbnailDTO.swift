//
//  File.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 22/4/22.
//

import Foundation

public struct ThumbnailDTO: Codable {
    let path: String
    let fileExtension: String
    
    public init(path: String, fileExtension: String) {
        self.path = path
        self.fileExtension = fileExtension
    }
}

extension ThumbnailDTO {
    public enum CodingKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
}

extension ThumbnailDTO {
    func toDomain() -> Thumbnail {
        return .init(path: path, fileExtension: fileExtension)
    }
}
