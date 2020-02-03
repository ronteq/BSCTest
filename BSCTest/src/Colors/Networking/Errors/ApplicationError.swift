//
//  ApplicationError.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

enum ApplicationError: Error, Equatable {
    case unknown
    case parse
    case network(String)

    init(fromStatusCode statusCode: Int) {
        let networkError = NetworkError(fromStatusCode: statusCode)
        switch networkError {
        case .badRequest(let message),
             .unauthorized(let message),
             .forbidden(let message),
             .notFound(let message),
             .server(let message): self = .network(message)
        case .unknown: self = .unknown
        }
    }
}

extension ApplicationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("something_went_wrong", comment: "")
        case .parse: return NSLocalizedString("parse_error", comment: "")
        case .network(let errorMessage): return errorMessage
        }
    }
}
