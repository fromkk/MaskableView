//
//  AnimationMaskableView.swift
//  MaskableView
//
//  Created by Kazuya Ueoka on 2016/12/28.
//
//

import UIKit
import CoreGraphics

open class AnimationMaskableView: MaskableView {
    public typealias AnimationCompletion = () -> ()
    public enum AnimationTiming {
        case `default`
        case linear
        case easeIn
        case easeOut
        case easeInOut
        var function: CAMediaTimingFunction {
            switch self {
            case .default:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
            case .linear:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case .easeIn:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case .easeOut:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case .easeInOut:
                return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            }
        }
    }

    // Mask
    var from: MaskableView.Mask?
    var to: MaskableView.Mask?
    public func add(from: MaskableView.Mask, to: MaskableView.Mask) {
        self.from = from
        self.to = to
        self.masks.append(to)
        self.makeMaskLayer()
    }

    // Animation
    public var duration: CFTimeInterval = 0.0
    public var delay: CFTimeInterval = 0.0
    public var timing: AnimationTiming = AnimationTiming.default
    public var animationCompletion: AnimationCompletion?
    public var repeatCount: Float = 0.0
    public var repeatDuration: CFTimeInterval = 0.0
    public var autoreverse: Bool = false

    private var basePath: UIBezierPath { return UIBezierPath(roundedRect: self.bounds, cornerRadius: 0.0) }
    override func makeMaskLayer() {
        guard let from: MaskableView.Mask = self.from, let to: MaskableView.Mask = self.to else { return }

        let layer: CAShapeLayer = CAShapeLayer()
        layer.frame = self.bounds

        let fromPath: UIBezierPath = UIBezierPath()
        fromPath.append(from.bezierPath)
        fromPath.append(self.basePath)

        let toPath: UIBezierPath = UIBezierPath()
        toPath.append(to.bezierPath)
        toPath.append(self.basePath)

        layer.path = fromPath.cgPath

        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            self?.animationCompletion?()
        }

        let animation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        animation.duration = self.duration
        animation.beginTime = CACurrentMediaTime() + self.delay
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.timingFunction = self.timing.function
        animation.repeatCount = self.repeatCount
        animation.repeatDuration = self.repeatDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        animation.autoreverses = self.autoreverse
        layer.add(animation, forKey: nil)
        layer.fillRule = kCAFillRuleEvenOdd
        self.layer.mask = layer

        CATransaction.commit()
    }
}
