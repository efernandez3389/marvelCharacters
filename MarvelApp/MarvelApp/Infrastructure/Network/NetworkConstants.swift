//
//  NetworkConstants.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Foundation

struct NetworkConstants {
    
    static let baseURL = "https://gateway.marvel.com:443/v1/public"
    
    struct ParameterKeys {
        static let apiKey = "apikey"
        static let hash = "hash"
        static let timestamp = "ts"
    }
    
    struct ParameterValues {
        static let publicKey = "9912bd46b9713f4e05e96ff83dc4ed59"
        static let privateKey = "feff681800a61c677e937e5be47c04cc4d3a4e78"
    }
}
