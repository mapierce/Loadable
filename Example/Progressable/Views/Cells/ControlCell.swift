//
//  ControlCell.swift
//  Loadable_Example
//
//  Created by Matthew Pierce on 18/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ControlCell: UITableViewCell {
    
    @IBOutlet private weak var controlView: ControlView!
    
    // MARK: - Public functions
    
    func setup(with config: ControlConfig, view: UIView) {
        controlView.show(with: config, view: view)
    }
    
}
