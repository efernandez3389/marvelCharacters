//
//  CharactersAPI.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Alamofire

public enum CharactersAPI {
    case getCharacters(offset: Int)
    case getCharacterById(id: Int)
}

extension CharactersAPI: BaseAPI {
    
    public var baseURL: String {
        switch self {
        case .getCharacters, .getCharacterById:
            return NetworkConstants.baseURL
        }
    }
    
    public var path: String {
        switch self {
        case .getCharacters:
            return "/characters"
        case .getCharacterById(let id):
            return "/characters/\(id)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getCharacters, .getCharacterById:
            return .get
        }
    }
    
    public var parameters: Parameters? {
        let timestamp = String(Int(NSTimeIntervalSince1970))
        let stringToBeHashed = "\(timestamp)\(NetworkConstants.ParameterValues.privateKey)\(NetworkConstants.ParameterValues.publicKey)"
        let hash = stringToBeHashed.MD5()
        switch self {
        case .getCharacters(let offset):
            return [
                NetworkConstants.ParameterKeys.apiKey: NetworkConstants.ParameterValues.publicKey,
                NetworkConstants.ParameterKeys.hash: hash,
                NetworkConstants.ParameterKeys.timestamp: NSTimeIntervalSince1970,
                "offset": offset
            ]
        case .getCharacterById:
            return [
                NetworkConstants.ParameterKeys.apiKey: NetworkConstants.ParameterValues.publicKey,
                NetworkConstants.ParameterKeys.hash: hash,
                NetworkConstants.ParameterKeys.timestamp: NSTimeIntervalSince1970
            ]
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
