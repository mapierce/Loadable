//
//  ControlConfig.swift
//  Loadable_Example
//
//  Created by Matthew Pierce on 18/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class ControlConfig {

    let title: String
    let progress: Progress
    var animate: Bool
    var showPercentage: Bool
    var clearOnComplete: Bool
    
    init(title: String, progress: Progress, animate: Bool, showPercentage: Bool, clearOnComplete: Bool) {
        self.title = title
        self.progress = progress
        self.animate = animate
        self.showPercentage = showPercentage
        self.clearOnComplete = clearOnComplete
    }
    
}
