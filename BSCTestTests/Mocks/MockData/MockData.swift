//
//  MockData.swift
//  BSCTestTests
//
//  Created by Daniel Fernandez on 2/2/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//
import Foundation

class MockData {
    
    enum FileType: String {
        case notes
        case noData
    }
    
    func dataFromJson<T: Decodable>(fromFileType fileType: FileType) -> T {
        let jsonData = readJson(fromFileType: fileType)
        let object = try! JSONDecoder().decode(T.self, from: jsonData)
        return object
    }
    
    private func readJson(fromFileType fileType: FileType) -> Data {
        let testBundle = Bundle(for: type(of: self))
        guard let file = testBundle.url(forResource: fileType.rawValue, withExtension: "json") else {
            fatalError("🛑 No File in Bundle")
        }
        
        let data = try! Data(contentsOf: file)
        return data
    }
 
}
