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

public struct Thumbnail {
    let path: String
    let fileExtension: String
    
    public init(path: String, fileExtension: String) {
        self.path = path
        self.fileExtension = fileExtension
    }
    
    public func getUrl(quality: ThumbnailQuality) -> URL? {
        let httpsPath = "https" + path.dropFirst(4) + quality.rawValue
        return URL(string: "\(httpsPath).\(fileExtension)")
    }
    
    public func getUrlString(quality: ThumbnailQuality) -> String {
        let httpsPath = "https" + path.dropFirst(4) + quality.rawValue
        return "\(httpsPath).\(fileExtension)"
    }
}
