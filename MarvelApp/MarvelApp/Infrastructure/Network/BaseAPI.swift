//
//  BaseAPIRouter.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 5/4/22.
//

import Foundation
import Alamofire

public protocol BaseAPI {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
    var headers: [String: String]? {get}
}
