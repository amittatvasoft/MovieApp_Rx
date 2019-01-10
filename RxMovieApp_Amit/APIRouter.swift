//
//  APIRouter.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {

    case getHomeMovieList

    func asURLRequest() throws -> URLRequest {

        var method: HTTPMethod {
            switch self {
            case .getHomeMovieList:
                return .get
            }
        }

        let params: ([String: Any]?) = {
            switch self {
            case .getHomeMovieList:
                return nil
            }
        }()

        let url: URL = {

            // Add base url for the request
            let baseURL:String = {
                return "https://easy-mock.com/mock/5c19c6ff64b4573fc81a61f3/movieapp"
            }()

            // build up and return the URL for each endpoint
            let relativePath: String? = {
                switch self {
                case .getHomeMovieList:
                    return "home"
                }
            }()


            let urlWithAPIVersion = baseURL

            var url = URL(string: urlWithAPIVersion)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()

        let encoding:ParameterEncoding = {
            return URLEncoding.default
        }()

        let headers:[String:String]? = {
            return nil
        }()

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers


        return try encoding.encode(urlRequest, with: params)
    }
}
