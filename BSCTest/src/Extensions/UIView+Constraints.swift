//
//  UIView+Constraints.swift
//  BSCTest
//
//  Created by Daniel Fernandez on 2/2/20.
//  Copyright © 2020 danielfcodes. All rights reserved.
//

import UIKit

enum AnchorType {
    case top(AnchorView)
    case bottom(AnchorView)
    case leading(AnchorView)
    case trailing(AnchorView)
    case width(CGFloat)
    case height(CGFloat)
    
    enum AnchorView {
        case parent
        case customView(UIView)
    }
}

extension UIView {
    
    func constraintsForAnchoring(to parentView: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: constant),
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: constant),
            self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -constant),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -constant)
        ]
    }
    
    func constraintsForAnchoring(to parentView: UIView, anchors: [AnchorType], constant: CGFloat = 0) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        for anchor in anchors {
            switch anchor {
            case .top(let anchorView):
                switch anchorView {
                case .parent:
                    constraints.append(self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: constant))
                case .customView(let view):
                    constraints.append(self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant))
                }
                
            case .leading(let anchorView):
                switch anchorView {
                case .parent:
                    constraints.append(self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: constant))
                case .customView(let view):
                    constraints.append(self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant))
                }
                
            case .bottom(let anchorView):
                switch anchorView {
                case .parent:
                    constraints.append(self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -constant))
                case .customView(let view):
                    constraints.append(self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant))
                }
                
            case .trailing(let anchorView):
                switch anchorView {
                case .parent:
                    constraints.append(self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -constant))
                case .customView(let view):
                    constraints.append(self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -constant))
                }
                
            case .width(let value):
                constraints.append(self.widthAnchor.constraint(equalToConstant: value))
                
            case .height(let value):
                constraints.append(self.heightAnchor.constraint(equalToConstant: value))
            }
        }
        
        return constraints
    }
    
}
