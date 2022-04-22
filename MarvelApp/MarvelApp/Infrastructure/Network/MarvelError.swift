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

extension MarvelError {
    var localizedErrorMessage: String {
        switch self {
        case .invalidRequest:
            return "error.invalid.request".localized
        case .parsingError:
            return "error.parsing".localized
        case .noInternet:
            return "error.no.internet".localized
        case .unauthorized:
            return "error.unauthorized".localized
        case .notFound:
            return "error.not.found".localized
        case .unknown:
            return "error.unknown".localized
        }
    }
}
