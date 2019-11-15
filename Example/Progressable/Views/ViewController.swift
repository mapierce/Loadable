//
//  ViewController.swift
//  Progressable
//
//  Created by Matthew Pierce on 11/15/2019.
//  Copyright (c) 2019 Matthew Pierce. All rights reserved.
//

import UIKit
import Progressable

class ViewController: UIViewController {

    let progress = Progress(totalUnitCount: 50)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.monitoredProgress = progress
        view.progressColor = .green
        view.showPercentage = true
        view.progressPercentageFontColor = .black
    }

    // MARK: - Actions

    @IBAction func clickMePressed(_ sender: Any) {
        progress.completedUnitCount += 1
        if progress.completedUnitCount > progress.totalUnitCount {
            progress.completedUnitCount = 0
        }
    }

}

