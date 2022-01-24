//
//  ApiError.swift
//  Repository
//
//  Created by @camapblue on 12/31/21.
//

import Foundation

public enum ApiError: Error {
    case unknown
    case unauthorized
}

public enum UnauthorizedError: Error {
    case tokenExpired
}
