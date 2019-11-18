//
//  UIView+Loader.swift
//  Progressable_Example
//
//  Created by Matthew Pierce on 18/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadView<T: UIView>() -> T? {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? T else { return nil }
        view.frame = self.bounds
        addSubview(view)
        return view
    }
    
}
