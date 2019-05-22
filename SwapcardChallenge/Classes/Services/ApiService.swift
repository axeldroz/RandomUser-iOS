//
//  apiService.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 13/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiService {
    func fetchUsers(vc: UsersListVC, success: (() -> Void)? = nil, error: ((Int, String) -> Void)? = nil) {
        let params = [
            "results" : "10",
            "page" : "1"
            ] as [String : String]
        
        let headers = [
            "Content-Type": "application/json"
        ]
         
         let request = NSMutableURLRequest(url: NSURL(string: "https://randomuser.me/api/?results=10&page=1")! as URL,
         cachePolicy: .useProtocolCachePolicy,
         timeoutInterval: 10.0)
         request.httpMethod = "GET"
         request.allHTTPHeaderFields = headers
         
         let session = URLSession.shared
         let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, errorResponse) -> Void in
            if (error != nil) {
                print("Client error")
            } else {
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    if let cb = error {
                        let body = String(data: data!, encoding: String.Encoding.utf8) ?? ""
                        cb(errorResponse!._code, body)
                    }
                    return
                }
                
                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    //let jsonData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions()) as Data
                    //print("Data = ", data)
                    //let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let json = JSON(data) as JSON
                    print("Json = ", json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    vc.models = try decoder.decode([UserModel].self, from : json as Data)
                        //var userModel = UserModel(gender: json["gender"].stringValue as! String, name: json["name"] as! NameModel, email: json["email"] as! String, picture: json["picture"] as! PictureModel)
                    print(vc.models)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
                
                //var userModel = UserModel(gender: json["gender"], name: json["name"], email: json["email"], picture: json["picture"])
         
            }
         })
         
         dataTask.resume()
        

    }

}
