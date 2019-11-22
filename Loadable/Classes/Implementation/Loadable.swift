//
//  Loadable.swift
//  Loadable
//
//  Created by Matthew Pierce on 15/11/2019.
//

import UIKit

public protocol Loadable {

    var currentProgress: Float { get set }
    var monitoredProgress: Progress? { get set }
    var progressColor: UIColor { get set }
    var animateProgress: Bool { get set }
    var showPercentage: Bool { get set }
    var progressPercentageFontSize: CGFloat { get set }
    var progressPercentageFontColor: UIColor { get set }
    var clearOnComplete: Bool { get set }

}
