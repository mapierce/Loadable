//
//  UIView+Fill.swift
//  Loadable_Example
//
//  Created by Matthew Pierce on 18/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToParent() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: superView,
                                         attribute: .leading,
                                         multiplier: 1.0,
                                         constant: 0)
        let trailing = NSLayoutConstraint(item: self,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: superView,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: 0)
        let top = NSLayoutConstraint(item: self,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: superView,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 0)
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: superView,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0)
        superView.addConstraints([leading, trailing, top, bottom])
    }
    
}
