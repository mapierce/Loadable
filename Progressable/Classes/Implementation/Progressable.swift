//
//  Progressable.swift
//  Progressable
//
//  Created by Matthew Pierce on 15/11/2019.
//

import UIKit

public protocol Progressable {

    var currentProgress: Float { get set }
    var monitoredProgress: Progress? { get set }
    var progressColor: UIColor { get set }
    var animateProgress: Bool { get set }
    var showPercentage: Bool { get set }
    var progressPercentageFontSize: CGFloat { get set }
    var progressPercentageFontColor: UIColor { get set }
    var clearOnComplete: Bool { get set }

}

extension UIView: Progressable {

    private struct Constants {

        static var currentProgressKey = "progressableCurrentProgressKey"
        static var monitoredProgressKey = "progressableMonitoredProgressKey"
        static var progressColorKey = "progressableProgressColorKey"
        static var progressAnimateKey = "progressableAnimateKey"
        static var progressViewKey = "progressableProgressViewKey"
        static var progressObserverKey = "progressableProgressObserverKey"
        static var showPercentageKey = "progressableShowPercentageKey"
        static var percentageLabelKey = "progressablePercentageLabelKey"
        static var percentageFontSizeKey = "progressablePercentageFontSizeKey"
        static var percentageFontColorKey = "progressablePercentageFontColorKey"
        static var clearOnCompleteKey = "progressableClearOnCompleteKey"
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
        guard showPercentage else { return }
        if percentageLabel == nil {
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
