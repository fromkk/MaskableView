//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import MaskableView

let redView: UIView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 375.0, height: 667.0)))
redView.backgroundColor = UIColor.red

let maskView: MultiMaskableView = MultiMaskableView(frame: redView.bounds)
maskView.backgroundColor = UIColor(white: 0.0, alpha: 0.50)

let mask1: MultiMaskableView.Mask = MultiMaskableView.Mask(frame: CGRect(origin: CGPoint(x: 50.0, y: 50.0), size: CGSize(width: 100.0, height: 60.0)), shape: MultiMaskableView.Mask.Shape.radius(10.0)) { (mask: MultiMaskableView.Mask) in
    print("tapped mask1")
}

maskView.add(mask: mask1)
maskView.add(maskFrame: CGRect(origin: CGPoint(x: 50.0, y: 200.0), size: CGSize(width: 50.0, height: 100.0)), shape: MultiMaskableView.Mask.Shape.radius(4.0)) { (mask: MultiMaskableView.Mask) in
    print("tapped mask 2")
}
redView.addSubview(maskView)

PlaygroundPage.current.liveView = redView
