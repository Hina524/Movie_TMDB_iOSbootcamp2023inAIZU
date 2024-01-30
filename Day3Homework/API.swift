//
//  API.swift
//  Day3Homework
//
//  Created by Hina KONISHI on 2024/01/13.
//

import SwiftUI

enum GetData{
    static func getData(completion: @escaping (Result<Data, Error>) -> Void){
        guard let apiKey = KeyManager.getValue(key: "APIkey") else {
            print("api key 取得できなかったよーん")
            return
        }
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer　\(apiKey)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse)
            completion(.success(data!))
          }
        })

        dataTask.resume()
    }
}
