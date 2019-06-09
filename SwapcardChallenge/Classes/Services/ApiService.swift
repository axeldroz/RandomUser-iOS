//
//  apiService.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 13/05/2019.
//  Copyright © 2019 Axel Drozdzynski. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ApiService {
    func fetchUsers(number: Int, page: Int, success: (([UserModel]) -> Void)? = nil, error: ((Int, String) -> Void)? = nil) {
        
        let params = [
            "results" : 20,
            "page" : 1
            ] as [String : Any]
        
        let headers = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request("https://randomuser.me/api/?results=\(number)&page=\(page)", method: .get, parameters: params, encoding:  JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    do {
                        //let results = JSON(data)
                        //print("results = ", results)
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions()) as NSData
                        let decoder = JSONDecoder()
                        //print(jsonData)
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let root = try decoder.decode(Root.self, from : jsonData as Data)
                        if let models = root.results {
                            if let cb = success {
                                cb(models)
                            }
                        }
                    } catch let jsonError {
                        print("Failed to decode: ", jsonError)
                    }
                    
                    
                case .failure(let errorResponse):
                    let body = String(data: response.data!, encoding: String.Encoding.utf8) ?? ""
                    print("Error: \(body)")
                    
                    
                    if let cb = error {
                        cb(errorResponse._code, body)
                    }
                }
        }
    }    
}
