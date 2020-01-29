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
        case 400: self = .badRequest(NSLocalizedString("bad_request_error", comment: ""))
        case 401: self = .unauthorized(NSLocalizedString("unauthorized_request_error", comment: ""))
        case 403: self = .forbidden(NSLocalizedString("forbidden_error", comment: ""))
        case 404: self = .notFound(NSLocalizedString("resource_not_found_error", comment: ""))
        case 500: self = .server(NSLocalizedString("server_down_error", comment: ""))
        default: self = .unknown
        }
    }
}
