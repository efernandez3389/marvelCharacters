//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public enum ThumbnailQuality: String {
    case landscape = "/landscape_medium"
    case portrait = "/portrait_medium"
    case square = "/standard_medium"
    case fullSize = ""
}

public struct Thumbnail: Codable {
    let path: String
    let fileExtension: String
    
    public func getUrl(quality: ThumbnailQuality) -> URL? {
        let httpsPath = "https" + path.dropFirst(4) + quality.rawValue
        return URL(string: "\(httpsPath).\(fileExtension)")
    }
}

extension Thumbnail {
    public enum CodingKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
}
