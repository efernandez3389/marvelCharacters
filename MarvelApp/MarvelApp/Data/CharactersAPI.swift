//
//  CharactersAPI.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Alamofire

enum CharactersAPI {
    case getCharacters
    case getCharacterById(id: Int)
}

extension CharactersAPI: BaseAPI {
    
    
    var baseURL: String {
        switch self {
        case .getCharacters, .getCharacterById:
            return NetworkConstants.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/characters"
        case .getCharacterById(let id):
            return "/characters/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters, .getCharacterById:
            return .get
        }
    }
    
    var parameters: Parameters? {
        let ts = String(Int(NSTimeIntervalSince1970))
        let stringToBeHashed = "\(ts)\(NetworkConstants.ParameterValues.privateKey)\(NetworkConstants.ParameterValues.publicKey)"
        let hash = stringToBeHashed.MD5()
        switch self {
        case .getCharacters, .getCharacterById:
            return [
                NetworkConstants.ParameterKeys.apiKey: NetworkConstants.ParameterValues.publicKey,
                NetworkConstants.ParameterKeys.hash: hash,
                NetworkConstants.ParameterKeys.timestamp: NSTimeIntervalSince1970
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
