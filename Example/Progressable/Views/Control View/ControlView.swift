//
//  ControlView.swift
//  Loadable_Example
//
//  Created by Matthew Pierce on 18/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ControlView: UIView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var animateSwitch: UISwitch!
    @IBOutlet private weak var showPercentageSwitch: UISwitch!
    @IBOutlet private weak var clearOnCompleteSwitch: UISwitch!
    
    private(set) var contentView: UIView!
    private let progress = Progress(totalUnitCount: 100)
    private var config: ControlConfig!
    private var subview: UIView!
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        contentView = loadView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView = loadView()
    }
    
    // MARK: - Public functions
    
    func show(with config: ControlConfig, view: UIView) {
        self.config = config
        subview = view
        containerView.addSubview(subview)
        subview.pinToParent()
        subview.layer.cornerRadius = 15.0
        titleLabel.text = config.title
        setupSwitches(with: config)
        setupViewProgress(with: config)
    }
    
    // MARK: - Actions
    
    @IBAction func increaseProgressTapped(_ sender: Any) {
        subview.monitoredProgress?.completedUnitCount += 10
        if subview.monitoredProgress!.fractionCompleted > 1 && !subview.clearOnComplete {
            subview.monitoredProgress?.completedUnitCount = 0
        }
    }
    
    @IBAction func animateSwitchFlipped(_ sender: Any) {
        config.animate = animateSwitch.isOn
        subview.animateProgress = animateSwitch.isOn
    }
    
    @IBAction func showPercentageSwitchFlipped(_ sender: Any) {
        config.showPercentage = showPercentageSwitch.isOn
        subview.showPercentage = showPercentageSwitch.isOn
    }
    
    @IBAction func clearOnCompleteSwitchFlipped(_ sender: Any) {
        config.clearOnComplete = clearOnCompleteSwitch.isOn
        subview.clearOnComplete = clearOnCompleteSwitch.isOn
    }
    
    // MARK: - Private functions
    
    private func setupSwitches(with config: ControlConfig) {
        animateSwitch.isOn = config.animate
        showPercentageSwitch.isOn = config.showPercentage
        clearOnCompleteSwitch.isOn = config.clearOnComplete
    }
    
    private func setupViewProgress(with config: ControlConfig) {
        subview.monitoredProgress = config.progress
        subview.animateProgress = config.animate
        subview.showPercentage = config.showPercentage
        subview.clearOnComplete = config.clearOnComplete
    }
    
}
