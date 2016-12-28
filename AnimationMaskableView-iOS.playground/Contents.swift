//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import MaskableView

let view: UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 375.0, height: 667.0)))
view.backgroundColor = UIColor.blue

let maskView: AnimationMaskableView = AnimationMaskableView(frame: view.bounds)
maskView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
maskView.duration = 2.0
maskView.delay = 1.0

maskView.add(from: MaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 1.0, height: 1.0)), shape: MaskableView.Mask.Shape.radius(1.0)), to: MaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 200.0, height: 200.0)), shape: MaskableView.Mask.Shape.radius(10.0), tap: { (mask: MaskableView.Mask) in
    print("tapped")
}))

maskView.animationCompletion = {
    print("completion")
}
view.addSubview(maskView)

PlaygroundPage.current.liveView = view
