//
//  UIView+Loadable.swift
//  Pods-Loadable_Example
//
//  Created by Matthew Pierce on 15/11/2019.
//

import UIKit

extension UIView: Loadable {

    private struct Constants {

        static var currentProgressKey = "loadableCurrentProgressKey"
        static var monitoredProgressKey = "loadableMonitoredProgressKey"
        static var progressColorKey = "loadableProgressColorKey"
        static var progressAnimateKey = "loadableAnimateKey"
        static var progressViewKey = "loadableProgressViewKey"
        static var progressObserverKey = "loadableProgressObserverKey"
        static var showPercentageKey = "loadableShowPercentageKey"
        static var percentageLabelKey = "loadablePercentageLabelKey"
        static var percentageFontSizeKey = "loadablePercentageFontSizeKey"
        static var percentageFontColorKey = "loadablePercentageFontColorKey"
        static var clearOnCompleteKey = "loadableClearOnCompleteKey"
        static let fullAnimationTime: TimeInterval = 0.3
        static let animationDelayTime: TimeInterval = 1.0
        static let noAnimationTime: TimeInterval = 0.0
        static let padding: CGFloat = -8.0
        static let defaultFontSize: CGFloat = 20.0

    }

    public var currentProgress: Float {
        get { objc_getAssociatedObject(self, &Constants.currentProgressKey) as? Float ?? 0 }
        set {
            objc_setAssociatedObject(self, &Constants.currentProgressKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            let updatedWidth = CGFloat(Float(frame.width) * newValue)
            if newValue <= 1.0 {
                moveProgressBar(to: updatedWidth)
                updatePercentageLabel(to: newValue)
            }
            if clearOnComplete && newValue >= 1.0 {
                removeProgressBar()
            }
        }
    }

    public var monitoredProgress: Progress? {
        get { objc_getAssociatedObject(self, &Constants.monitoredProgressKey) as? Progress }
        set {
            objc_setAssociatedObject(self, &Constants.monitoredProgressKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            observation = monitoredProgress?.observe(\.completedUnitCount, options: .new, changeHandler: { [weak self] (progress, change) in
                self?.currentProgress = Float(progress.fractionCompleted)
            })
        }
    }

    public var progressColor: UIColor {
        get { objc_getAssociatedObject(self, &Constants.progressColorKey) as? UIColor ?? getAppropriateBackgroundColor() }
        set { objc_setAssociatedObject(self, &Constants.progressColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public var animateProgress: Bool {
        get { objc_getAssociatedObject(self, &Constants.progressAnimateKey) as? Bool ?? true }
        set { objc_setAssociatedObject(self, &Constants.progressAnimateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public var showPercentage: Bool {
        get { objc_getAssociatedObject(self, &Constants.showPercentageKey) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &Constants.showPercentageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public var progressPercentageFontSize: CGFloat {
        get { objc_getAssociatedObject(self, &Constants.percentageFontSizeKey) as? CGFloat ?? Constants.defaultFontSize }
        set { objc_setAssociatedObject(self, &Constants.percentageFontSizeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public var progressPercentageFontColor: UIColor {
        get { objc_getAssociatedObject(self, &Constants.percentageFontColorKey) as? UIColor ?? .white }
        set { objc_setAssociatedObject(self, &Constants.percentageFontColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public var clearOnComplete: Bool {
        get { objc_getAssociatedObject(self, &Constants.clearOnCompleteKey) as? Bool ?? true }
        set { objc_setAssociatedObject(self, &Constants.clearOnCompleteKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    // MARK: - Private variables

    private var progressView: UIView? {
        get { objc_getAssociatedObject(self, &Constants.progressViewKey) as? UIView }
        set { objc_setAssociatedObject(self, &Constants.progressViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var observation: NSKeyValueObservation? {
        get { objc_getAssociatedObject(self, &Constants.progressObserverKey) as? NSKeyValueObservation }
        set { objc_setAssociatedObject(self, &Constants.progressObserverKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var percentageLabel: UILabel? {
        get { objc_getAssociatedObject(self, &Constants.percentageLabelKey) as? UILabel }
        set { objc_setAssociatedObject(self, &Constants.percentageLabelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    // MARK: - Private functions

    private func moveProgressBar(to width: CGFloat) {
        if progressView == nil {
            progressView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: frame.height))
            progressView?.backgroundColor = progressColor
            addSubview(progressView!)
            sendSubviewToBack(progressView!)
            clipsToBounds = true
        }
        UIView.animate(withDuration: animateProgress ? Constants.fullAnimationTime : Constants.noAnimationTime) {
            self.progressView?.frame.size.width = width
        }
    }

    private func updatePercentageLabel(to percentage: Float) {
        if percentageLabel == nil && showPercentage {
            percentageLabel = UILabel()
            percentageLabel?.font = UIFont.systemFont(ofSize: progressPercentageFontSize, weight: .semibold)
            percentageLabel?.textColor = progressPercentageFontColor
            percentageLabel?.translatesAutoresizingMaskIntoConstraints = false
            progressView?.addSubview(percentageLabel!)
            let trailing = NSLayoutConstraint(item: percentageLabel!,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: Constants.padding)
            let bottom = NSLayoutConstraint(item: percentageLabel!,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .bottom,
                                            multiplier: 1.0,
                                            constant: Constants.padding)
            addConstraints([trailing, bottom])
        } else if percentageLabel != nil && !showPercentage {
            percentageLabel?.removeFromSuperview()
            percentageLabel = nil
        }
        percentageLabel?.text = "\(Int(percentage * 100))%"
        percentageLabel?.sizeToFit()
    }

    private func getAppropriateBackgroundColor() -> UIColor {
        guard let color = backgroundColor else { return .lightGray }
        return color.darken()
    }

    private func removeProgressBar() {
        UIView.animate(withDuration: Constants.fullAnimationTime,
                       delay: Constants.animationDelayTime,
                       options: [],
                       animations: {
            self.progressView?.alpha = 0.0
        }, completion: { _ in
            self.progressView?.removeFromSuperview()
            self.progressView = nil
            self.percentageLabel?.removeFromSuperview()
            self.percentageLabel = nil
        })
    }

}
