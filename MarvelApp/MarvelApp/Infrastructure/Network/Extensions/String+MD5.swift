//
//  String+MD5.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import CryptoKit

extension String {
    /// An MD5 hash is created by taking a string of an any length and encoding it into a 128-bit fingerprint.
    func MD5() -> String {
//        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
//
//        return digest.map {
//            String(format: "%02hhx", $0)
//        }.joined()
        
        guard let data = self.data(using: .utf8) else { return String() }
        let apiHash = Insecure.MD5.hash(data: data)
        return apiHash.map { String(format: "%02hhx", $0) }.joined()
    }
}
