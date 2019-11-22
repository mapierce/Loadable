//
//  UIColor+shadeAlter.swift
//  Loadable
//
//  Created by Matthew Pierce on 15/11/2019.
//

import UIKit

extension UIColor {

    func darken(by percent: Float = 0.15) -> UIColor {
        return alterColor(by: percent, with: -)
    }

    func brighten(by percent: Float = 0.15) -> UIColor {
        return alterColor(by: percent, with: +)
    }

    // MARK: - Private functions

    private func alterColor(by percent: Float, with operation: (CGFloat, CGFloat) -> CGFloat) -> UIColor {
        guard percent <= 1 else { return self }
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let multiplier: CGFloat = operation(1.0, CGFloat(percent))
        return UIColor(red: red * multiplier, green: green * multiplier, blue: blue * multiplier, alpha: alpha)
    }

}
