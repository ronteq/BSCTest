//
//  Loadable.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 1/29/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

protocol Loadable: class {
    var containerLoader: ContainerLoader? { get set }
    func startLoading()
    func stopLoading()
}

extension Loadable where Self: UIViewController {
    
    func startLoading() {
        containerLoader = ContainerLoader()
        containerLoader?.frame.size = CGSize(width: 80, height: 80)
        containerLoader?.center = view.center
        containerLoader?.alpha = 0.0
        view.addSubview(self.containerLoader!)
        containerLoader?.loader.startAnimating()
        
        UIView.animate(withDuration: 0.2) {
            self.containerLoader?.alpha = 1
        }
    }
    
    func stopLoading() {
        UIView.animate(withDuration: 0.2, animations: {
            self.containerLoader?.alpha = 0
        }) { _ in
            self.containerLoader?.loader.stopAnimating()
            self.containerLoader?.removeFromSuperview()
            self.containerLoader = nil
        }
    }
    
}

class ContainerLoader: UIView {
    
    var loader = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorPalette.mainColor.withAlphaComponent(0.8)
        layer.cornerRadius = 10
        clipsToBounds = true
        setupLoader()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupLoader() {
        loader.center = CGPoint(x: 40, y: 40)
        loader.hidesWhenStopped = true
        loader.style = .large
        loader.color = .white
        addSubview(loader)
    }
    
}
