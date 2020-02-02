//
//  UIViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createAlert(withMessage message: String) {
        let alert = UIAlertController(title: "BSC", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertWithCancel(withMessage message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "BSC", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: "cancel".localize(), style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
