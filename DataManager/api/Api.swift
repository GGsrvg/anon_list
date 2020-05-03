//
//  Api.swift
//  DataManager
//
//  Created by GGsrvg on 03.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import Foundation
import Combine

fileprivate let url = "http://stage.apianon.ru:3000"

final public class Api {
    static let shared = Api()
    
    private init(){}
    
    private func fetch(_ method: String, getParams: String) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "\(url)/\(method)\(getParams)")!)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw ApiError.unknown
                }
                return data
            })
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                } else {
                    return ApiError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
     public func getPosts(first: Int, after: String, orderBy: OrderBy) -> AnyPublisher<Posts, Error>  {
        fetch("fs-posts/v1/posts", getParams: "?first=\(first)&after=\(after)&orderBy=\(orderBy)")
            .decode(type: Posts.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

public enum OrderBy: String{
    case mostPopular = "mostPopular"
    case mostCommented = "mostCommented"
    case createdAt = "createdAt"
}
