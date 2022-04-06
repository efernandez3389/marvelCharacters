//
//  Alamofire+PromiseKit.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import Alamofire
import Foundation

class APIService<T:BaseAPI> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completionHandler: @escaping (Result<M, Error>) -> Void) {
        let method = target.method
        let headers = HTTPHeaders(target.headers ?? [:])
        let parameters = target.parameters
        
        AF.request(target.baseURL + target.path, method: method, parameters: parameters, headers: headers).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                //Status code not found
                completionHandler(.failure(NSError()))
                return
            }
            if statusCode == 200 {
                guard let jsonResponse = try? response.result.get() else {
                    //json response error
                    completionHandler(.failure(NSError()))
                    return
                }
                
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    //JsonData error
                    completionHandler(.failure(NSError()))
                    return
                }
                
                guard let responseObj = try? JSONDecoder().decode(M.self, from: jsonData) else {
                    //Response object error
                    completionHandler(.failure(NSError()))
                    return
                }
                
                completionHandler(.success(responseObj))
            } else {
                switch statusCode {
                default:
                    completionHandler(.failure(NSError()))
                }
            }
        }
    }
}
