//
//  RequestProvider.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import Foundation

protocol RequestProvider {
  var urlRequest: URLRequest { get }
}
