//
//  NetworkManagerTests.swift
//  BSCTestTests
//
//  Created by Daniel Fernandez on 2/2/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import XCTest
@testable import BSCTest

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var urlSessionManagerMock: URLSessionManagerMock!
    
    override func setUp() {
        super.setUp()
        urlSessionManagerMock = URLSessionManagerMock()
        sut = NetworkManager(urlSessionManager: urlSessionManagerMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        urlSessionManagerMock = nil
    }
    
    
    
}
