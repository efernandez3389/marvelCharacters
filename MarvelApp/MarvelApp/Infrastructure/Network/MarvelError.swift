//
//  MarvelError.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

public enum MarvelError: Error {
    case parsingError
    case noInternet
    case unauthorized
    case invalidRequest
    case notFound
    case unknown
}
