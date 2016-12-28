//
//  MaskableView.swift
//  MaskableView
//
//  Created by Kazuya Ueoka on 2016/12/28.
//
//

import UIKit
import CoreGraphics

open class MaskableView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    private var didSetup: Bool = false
    private func setup() {
        guard !self.didSetup else { return }

        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(self.tapGesture)

        self.didSetup = true
    }

    private lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
    @objc private func tap(gesture: UITapGestureRecognizer) {
        let point: CGPoint = gesture.location(in: gesture.view)
        self.masks.forEach { (mask: MaskableView.Mask) in
            if mask.frame.contains(point) {
                mask.tap?(mask)
            }
        }
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let _ = self.masks.filter({ (mask: MaskableView.Mask) -> Bool in
            return mask.frame.contains(point)
        }).first else {
            return nil
        }
        return super.hitTest(point, with: event)
    }

    public class Mask {
        public enum Shape {
            case rect
            case radius(CGFloat)
            case oval
        }

        typealias Change = (Mask) -> ()
        public typealias Tap = (Mask) -> ()
        public var frame: CGRect {
            didSet {
                self.change?(self)
            }
        }
        public var shape: Shape
        public var tap: Tap?
        var change: Change? = nil

        public init(frame: CGRect, shape: Shape = .rect) {
            self.frame = frame
            self.shape = shape
            self.tap = nil
        }

        public init(frame: CGRect, shape: Shape = .rect, tap: Tap? = nil) {
            self.frame = frame
            self.shape = shape
            self.tap = tap
        }

        public var bezierPath: UIBezierPath {
            switch self.shape {
            case .rect:
                return UIBezierPath(rect: self.frame)
            case .radius(let radius):
                return UIBezierPath(roundedRect: self.frame, cornerRadius: radius)
            case .oval:
                return UIBezierPath(ovalIn: self.frame)
            }
        }

        public var cgPath: CGPath {
            return self.bezierPath.cgPath
        }
    }
    var masks: [Mask] = []
    public func set(mask: Mask) {
        guard 0 == self.masks.count else { return }
        self.masks.append(mask)
        self.makeMaskLayer()
    }

    func makeMaskLayer() {
        let layer: CAShapeLayer = CAShapeLayer()
        layer.frame = self.bounds
        let path: UIBezierPath = UIBezierPath()
        self.masks.forEach { (mask: Mask) in
            path.append(mask.bezierPath)
        }
        path.append(UIBezierPath(rect: self.bounds))
        layer.path = path.cgPath
        layer.fillRule = kCAFillRuleEvenOdd
        self.layer.mask = layer
    }
}
