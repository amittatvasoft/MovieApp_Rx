//
//  APIResult.swift
//  RxMovieApp_Amit
//
//  Created by mac104 on 1/10/19.
//  Copyright © 2019 mac104. All rights reserved.
//

import Foundation

enum APIResult <Value> {

    case success(value: Value)
    case failure(error: APICallError)

    // Remove it if not needed.
    init(_ f: () throws -> Value) {
        do {
            let value = try f()
            self = .success(value: value)
        } catch let error as APICallError {
            self = .failure(error: error)
        } catch let error {
            plog(error)
            self = .failure(error: APICallError(status: .failed))
        }
    }
}

