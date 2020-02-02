//
//  NetworkError.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badRequest(String)
    case unauthorized(String)
    case forbidden(String)
    case notFound(String)
    case server(String)
    case unknown

    init(fromStatusCode statusCode: Int) {
        switch statusCode {
        case 400: self = .badRequest("bad_request_error".localize())
        case 401: self = .unauthorized("unauthorized_request_error".localize())
        case 403: self = .forbidden("forbidden_error".localize())
        case 404: self = .notFound("resource_not_found_error".localize())
        case 500: self = .server("something_went_wrong".localize())
        default: self = .unknown
        }
    }
}
