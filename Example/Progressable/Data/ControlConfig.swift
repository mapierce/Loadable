//
//  ControlConfig.swift
//  Progressable_Example
//
//  Created by Matthew Pierce on 18/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class ControlConfig {
    
    var progress: Progress
    var animate: Bool
    var showPercentage: Bool
    var clearOnComplete: Bool
    
    init(progress: Progress, animate: Bool, showPercentage: Bool, clearOnComplete: Bool) {
        self.progress = progress
        self.animate = animate
        self.showPercentage = showPercentage
        self.clearOnComplete = clearOnComplete
    }
    
}
