//
//  ToggleKeyboardViewController.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/30/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

class ToggleKeyboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDissmisKeyboardRecognizer()
    }
    
    private func addDissmisKeyboardRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

}
